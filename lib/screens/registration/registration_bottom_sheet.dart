
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/otp/bloc/otp_bloc.dart';
import 'package:sabanzuri/screens/registration/bloc/registration_bloc.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sabanzuri/utils/gradient_line.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/notification.dart';

class RegistrationBottomSheet {
  static show({
    required BuildContext context,
    required String? title,
    required String mobNumber,
    required String password,
    required String currencyCode,
    required String countryCode,
    required String referCode,
    required TextEditingController referTextController,
    Color? backgroundColor,
    bool? enableDrag,
    bool? isDarkThemeOn = true,
  }) {
    final bool isDarkModeOn = isDarkThemeOn ?? true;
    TextEditingController otpController = TextEditingController();
    bool obscurePass                    = true;
    ShakeController otpShakeController  = ShakeController();
    bool isRegistrationLoading          = false;
    bool isResendOtpLoading             = false;
    final FocusNode focusNode           = FocusNode();

    bool isBackPressedAllowed           = true;

    showModalBottomSheet(
      backgroundColor: backgroundColor ??
          (isDarkModeOn ? SabanzuriColors.navy : SabanzuriColors.white),
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (BuildContext ctx) {
        return WillPopScope(
          onWillPop: () async {
            return isBackPressedAllowed;
          },
          child: MultiBlocProvider(
            providers: [
              BlocProvider<RegistrationBloc>(
                create: (context) => RegistrationBloc(),
              ),
              BlocProvider<OtpBloc>(
                create: (context) => OtpBloc(),
              ),
            ],
            child: StatefulBuilder(
                builder: (BuildContext buildCtx, StateSetter setState) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(buildCtx).viewInsets.bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const GradientLine(),
                        title != null ? const HeightBox(30) : const SizedBox(),
                        headerText(title, isDarkModeOn),
                        const HeightBox(10),
                        Text(
                          context.l10n.pleaseEnter4DigitOtpReceivedOnMsg + " " + mobNumber,
                          style: TextStyle(
                              color: isDarkModeOn
                                  ? SabanzuriColors.white
                                  : SabanzuriColors.grey_blue,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.italic,
                              fontSize: 15.0),
                        ).px24(),
                        const HeightBox(10),
                        ShakeWidget(
                          controller: otpShakeController,
                          child: SabanzuriTextField(
                            maxLength: 6,
                            inputType: TextInputType.number,
                            hintText: context.l10n.enterOtp,
                            focusNode: focusNode,
                            autoFocus: true,
                            controller: otpController,
                            obscureText: false,
                            prefix: const Icon(
                              Icons.textsms_outlined,
                              color: SabanzuriColors.grey_blue,
                            ),
                            isDarkThemeOn: isDarkModeOn,
                          ).pSymmetric(v: 8),
                        ).px24(),
                        const HeightBox(10),
                        BlocListener<OtpBloc, OtpState>(
                          listener: (context, state) {
                            if (state is OtpReceived) {
                              setState(() {
                                isResendOtpLoading = false;
                              });
                              String? otp =
                                  state.otpResponse.data?.mobVerificationCode;
                              if (otp != null) {
                                PushNotification.show(otp: otp);
                              }
                            }
                            if (state is OtpRequesting) {
                              setState(() {
                                isResendOtpLoading = true;
                              });
                            } else if (state is OtpError) {
                              setState(() {
                                isResendOtpLoading = false;
                              });
                              Navigator.of(context).pop();
                              Alert.show(
                                title: context.l10n.otpError,
                                subtitle: state.otpResponse.errorMessage!,
                                buttonText: context.l10n.ok.toUpperCase(),
                                context: context,
                                isDarkThemeOn: isDarkModeOn,
                              );
                            }
                          },
                          child: AbsorbPointer(
                            absorbing: isResendOtpLoading,
                            child: InkWell(
                              onTap: () {
                                otpController.clear();
                                isInternetConnect().then((value) {
                                  if(value) {
                                    BlocProvider.of<OtpBloc>(buildCtx).add(
                                      GetOtp(
                                        mobNumber: mobNumber,
                                      ),
                                    );
                                  } else {
                                    ApiService.showErrorSheet();
                                  }
                                });
                              },
                              child: Container(
                                child: Text(
                                  context.l10n.resendOtp,
                                  style: TextStyle(
                                    color: isDarkModeOn
                                        ? SabanzuriColors.sickly_yellow
                                        : SabanzuriColors.shamrock_green,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto",
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16.0,
                                  ),
                                ).pSymmetric(v: 8, h: 8),
                              ),
                            ),
                          ),
                        ),
                        const HeightBox(20),
                        Row(
                          children: [
                            Expanded(
                              child: AbsorbPointer(
                                absorbing: isRegistrationLoading,
                                child: PrimaryButton(
                                  text: context.l10n.cancel.toUpperCase(),
                                  type: ButtonType.line_art,
                                  borderColor: isDarkModeOn
                                      ? SabanzuriColors.azul
                                      : SabanzuriColors.navy,
                                  textColor: isDarkModeOn
                                      ? SabanzuriColors.azul
                                      : SabanzuriColors.navy,
                                  borderRadius: 10.0,
                                  onPressed: () {
                                    _onCancelOtp(context);
                                  },
                                  isDarkThemeOn: isDarkModeOn,
                                ),
                              ),
                            ),
                            const WidthBox(10.0),
                            BlocListener<RegistrationBloc, RegistrationState>(
                                listener: (context, state) {
                                  if (state is Registered) {
                                    setState(() {
                                      isRegistrationLoading = false;
                                      isBackPressedAllowed  = true;
                                    });

                                    Navigator.popUntil(context, (route) => false);
                                    Navigator.pushNamed(context, Screen.home_screen, arguments: true);

                                  } else if (state is Registering) {
                                    //const LoadingIndicator().py8();
                                    setState(() {
                                      isRegistrationLoading = true;
                                    });
                                  } else if (state is RegistrationError) {
                                    setState(() {
                                      isRegistrationLoading = false;
                                      isBackPressedAllowed  = true;
                                      if (state.registrationResponse!.errorCode == 422) {
                                        Navigator.of(context).pop();
                                      }
                                      FocusScope.of(context).requestFocus(focusNode);
                                      referTextController.clear();
                                      otpController.clear();
                                      Alert.show(
                                        title: context.l10n.registrationError,
                                        subtitle:
                                        state.registrationResponse!.errorMessage!,
                                        buttonText: context.l10n.ok.toUpperCase(),
                                        context: context,
                                        isDarkThemeOn: isDarkModeOn,
                                      );
                                    });
                                  }
                                },
                                child: isRegistrationLoading
                                    ? SizedBox(width: 50, height: 50, child: Lottie.asset('assets/lottie/gradient_loading.json'))
                                    : Expanded(
                                  child: PrimaryButton(
                                    text: context.l10n.register.toUpperCase(),
                                    fillEnableColor: isDarkModeOn
                                        ? SabanzuriColors.azul
                                        : SabanzuriColors.navy,
                                    fillDisableColor: isDarkModeOn
                                        ? SabanzuriColors.azul
                                        : SabanzuriColors.navy,
                                    textColor: SabanzuriColors.white,
                                    borderRadius: 10.0,
                                    onPressed: () {
                                      setState(() {
                                        isBackPressedAllowed  = false;
                                      });
                                      isValid(otpController.text, otpShakeController)
                                          ?
                                      isInternetConnect().then((value) {
                                        if(value) {
                                          BlocProvider.of<RegistrationBloc>(buildCtx).add(
                                            Registration(
                                              mobNumber: mobNumber,
                                              password: password,
                                              currencyCode: currencyCode,
                                              countryCode: countryCode,
                                              otp: otpController.text,
                                              referCode: referCode,
                                              context: context,
                                            ),
                                          );
                                        } else {
                                          ApiService.showErrorSheet();
                                        }
                                      })

                                          :
                                      null;
                                    },
                                  ),
                                )
                            ),
                          ],
                        ).px24(),
                      ],
                    ),
                  );
                }),
          ),
        );
      },
    );
  }

  static headerText(String? title, bool isDarkModeOn) {
    return Text(
      title ?? '',
      style: TextStyle(
        fontSize: 28,
        color:
        isDarkModeOn ? SabanzuriColors.yellow_orange : SabanzuriColors.navy,
        fontWeight: FontWeight.w700,
      ),
    ).px20();
  }

  static _onCancelOtp(BuildContext context) {
    Navigator.pop(context);
    // Navigator.popUntil(
    //     context, ModalRoute.withName(Screen.registration_screen));
  }

  static bool isValid(String enteredOtp, ShakeController otpShakeController) {
    if (enteredOtp.trim().isNotEmpty) {
      return true;
    }
    otpShakeController.shake();
    return false;
  }
}
