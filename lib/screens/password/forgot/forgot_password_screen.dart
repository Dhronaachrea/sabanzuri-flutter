import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/password/forgot/bloc/forgot_password_bloc.dart';
import 'package:sabanzuri/screens/password/forgot/widget/reset_password_widget.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/gradient_line.dart';
import 'package:sabanzuri/utils/loading_indicator.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/notification.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_type.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';
import 'package:sabanzuri/widgets/show_toast.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController mobController = TextEditingController();
  final _forgotPasswordForm = GlobalKey<FormState>();
  final _resetPasswordForm = GlobalKey<FormState>();
  ShakeController mobShakeController = ShakeController();
  ShakeController otpShakeController = ShakeController();
  ShakeController passShakeController = ShakeController();
  ShakeController confirmPassShakeController = ShakeController();
  TextEditingController passController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool obscurePass = true;
  bool obscureConfPass = true;
  var autoValidate = AutovalidateMode.disabled;
  bool isRequestForOtpLoading = false;
  bool isRequestForVerifyOtpLoading = false;
  bool isGenerateButtonPressed           = false;
  bool isOtpSendForForgotPassword        = false;

  @override
  void dispose() {
    mobController.dispose();
    mobShakeController.dispose();
    passController.dispose();
    confPassController.dispose();
    otpController.dispose();
    otpShakeController.dispose();
    passShakeController.dispose();
    confirmPassShakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is SendingOtp) {
          setState(() {
            isRequestForOtpLoading = true;
            isOtpSendForForgotPassword = false;
          });
        }
        if (state is SendOtpError) {
          setState(() {
            isRequestForOtpLoading = false;
            isOtpSendForForgotPassword = false;
          });
          ShowToast.showToast(
            state.passwordResponseModel.respMsg ?? "",
            context,
            type: ToastType.ERROR,
          );
        }
        else if (state is VerifyOtpError) {
          setState(() {
            isRequestForVerifyOtpLoading = false;
          });
          ShowToast.showToast(
            state.passwordResponseModel.respMsg ?? "",
            context,
            type: ToastType.ERROR,
          );
        }
        else if (state is SentOtp) {
          /*  ShowToast.showToast(
            state.passwordResponseModel.respMsg ?? "",
            context,
            type: ToastType.SUCCESS,
          );*/
          setState(() {
            isRequestForOtpLoading = false;
            isOtpSendForForgotPassword = true;
          });
          PushNotification.show(
              otp: state.passwordResponseModel.verificationCode!);
        }
        else if (state is ForgotPasswordInitial) {
          otpController.clear();
          passController.clear();
          confPassController.clear();

        }
        else if(state is VerifyingOtp) {
          setState(() {
            isRequestForVerifyOtpLoading = true;
          });
        } else if(state is VerifiedOtp) {
          setState(() {
            isRequestForVerifyOtpLoading = false;
          });
          Alert.show(
            title: context.l10n.forgotPassword.toUpperCase(),
            subtitle:
            state.passwordResponseModel.respMsg ?? context.l10n.passwordChangedSuccessfully,
            buttonText: context.l10n.ok.toUpperCase(),
            isBackPressedAllowed: false,
            buttonClick: () {
              Navigator.pushReplacementNamed(context, Screen.home_screen);
              Navigator.of(context).pop();
            },
            isDarkThemeOn: isDarkThemeOn,
            context: context,
            type: AlertType.success,
          );
        };
      }, child: SabanzuriScaffold(
      title: context.l10n.forgotPassword,
      showDrawer: false,
      showLogin: false,
      child: isOtpSendForForgotPassword
            ?
              Container(
              decoration: const BoxDecoration(
              shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
                  //color: const Color(0xFF66BB6A),
                  boxShadow: [BoxShadow(
                    color: SabanzuriColors.pinkish_grey,
                    blurRadius: 0.0,
                  ),]
              ),
                child: WillPopScope(
                  onWillPop: () async{
                    return !isRequestForVerifyOtpLoading;
                  },
                  child: Dialog(
                    insetPadding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 24.0),
                    backgroundColor: isDarkThemeOn
                        ? SabanzuriColors.navy
                        : SabanzuriColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      key: _resetPasswordForm,
                      autovalidateMode: autoValidate,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _gradientLine(),
                            const HeightBox(40),
                            Column(
                              children: [
                                ResetPasswordTitle(
                                  isDarkThemeOn: isDarkThemeOn,
                                ),
                                DrawLine(
                                  isDarkThemeOn: isDarkThemeOn,
                                ),
                                OtpSentSuccessfully(
                                  isDarkThemeOn: isDarkThemeOn,
                                  mobNumber: mobController.text,
                                ),
                                const HeightBox(20),
                                _otpTextField(isDarkThemeOn),
                                _passTextField(isDarkThemeOn),
                                _confPassTextField(isDarkThemeOn),
                                const HeightBox(10),
                                buttons(isDarkThemeOn, context),
                                const HeightBox(20),
                              ],
                            ).px(12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          )
            : AbsorbPointer(
              absorbing: isRequestForOtpLoading,
              child: Form(
        key: _forgotPasswordForm,
        autovalidateMode: autoValidate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              _mobTextField(isDarkThemeOn),
              _sendOtpButton(isDarkThemeOn),
          ],
        ).p32(),
      ),
            ),
    )
    );
  }

  _mobTextField(bool isDarkThemeOn) {
    return ShakeWidget(
      controller: mobShakeController,
      child: SabanzuriTextField(
        maxLength: 15,
        hintText: context.l10n.mobHintTextInfinitiLotto,
        controller: mobController,
        inputType: TextInputType.number,
        prefix: const Icon(
          Icons.phone_android,
          color: SabanzuriColors.grey_blue,
        ),
        validator: (value) {
          var mobText = mobController.text.trim();
          /*if (mobText.startsWith(RegExp(r'[^0,1,7]'))) {
            mobShakeController.shake();
            return context.l10n.mobileNumberMustStart;
          }*/
          if (mobText.isEmpty) {
            mobShakeController.shake();
            return context.l10n.enterMobileNumber;
          } /*else if (mobText.length < 9) {
            mobShakeController.shake();
            return context.l10n.enterValidMobNumber;
          }*/
          return null;
        },
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }

  _sendOtpButton(bool isDarkThemeOn) {
    return
      isRequestForOtpLoading
          ? SizedBox(width: 60, height: 60, child: Lottie.asset('assets/lottie/gradient_loading.json'))
          : PrimaryButton(
        width: context.screenWidth - 40,
        onPressed: () {
          if (_forgotPasswordForm.currentState!.validate()) {
            var mobNumber = mobController.text.trim();
            isInternetConnect().then((value) {
              if(value) {
                context.read<ForgotPasswordBloc>().add(
                  SendOtp(context: context, mobNumber: mobNumber),
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
        text: context.l10n.sendOtp.toUpperCase(),
        borderRadius: 67,
        isDarkThemeOn: isDarkThemeOn,
      );
  }

  _gradientLine() {
    return const GradientLine(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    );
  }

  _otpTextField(bool isDarkThemeOn) {
    return ShakeWidget(
      controller: otpShakeController,
      child: SabanzuriTextField(
        hintText: context.l10n.oneTimePassword,
        controller: otpController,
        maxLength: 6,
        inputType: TextInputType.number,
        prefix: const Icon(
          Icons.message,
          color: SabanzuriColors.grey_blue,
        ),
        validator: (value) {
          if(validateInput(TotalTextFields.otp).isNotEmpty) {
            if (isGenerateButtonPressed) {
              otpShakeController.shake();
            }
            return validateInput(TotalTextFields.otp);
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
        prefix: const Icon(
          Icons.lock,
          color: SabanzuriColors.grey_blue,
        ),
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
        obscureText: obscurePass,
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }

  _confPassTextField(bool isDarkThemeOn) {
    return ShakeWidget(
      controller: confirmPassShakeController,
      child: SabanzuriTextField(
        hintText: context.l10n.confPassword,
        controller: confPassController,
        prefix: const Icon(
          Icons.lock,
          color: SabanzuriColors.grey_blue,
        ),
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
        validator: (value) {
          if(validateInput(TotalTextFields.confirmPassword).isNotEmpty) {
            if (isGenerateButtonPressed) {
              confirmPassShakeController.shake();
            }
            return validateInput(TotalTextFields.confirmPassword);
          } else {
            return null;
          }
        },
        obscureText: obscureConfPass,
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }

  buttons(bool isDarkThemeOn, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: cancelButton(context, isDarkThemeOn),
        ),
        const WidthBox(20),
        Expanded(
          child: submitButton(context, isDarkThemeOn),
        ),
      ],
    );
  }

  cancelButton(BuildContext context, bool isDarkThemeOn) {
    return AbsorbPointer(
      absorbing: isRequestForVerifyOtpLoading,
      child: PrimaryButton(
        width: double.infinity / 2,
        fillDisableColor: Colors.transparent,
        fillEnableColor: Colors.transparent,
        onPressed: () {
          setState(() {
            isOtpSendForForgotPassword = false;
          });
          //context.read<ForgotPasswordBloc>().add(CancelOtpVerification());

        },
        borderColor: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy,
        borderRadius: 10,
        textColor: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy,
        text: context.l10n.cancel.toUpperCase(),
        isDarkThemeOn: isDarkThemeOn,
      ),
    );
  }

  submitButton(BuildContext context, bool isDarkThemeOn) {
    return
      isRequestForVerifyOtpLoading
          ?  SizedBox(width: 60, height: 60, child: Lottie.asset('assets/lottie/gradient_loading.json'))
          :  PrimaryButton(
      width: double.infinity,
      fillDisableColor:
          isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
      fillEnableColor:
          isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
      onPressed: () {
        {
          setState(() {
            isGenerateButtonPressed = true;
          });
          Timer(const Duration(milliseconds: 500), () {
            setState(() {
              isGenerateButtonPressed = false;
            });
          });
          if (_resetPasswordForm.currentState!.validate()) {
            isInternetConnect().then((value) {
              if(value) {
                context.read<ForgotPasswordBloc>().add(VerifyPassOtp(context: context, otp: otpController.text, password: passController.text, confPassword: confPassController.text, mobNumber: mobController.text,),);
              } else {
                ApiService.showErrorSheet();
              }
            });
          } else {
            setState(() {
              autoValidate = AutovalidateMode.onUserInteraction;
            });
          }
        }
      },
      borderRadius: 10,
      text: context.l10n.submit.toUpperCase(),
      isDarkThemeOn: isDarkThemeOn,
    );
  }

  String validateInput(TotalTextFields textField) {
    switch(textField) {
      case TotalTextFields.otp :
        var oldText = otpController.text.trim();
        if (oldText.isEmpty || oldText.length < 6) {
          return "Please enter otp";
        }
        break;

      case TotalTextFields.password:
        var passText = passController.text.trim();
        if (passText.length > 7) {
          if(passText.length > 16) {
            return "Password length should be between 8 to 16 characters.";
          }

        } else {
          return "Password length should be between 8 to 16 characters.";

        }
        break;

      case TotalTextFields.confirmPassword:
        var passText      = passController.text.trim();
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
    }
    return "";
  }
}
