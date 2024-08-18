import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/utils/gradient_line.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_type.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:sabanzuri/widgets/show_toast.dart';
import 'package:scan/scan.dart';
import 'package:velocity_x/velocity_x.dart';

class AlertScanDialog {
  static show({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String buttonText,
    bool? isBackPressedAllowed,
    required final Function(Map<String, String>) buttonClick,
    bool isDarkThemeOn = true,
    bool? isCloseButton = false,
    AlertType? type = AlertType.error,
  }) {
    //final ScanController _scanController = ScanController();
    final MobileScannerController _scanController =
        MobileScannerController(autoStart: true, detectionSpeed: DetectionSpeed.unrestricted);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) {
        AlertType alertType = type ?? AlertType.error;
        return WillPopScope(
          onWillPop: () async {
            return isBackPressedAllowed ?? true;
          },
          child: Dialog(
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            backgroundColor:
                isDarkThemeOn ? SabanzuriColors.navy : SabanzuriColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isCloseButton ?? false ? _gradientLine() : Container(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        alertTitle(title, isDarkThemeOn, alertType),
                        InkWell(
                            onTap: () {
                              _scanController.start();
                            },
                            child: const Icon(Icons.refresh,
                                color: Colors.white, size: 20)),
                      ],
                    ),
                    const HeightBox(10),
                    Container(
                      width: 300,
                      height: 250,
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          border: Border.all(color: Colors.grey, width: .5)),
                      child: MobileScanner(
                        controller: _scanController,
                        onDetect: (data) {
                          _scanController.stop();
                          try {
                            Map<String, String> proceedData = {};
                            List<Barcode> barcodes = data.barcodes;
                            String validData = barcodes[0].rawValue.toString();
                            Uri uri = Uri.dataFromString(validData.toString());
                            proceedData["couponCode"] =
                                uri.queryParameters['couponCode']!;
                            proceedData["currencyCode"] =
                                uri.queryParameters['currencyCode']!;
                            proceedData["countryCode"] =
                                uri.queryParameters['countryCode']!;

                            isInternetConnect().then((value) {
                              if (value) {
                                buttonClick(proceedData);
                              } else {
                                _scanController.start();
                                ShowToast.showToast("No Internet Available!", context,type: ToastType.ERROR);
                              }
                            });
                          } catch (e) {
                            _scanController.start();

                            print("Something Went wrong with bar code: $e");
                          }
                        },
                      ),
                    ),
                    const HeightBox(8),
                    alertSubtitle(subtitle, isDarkThemeOn),
                    const HeightBox(20),
                  ],
                ).pSymmetric(v: 20, h: 50),
              ],
            ),
          ),
        );
      },
    );
  }

  static alertIcon(bool isDarkThemeOn, AlertType type) {
    return Image.asset(
      _getImagePath(isDarkThemeOn, type),
      width: 60,
      height: 60,
    );
  }

  static alertTitle(String title, bool isDarkThemeOn, AlertType type) {
    return Expanded(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 21,
          color: _getTextColor(isDarkThemeOn, type),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  static alertSubtitle(String subtitle, bool isDarkThemeOn) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        color:
            isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.grey_blue,
        fontSize: 12.0,
      ),
    );
  }

  /*static confirmButton(VoidCallback? buttonClick, String buttonText,
      BuildContext ctx, bool isDarkThemeOn) {
    return PrimaryButton(
      width: double.infinity,
      fillDisableColor:
          isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
      fillEnableColor:
          isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
      onPressed: buttonClick != null
          ? () {
              Navigator.of(ctx).pop();
              buttonClick();
            }
          : () {
              Navigator.of(ctx).pop();
            },
      text: buttonText,
      isDarkThemeOn: isDarkThemeOn,
    );
  }*/

  /*static buttons(bool isCloseButton, VoidCallback? buttonClick,
      String buttonText, BuildContext ctx, bool isDarkThemeOn) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        isCloseButton
            ? Expanded(
                child: closeButton(ctx, isDarkThemeOn),
              )
            : const SizedBox(),
        isCloseButton ? const WidthBox(20) : const SizedBox(),
        Expanded(
          child: confirmButton(buttonClick, buttonText, ctx, isDarkThemeOn),
        ),
      ],
    );
  }*/

  static closeButton(BuildContext ctx, bool isDarkThemeOn) {
    return PrimaryButton(
      width: double.infinity / 2,
      type: ButtonType.line_art,
      fillDisableColor:
          isDarkThemeOn ? SabanzuriColors.navy : SabanzuriColors.white,
      fillEnableColor:
          isDarkThemeOn ? SabanzuriColors.navy : SabanzuriColors.white,
      onPressed: () {
        Navigator.of(ctx).pop();
      },
      text: ctx.l10n.cancel.toUpperCase(),
      isDarkThemeOn: isDarkThemeOn,
    );
  }

  static _gradientLine() {
    return const GradientLine(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    );
  }

  static _getTextColor(bool isDarkThemeOn, AlertType type) {
    Color color;
    switch (type) {
      case AlertType.success:
        color = SabanzuriColors.shamrock_green;
        break;
      case AlertType.error:
        color = SabanzuriColors.lightish_red;
        break;
      case AlertType.warning:
        color = SabanzuriColors.yellow_orange;
        break;
      case AlertType.confirmation:
        color = isDarkThemeOn
            ? SabanzuriColors.sunflower_yellow
            : SabanzuriColors.navy;
        break;
      default:
        color = SabanzuriColors.lightish_red;
    }
    return color;
  }

  static String _getImagePath(bool isDarkThemeOn, AlertType type) {
    String imagePath;
    switch (type) {
      case AlertType.success:
        imagePath = 'assets/icons/icon_success.png';
        break;
      case AlertType.error:
        imagePath = 'assets/icons/icon_error.png';
        break;
      case AlertType.warning:
        //ToDo need to change the image for warning
        imagePath = 'assets/icons/icon_success.png';
        break;
      case AlertType.confirmation:
        //ToDo need to change the image for confirmation
        imagePath = 'assets/icons/icon_confirmation.png';
        break;
      default:
        imagePath = 'assets/icons/icon_error.png';
    }
    return imagePath;
  }
}
