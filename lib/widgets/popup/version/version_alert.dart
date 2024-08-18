import 'package:flutter/material.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';

enum VersionAlertType {
  mandatory,
  optional,
}

class VersionAlert {
  static show({
    required BuildContext context,
    required VersionAlertType type,
    required String message,
    String? description,
    VoidCallback? onUpdate,
    VoidCallback? onCancel,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Wrap(
              children: [
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            SabanzuriColors.navy,
                            SabanzuriColors.grey_blue,
                          ]),
                          boxShadow: const [
                            BoxShadow(color: Colors.black),
                            BoxShadow(
                              color: SabanzuriColors.black,
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(0, 6),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const HeightBox(20),
                            Image.asset('assets/images/logo_white.png'),
                            const HeightBox(20),
                            const Text(
                              AppConstants.appDisplayName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const HeightBox(20),
                            Text(
                              message,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            description != null
                                ? Text(
                                    description,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ).py8()
                                : Container(),
                            const HeightBox(20),
                            type == VersionAlertType.optional
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: PrimaryButton(
                                          textColor: Colors.white,
                                          type: ButtonType.line_art,
                                          onPressed: onCancel != null
                                              ? () {
                                                  Navigator.of(ctx).pop();
                                                  onCancel();
                                                }
                                              : () {
                                                  Navigator.of(ctx).pop();
                                                },
                                          text: context.l10n.later,
                                        ),
                                      ),
                                      const WidthBox(10),
                                      Expanded(
                                        child: PrimaryButton(
                                          onPressed: onUpdate != null
                                              ? () {
                                                  Navigator.of(ctx).pop();
                                                  onUpdate();
                                                }
                                              : () {
                                                  Navigator.of(ctx).pop();
                                                },
                                          text: context.l10n.updateNow,
                                        ),
                                      ),
                                    ],
                                  )
                                : PrimaryButton(
                                    width: context.screenWidth,
                                    onPressed: onUpdate != null
                                        ? () {
                                            Navigator.of(ctx).pop();
                                            onUpdate();
                                          }
                                        : () {
                                            Navigator.of(ctx).pop();
                                          },
                                    text: context.l10n.updateNow,
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
