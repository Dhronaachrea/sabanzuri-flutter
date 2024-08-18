import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';
import 'package:velocity_x/velocity_x.dart';

class WithdrawalPhoneNoDialog extends StatefulWidget {
  const WithdrawalPhoneNoDialog({super.key});

  @override
  State<WithdrawalPhoneNoDialog> createState() => _WithdrawalPhoneNoDialogState();
}

class _WithdrawalPhoneNoDialogState extends State<WithdrawalPhoneNoDialog> {

  TextEditingController mobController      = TextEditingController();
  ShakeController mobShakeController       = ShakeController();

  bool isLoading = false;

  final _changePassForm          = GlobalKey<FormState>();
  bool isGenerateButtonPressed   = false;
  var autoValidate               = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;

    return StatefulBuilder(
      builder: (context, setInnerState) {
        return Form(
          key: _changePassForm,
          autovalidateMode: autoValidate,
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HeightBox(30),
                  _mobTextField(context, isDarkThemeOn, setInnerState),
                  const HeightBox(20),
                  isLoading
                      ? SizedBox(width: 50, height: 50, child: Lottie.asset('assets/lottie/gradient_loading.json'),).py(16)
                      : _submitButton(isDarkThemeOn, setInnerState)
                ],
              ).p(20),
            ),
          ),
        );
      },
    );
  }

  _mobTextField(BuildContext context, bool isDarkThemeOn, Function mSetInnerState) {
    return ShakeWidget(
      controller: mobShakeController,
      child: SabanzuriTextField(
        controller: mobController,
        hintText: context.l10n.mobileNumber,
        inputType: TextInputType.phone,
        maxLength: 16,
        prefix: const Icon(Icons.person, color: SabanzuriColors.navy,),
        validator: (value) {
          if(validateInput(TotalTextFields.mobileNumber).isNotEmpty) {
            if (isGenerateButtonPressed) {
              mobShakeController.shake();
            }
            return validateInput(TotalTextFields.mobileNumber);
          } else {
            return null;
          }
        },
        fillColor: SabanzuriColors.pinkish_grey,
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }

  _submitButton(bool isDarkThemeOn, Function mSetInnerState) {
    return PrimaryButton(
      width: context.screenWidth - 40,
      onPressed: () {
        mSetInnerState(() {
          isGenerateButtonPressed = true;
        });
        Timer(const Duration(milliseconds: 500), () {
          mSetInnerState(() {
            isGenerateButtonPressed = false;
          });
        });
        if (_changePassForm.currentState!.validate()) {
          isInternetConnect().then((value) {
            if(value) {
              // call api
              Navigator.of(context).pop(mobController.text);
            } else {
              ApiService.showErrorSheet();
            }
          });
        } else {
          mSetInnerState(() {
            autoValidate = AutovalidateMode.onUserInteraction;
          });
        }
      },
      enabled: true,
      text: context.l10n.submit.toUpperCase(),
      borderRadius: 67,
      isDarkThemeOn: isDarkThemeOn,
    );
  }


  String validateInput(TotalTextFields textField) {
    switch(textField) {
      case TotalTextFields.mobileNumber:
        var mobText      = mobController.text.trim();
        if (mobText.isEmpty) {
          return context.l10n.enterValidMobNumber;
        } else if (mobText.length > 8) {
          if(mobText.length > 16) {
            return context.l10n.enterValidMobNumber;
          }
        } else {
          return context.l10n.enterValidMobNumber;

        }
        break;
    }
    return "";
  }

}
