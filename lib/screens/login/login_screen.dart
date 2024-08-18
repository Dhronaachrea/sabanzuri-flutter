import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/login/bloc/login_bloc.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/gradient_line.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/show_toast.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onLoginNavCallback;

  const LoginScreen({Key? key, this.onLoginNavCallback}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobController   = TextEditingController();
  TextEditingController passController  = TextEditingController();
  ShakeController mobShakeController    = ShakeController();
  ShakeController passShakeController   = ShakeController();
  bool obscurePass                      = true;
  final _loginForm                      = GlobalKey<FormState>();
  var autoValidate                      = AutovalidateMode.disabled;
  var isLoginLoading                    = false;
  bool isGenerateOtpButtonPressed       = false;

  @override
  Widget build(BuildContext context) {

    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isLandscape = (orientation == Orientation.landscape);

    return StatefulBuilder(builder: (context, setState) {
      return BlocBuilder<SwitchCubit, SwitchState>(
        builder: (context, state) {
          bool isDarkThemeOn = state.isDarkThemeOn;
          return AbsorbPointer(
            absorbing: isLoginLoading,
            child: Dialog(
              elevation: 5.0,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              backgroundColor:
                  isDarkThemeOn ? SabanzuriColors.navy : SabanzuriColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
          width: MediaQuery.of(context).size.width * (isLandscape ? 0.45 : 1),
                child: Form(
                  key: _loginForm,
                  autovalidateMode: autoValidate,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _gradientLine(),
                        const HeightBox(40),
                        Column(
                          children: [
                            _loginOrSignUpTitle(isDarkThemeOn),
                            const HeightBox(40),
                            _mobTextField(isDarkThemeOn),
                            _passTextField(isDarkThemeOn),
                            _forgotPass(isDarkThemeOn),
                            _loginButton(isDarkThemeOn),
                            _signUpButton(isDarkThemeOn),
                          ],
                        ).px(12),
                        const HeightBox(10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  _gradientLine() {
    return const GradientLine(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    );
  }

  _loginOrSignUpTitle(bool isDarkThemeOn) {
    return Text(
      context.l10n.loginOrSignup,
      style: TextStyle(
        color: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy,
        fontWeight: FontWeight.w400,
        fontFamily: "Roboto",
        fontStyle: FontStyle.normal,
        fontSize: 30.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  _mobTextField(bool isDarkThemeOn) {
    return ShakeWidget(
      controller: mobShakeController,
      child: SabanzuriTextField(
        maxLength: 15,
        inputType: TextInputType.number,
        hintText: context.l10n.mobHintTextInfinitiLotto,
        controller: mobController,
        validator: (value) {
         /* if (mobText.startsWith(RegExp(r'[^0,1,7]'))) {
            mobShakeController.shake();
            return context.l10n.mobileNumberMustStart;
          }*/
          if(validateInput(TotalTextFields.mobileNumber).isNotEmpty) {
            if (isGenerateOtpButtonPressed) {
              mobShakeController.shake();
            }
            return validateInput(TotalTextFields.mobileNumber);
          } else {
            return null;
          }
        },
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }

  _passTextField(bool isDarkThemeOn) {
    return ShakeWidget(
      controller: passShakeController,
      child: SabanzuriTextField(
        hintText: context.l10n.password,
        controller: passController,
        maxLength: 16,
        inputType: TextInputType.text,
        obscureText: obscurePass,
        validator: (value) {
          if(validateInput(TotalTextFields.password).isNotEmpty) {
            if (isGenerateOtpButtonPressed) {
              passShakeController.shake();
            }
            return validateInput(TotalTextFields.password);
          } else {
            return null;
          }
        },
        suffixIcon: IconButton(
          icon: Icon(
            obscurePass ? Icons.visibility_off : Icons.remove_red_eye_rounded,
            color: SabanzuriColors.grey_blue,
          ),
          onPressed: () {
            setState(() {
              obscurePass = !obscurePass;
            });
          },
        ),
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }

  _forgotPass(bool isDarkThemeOn) {
    return Row(
      children: [
        const Spacer(),
        PrimaryButton(
          type: ButtonType.line_art,
          onPressed: () {
            Navigator.pushNamed(
              context,
              Screen.forgot_password_screen,
            );
          },
          text: context.l10n.forgotPassword + "?",
          borderRadius: 67,
          isDarkThemeOn: isDarkThemeOn,
        ),
      ],
    );
  }

  _loginButton(bool isDarkThemeOn) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoggedIn) {
          setState(() {
            isLoginLoading = false;
          });
          if (widget.onLoginNavCallback != null) {
            Navigator.pop(context);
            widget.onLoginNavCallback!();
          } else {
            Navigator.pop(context);
            //Navigator.pushReplacementNamed(context, Screen.home_screen);
          }
        }

        if(state is Logging) {
          setState(() {
            isLoginLoading = true;
          });
        }
        if (state is LoginError) {
          setState(() {
            isLoginLoading = false;
          });
          //Navigator.of(context).pop();
          Alert.show(
            title: context.l10n.loginError,
            subtitle: state.errorMessage,
            buttonText: context.l10n.ok.toUpperCase(),
            context: context,
            isDarkThemeOn: isDarkThemeOn,
          );
        }
      },
      child: isLoginLoading
           ? SizedBox(
              width: 50,
              height: 50,
              child: Lottie.asset('assets/lottie/gradient_loading.json'),
            )

          : PrimaryButton(
        width: context.screenWidth - 40,
        onPressed: () {
          setState(() {
            isGenerateOtpButtonPressed = true;
          });
          Timer(const Duration(milliseconds: 500), () {
            setState(() {
              isGenerateOtpButtonPressed = false;
            });
          });
          if (_loginForm.currentState!.validate()) {
            var mobNumber = mobController.text.trim();
            var password = passController.text.trim();
            if (password.length > 4) {
              if(password.length > 16) {
                if (isGenerateOtpButtonPressed) {
                  passShakeController.shake();
                }
                ShowToast.showToast("Password length should be between 4 to 16 characters.", context);
                passShakeController.shake();
                return;
              }
            } else {
              ShowToast.showToast("Password length should be between 4 to 16 characters.", context);
              passShakeController.shake();
              return;
            }
            isInternetConnect().then((value) {
              if(value) {
                BlocProvider.of<LoginBloc>(context).add(Login(
                    password: password, mobNumber: mobNumber, context: context));
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
        text: context.l10n.login.toUpperCase(),
        borderRadius: 67,
        isDarkThemeOn: isDarkThemeOn,
      )
    );
  }

  _signUpButton(bool isDarkThemeOn) {
    return PrimaryButton(
      borderColor: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy,
      textColor: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy,
      width: context.screenWidth / 2,
      type: ButtonType.line_art,
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, Screen.registration_screen);
      },
      text: context.l10n.signUp.toUpperCase(),
      borderRadius: 67,
      isDarkThemeOn: isDarkThemeOn,
    );
  }

  String validateInput(TotalTextFields textField) {
    switch(textField) {
      case TotalTextFields.mobileNumber :
        var mobText = mobController.text.trim();
        if (mobText.isEmpty) {
          return context.l10n.enterMobileNumber;

        } else if (mobText.length > 16) {
          return context.l10n.enterValidMobNumber;
        }
        break;

      case TotalTextFields.password:
        var passText = passController.text.trim();
        if (passText.length > 4) {
          if(passText.length > 16) {
            return "Password length should be between 4 to 16 characters.";
          }
        } else {
          return "Password length should be between 4 to 16 characters.";

        }
        break;

      case TotalTextFields.confirmPassword:
        break;
    }
    return "";
  }

}
