import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/screens/update_profile/bloc/update_profile_bloc.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';
import 'package:sabanzuri/widgets/show_toast.dart';
import 'package:velocity_x/velocity_x.dart';

class WithdrawalOtpDialog extends StatefulWidget {
  String mobileNo;
  Function(String) otpCallback;

  WithdrawalOtpDialog({super.key, required this.otpCallback, required this.mobileNo});

  @override
  State<WithdrawalOtpDialog> createState() => _WithdrawalOtpDialogState();
}

class _WithdrawalOtpDialogState extends State<WithdrawalOtpDialog> {

  TextEditingController otpController      = TextEditingController();
  ShakeController otpShakeController       = ShakeController();

  bool isLoading        = false;
  bool isResendOtpCall  = false;

  final _otpForm                 = GlobalKey<FormState>();
  bool isGenerateButtonPressed   = false;
  var autoValidate               = AutovalidateMode.disabled;

  late Timer _timer;
  int _start = 120;

  @override
  Widget build(BuildContext context) {
    final bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;

    return StatefulBuilder(
      builder: (context, setInnerState) {
        return BlocListener<UpdateProfileBloc, UpdateProfileState>(
          listener: (context, state) {
            if (state is GetOtpSuccess) {
              setState(() {
                isResendOtpCall = false;
                ShowToast.showToast(state.msg, context,type: ToastType.SUCCESS);

              });
            } else if (state is GetResendOtpError) {
              setState(() {
                isResendOtpCall = false;
              });
            }
          },
          child: Form(
            key: _otpForm,
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
                    _otpTextField(context, isDarkThemeOn, setInnerState),
                    Align(
                      alignment: Alignment.centerRight,
                      child: isResendOtpCall
                              ? SizedBox(width: 70, height: 40, child: Lottie.asset("assets/lottie/resend_loader.json", ))
                              : InkWell(
                        onTap: () {
                          // resend otp
                          setState(() {
                            isResendOtpCall = true;
                            callGetOtpApi();
                          });
                        },
                        child: Text(
                          context.l10n.resendOtp,
                          style: const TextStyle(
                              color: SabanzuriColors.reddish_pink
                          ),
                        ),
                      )
                    ),
                    const HeightBox(30),
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

  void startTimer() {// use later
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer)
      {        if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
      },
    );
  }

  _otpTextField(BuildContext context, bool isDarkThemeOn, Function mSetInnerState) {
    return ShakeWidget(
      controller: otpShakeController,
      child: SabanzuriTextField(
        controller: otpController,
        hintText: context.l10n.enterOtp,
        inputType: TextInputType.number,
        maxLength: 16,
        prefix: const Icon(Icons.domain_verification, color: SabanzuriColors.navy,),
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
        /*Timer(const Duration(milliseconds: 500), () {
          mSetInnerState(() {
            isGenerateButtonPressed = false;
          });
        });*/
        if (_otpForm.currentState!.validate()) {
          widget.otpCallback(otpController.text);
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
      case TotalTextFields.otp:
        var mobText      = otpController.text.trim();
        if (mobText.isEmpty) {
          return context.l10n.enterOtp;
        }
        break;
    }
    return "";
  }

  void callGetOtpApi() { //GetOtpApi
    isInternetConnect().then((value) {
      if(value) {
        BlocProvider.of<UpdateProfileBloc>(context).add(
          GetOtpApi(
            mobileNo: widget.mobileNo,
            context: context,
            isResendOtp: true
          ),
        );
      } else {
        ApiService.showErrorSheet();
      }
    });
  }

}
