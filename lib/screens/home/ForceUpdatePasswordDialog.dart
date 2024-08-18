
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/password/change/bloc/change_password_bloc.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';
import 'package:sabanzuri/widgets/show_toast.dart';
import 'package:velocity_x/velocity_x.dart';

class ForcePasswordChangeDialog extends StatefulWidget {
  const ForcePasswordChangeDialog({super.key});

  @override
  State<ForcePasswordChangeDialog> createState() => _ForcePasswordChangeDialogState();
}

class _ForcePasswordChangeDialogState extends State<ForcePasswordChangeDialog> {

  TextEditingController newPassController  = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  TextEditingController mobController      = TextEditingController();

  bool obscureNewPass = true;
  bool obscureConfPass = true;

  ShakeController passShakeController       = ShakeController();
  ShakeController confPassShakeController   = ShakeController();

  bool isLoading = false;
  final _changePassForm          = GlobalKey<FormState>();
  bool isGenerateButtonPressed   = false;
  var autoValidate               = AutovalidateMode.disabled;


  @override
  void initState() {
    mobController.text = UserInfo.mobNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;

    return StatefulBuilder(
      builder: (context, setInnerState) {
        return BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangedPassword) {
              Navigator.pop(context);
              ShowToast.showToast(state.changedPasswordResponse?.respMsg ?? "", context, type: ToastType.SUCCESS);
              UserInfo.logout();
            } else if (state is ChangePasswordLoading) {
              setInnerState(() {
                isLoading = true;
              });
            } else if (state is ChangePasswordError) {
              setInnerState(() {
                isLoading = false;
                ShowToast.showToast(state.changedPasswordResponse?.errorMessage ?? "", context, type: ToastType.ERROR);
              });
            }
          },
          child: Form(
            key: _changePassForm,
            autovalidateMode: autoValidate,
            child: Dialog(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Text(
                      context.l10n.changePassword,
                      style: const TextStyle(
                          color: SabanzuriColors.black,
                          fontSize: 20
                      ),
                    ),
                    const HeightBox(30),
                    _mobTextField(context, isDarkThemeOn, setInnerState),
                    _newPassTextField(context, isDarkThemeOn, setInnerState),
                    _confirmPassTextField(context, isDarkThemeOn, setInnerState),
                    const HeightBox(20),
                    isLoading
                        ? SizedBox(width: 50, height: 50, child: Lottie.asset('assets/lottie/gradient_loading.json'),).py(16)
                        : _submitButton(isDarkThemeOn, setInnerState)
                  ],
                ).p(20),
              ),
            ),
          ),
        );
      },
    );
  }


  _mobTextField(BuildContext context, bool isDarkThemeOn, Function mSetInnerState) {
    return SabanzuriTextField(
      controller: mobController,
      hintText: context.l10n.mobileNumber,
      inputType: TextInputType.text,
      maxLength: 16,
      enabled: false,
      fillColor: SabanzuriColors.pinkish_grey,
      borderColor: Colors.transparent,
      isDarkThemeOn: isDarkThemeOn,
    ).pSymmetric(v: 8);
  }


  _newPassTextField(BuildContext context, bool isDarkThemeOn, Function mSetInnerState) {
    return ShakeWidget(
      controller: passShakeController,
      child: SabanzuriTextField(
        hintText: context.l10n.newPassword,
        controller: newPassController,
        inputType: TextInputType.text,
        maxLength: 16,
        suffixIcon: IconButton(
          icon: Icon(
            obscureNewPass ? Icons.visibility_off : Icons.remove_red_eye_rounded,
            color: SabanzuriColors.grey_blue,
          ),
          onPressed: () {
            mSetInnerState(() {
              obscureNewPass = !obscureNewPass;
            });
          },
        ),
        validator: (value) {
          if(validateInput(TotalTextFields.password).isNotEmpty) {
            if (isGenerateButtonPressed) {
              passShakeController.shake();
            }
            return validateInput(TotalTextFields.password);
          } else {
            return null;
          }
        },
        obscureText: obscureNewPass,
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }

  _confirmPassTextField(BuildContext context, bool isDarkThemeOn, Function mSetInnerState) {
    return ShakeWidget(
      controller: confPassShakeController,
      child: SabanzuriTextField(
        hintText: context.l10n.confPassword,
        controller: confPassController,
        inputType: TextInputType.text,
        maxLength: 16,
        validator: (value) {
          if(validateInput(TotalTextFields.confirmPassword).isNotEmpty) {
            if (isGenerateButtonPressed) {
              confPassShakeController.shake();
            }
            return validateInput(TotalTextFields.confirmPassword);
          } else {
            return null;
          }
        },
        suffixIcon: IconButton(
          icon: Icon(
            obscureConfPass ? Icons.visibility_off : Icons.remove_red_eye_rounded,
            color: SabanzuriColors.grey_blue,
          ),
          onPressed: () {
            mSetInnerState(() {
              obscureConfPass = !obscureConfPass;
            });
          },
        ),
        obscureText: obscureConfPass,
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
              context.read<ChangePasswordBloc>().add(
                InitialChangePassword(context: context,newPassword: newPassController.text),
              );
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
      case TotalTextFields.password:
        var passText = newPassController.text.trim();
        if (passText.length > 4) {
          if(passText.length > 16) {
            return "Password length should be between 4 to 16 characters.";
          }
        } else {
          return "Password length should be between 4 to 16 characters.";

        }
        break;

      case TotalTextFields.confirmPassword:
        var passText      = newPassController.text.trim();
        var confPassText  = confPassController.text.trim();
        if (passText != confPassText) {
          return context.l10n.passMatchError;
        }
        break;

      case TotalTextFields.mobileNumber:
        break;
      case TotalTextFields.oldPassword:
        // TODO: Handle this case.
        break;
      case TotalTextFields.otp:
        // TODO: Handle this case.
        break;
    }
    return "";
  }

}