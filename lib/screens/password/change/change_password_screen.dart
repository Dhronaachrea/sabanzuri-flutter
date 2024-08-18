import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_type.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';
import 'package:sabanzuri/widgets/show_toast.dart';
import 'package:velocity_x/velocity_x.dart';

import 'bloc/change_password_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  bool obscureOldPass = true;
  bool obscureNewPass = true;
  bool obscureConfPass = true;
  final _changePassForm = GlobalKey<FormState>();
  bool isGenerateButtonPressed           = false;
  ShakeController oldPassShakeController    = ShakeController();
  ShakeController passShakeController       = ShakeController();
  ShakeController confPassShakeController   = ShakeController();
  bool isLoading = false;

  var autoValidate                          = AutovalidateMode.disabled;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
        return SabanzuriScaffold(
          title: context.l10n.changePassword,
          showLogin: true,
          showDrawer: false,
          child: Form(
            key: _changePassForm,
            autovalidateMode: autoValidate,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _oldPassTextField(isDarkThemeOn),
                  _newPassTextField(isDarkThemeOn),
                  _confirmPassTextField(isDarkThemeOn),
                  _submitButton(isDarkThemeOn),
                ],
              ).p32(),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is ChangedPassword) {
          setState(() {
            isLoading = false;
          });
          var response = state.changedPasswordResponse;
          bool isDarkThemeOn = context.read<SwitchCubit>().state.isDarkThemeOn;
          Alert.show(
            context: context,
            title: context.l10n.changePassword.toString().toUpperCase(),
            subtitle: response?.respMsg ?? "",
            buttonText: context.l10n.done.toString().toUpperCase(),
            isDarkThemeOn: isDarkThemeOn,
            type: AlertType.success,
            isBackPressedAllowed: false,
            buttonClick: () {
              onConfirmLogout(context);
              Navigator.popUntil(context, (route) => false);
              Navigator.pushNamed(context, Screen.home_screen);
              loginForSessionExpired(context);
            },
          );
        } else if (state is ChangePasswordLoading) {
          setState(() {
            isLoading = true;
          });
        } else {
          if (state is ChangePasswordError) {
            setState(() {
              isLoading = false;
            });
            var response = state.changedPasswordResponse;
            ShowToast.showToast(response?.respMsg ?? "", context,
                type: ToastType.ERROR);
          }
        }
      },
    );
  }

  _oldPassTextField(bool isDarkThemeOn) {
    return ShakeWidget(
      controller: oldPassShakeController,
      child: SabanzuriTextField(
        hintText: context.l10n.oldPassword,
        controller: oldPassController,
        inputType: TextInputType.text,
        maxLength: 16,
        suffixIcon: IconButton(
          icon: Icon(
            obscureOldPass ? Icons.visibility_off : Icons.remove_red_eye_rounded,
            color: SabanzuriColors.grey_blue,
          ),
          onPressed: () {
            setState(() {
              obscureOldPass = !obscureOldPass;
            });
          },
        ),
        validator: (value) {
          if(validateInput(TotalTextFields.oldPassword).isNotEmpty) {
            if (isGenerateButtonPressed) {
              oldPassShakeController.shake();
            }
            return validateInput(TotalTextFields.oldPassword);
          } else {
            return null;
          }
        },
        obscureText: obscureOldPass,
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }

  _newPassTextField(bool isDarkThemeOn) {
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
            setState(() {
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

  _confirmPassTextField(bool isDarkThemeOn) {
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
            setState(() {
              obscureConfPass = !obscureConfPass;
            });
          },
        ),
        obscureText: obscureConfPass,
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }

  _submitButton(bool isDarkThemeOn) {
    return isLoading
        ? SizedBox(width: 50, height: 50, child: Lottie.asset('assets/lottie/gradient_loading.json'),).py(16)
        : PrimaryButton(
      width: context.screenWidth - 40,
      onPressed: () {
        setState(() {
          isGenerateButtonPressed = true;
        });
        Timer(const Duration(milliseconds: 500), () {
          setState(() {
            isGenerateButtonPressed = false;
          });
        });
        if (_changePassForm.currentState!.validate()) {
          isInternetConnect().then((value) {
            if(value) {
              context.read<ChangePasswordBloc>().add(
                ChangePassword(context: context, oldPassword: oldPassController.text, newPassword: newPassController.text),
              );
            } else {
              ApiService.showErrorSheet();
            }
          });
        } else {
          setState(() {
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
      case TotalTextFields.oldPassword :
        var oldText = oldPassController.text.trim();
        if (oldText.isEmpty) {
          return "Password length should be between 8 to 16 characters.";

        } else if (oldText.length > 16) {
          return "Password length should be between 8 to 16 characters.";
        }

        break;

      case TotalTextFields.password:
        var passText = newPassController.text.trim();
        if (passText.length > 7) {
          if(passText.length > 16) {
            return "Password length should be between 8 to 16 characters.";
          }
        } else {
          return "Password length should be between 8 to 16 characters.";

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
    }
    return "";
  }

}
