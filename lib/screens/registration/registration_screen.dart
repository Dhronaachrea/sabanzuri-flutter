import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/CountryListResponse.dart';
import 'package:sabanzuri/screens/otp/bloc/otp_bloc.dart';
import 'package:sabanzuri/screens/registration/registration_bottom_sheet.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/url.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/notification.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/sabanzuri_bottom_sheet.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:sabanzuri/widgets/show_toast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';
import 'package:sabanzuri/screens/otp/bloc/otp_bloc.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/notification.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController mobController       = TextEditingController();
  TextEditingController passController      = TextEditingController();
  TextEditingController confPassController  = TextEditingController();
  ShakeController mobShakeController        = ShakeController();
  ShakeController passShakeController       = ShakeController();
  ShakeController confPassShakeController   = ShakeController();
  ShakeController countryShakeController    = ShakeController();
  ShakeController currencyShakeController   = ShakeController();

  bool obscurePass                          = true;
  bool obscureConfPass                      = true;
  final _registrationForm                   = GlobalKey<FormState>();
  var autoValidate                          = AutovalidateMode.disabled;
  var currencyDropDownItemValue             = getHardcodedCurrencyList()[0];
  var countryDropDownItemList               = ["Select Country *"];
  List<Data> countryItemList                = [];
  Object countryDropDownItemValue           = "";
  bool isNewValueCountryChosen              = false;
  bool isNewValueCurrencyChosen             = false;
  bool isGenerateOtpButtonPressed           = false;
  bool isCountryListLoading                 = false;
  bool isGenerateOtpLoading                 = false;
  TextEditingController referController     = TextEditingController();
  ShakeController referShakeController      = ShakeController();


  @override
  void initState() {
    super.initState();
    isInternetConnect().then((value) {
      if(value) {
        BlocProvider.of<OtpBloc>(context).add(GetCountryList());
      } else {
        ApiService.showErrorSheet();
      }
    });
    currencyDropDownItemValue = getHardcodedCurrencyList()[0];
    countryDropDownItemList   = ["Select Country *"];
    countryDropDownItemValue  = countryDropDownItemList[0];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchCubit, SwitchState>(builder: (context, state) {
      final bool isDarkThemeOn = state.isDarkThemeOn;
      return AbsorbPointer(
        absorbing: isGenerateOtpLoading,
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SabanzuriScaffold(
            title: context.l10n.registration,
            showDrawer: false,
            showLogin: false,
            child: Form(
                key: _registrationForm,
                autovalidateMode: autoValidate,
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          const HeightBox(5),
                          _mobTextField(isDarkThemeOn),
                          _passTextField(isDarkThemeOn),
                          _confPassTextField(isDarkThemeOn),
                          BlocListener<OtpBloc, OtpState>(
                              listener: (context, state) {
                                if(state is GetCountryListLoaded) {
                                  countryItemList = state.countryListResponse.data ?? [];
                                  //countryItemList = [];
                                  if (countryItemList.isNotEmpty) {
                                    setState(() {
                                      isCountryListLoading = false;
                                      state.countryListResponse.data != null
                                          ? countryItemList.forEach((element) { element.countryName != null ? countryDropDownItemList.add(element.countryName!) : null; })
                                          : countryDropDownItemList;
                                    });
                                  }

                                } else if(state is GetCountryListLoading) {
                                  setState(() {
                                    isCountryListLoading = true;
                                  });
                                } else if(state is GetCountryListError) {
                                  isCountryListLoading = false;
                                  ShowToast.showToast(state.countryListResponse.errorMessage ?? "Country List Error", context);
                                }
                              },
                            child: AbsorbPointer(
                              absorbing: isCountryListLoading,
                              child: ShakeWidget(
                                controller: countryShakeController,
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      child: Column(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.symmetric(vertical: 4),
                                              decoration: BoxDecoration(
                                                  color: isDarkThemeOn ? SabanzuriColors.cetaceanBlue : SabanzuriColors.white,
                                                  border: Border.all(color: isNewValueCountryChosen ? SabanzuriColors.lightish_red : SabanzuriColors.grey_blue, width: 1),
                                                  borderRadius: BorderRadius.circular(8)),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.home,
                                                      color: SabanzuriColors.grey_blue, size: 24).pOnly(left: 8),
                                                  Expanded(
                                                    child: DropdownButton(
                                                        menuMaxHeight: 300,
                                                        isExpanded: true,
                                                        value: countryDropDownItemValue,
                                                        style: const TextStyle(color: SabanzuriColors.grey_blue, fontSize: 18),
                                                        dropdownColor: SabanzuriColors.cetaceanBlue,
                                                        underline: Container(),
                                                        iconSize: 0,
                                                        items: countryDropDownItemList
                                                            .map((dynamic items) {
                                                          return DropdownMenuItem(
                                                              value: items,
                                                              child: Text(items, overflow: TextOverflow.ellipsis)
                                                          );
                                                        }).toList(),
                                                        onTap: () {
                                                          if(countryItemList.isEmpty) {
                                                            ShowToast.showToast("No country/s available.", context);
                                                          }
                                                        },
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            isNewValueCountryChosen = false;
                                                            countryDropDownItemValue = newValue ?? countryDropDownItemList[0];
                                                          });
                                                        }).pOnly(left: 8),
                                                  ),
                                                  isCountryListLoading
                                                      ? SizedBox(
                                                    width: 40,
                                                    height: 40,
                                                    child: Lottie.asset('assets/lottie/gradient_loading.json'),
                                                  )
                                                      : const Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Icon(Icons.arrow_drop_down,
                                                        color: SabanzuriColors.grey_blue),
                                                  ).pOnly(right: 8),
                                                ],
                                              ),
                                            ).pSymmetric(v: 8),
                                            isNewValueCountryChosen
                                                ?
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: const Text("Please select country",
                                                    style: TextStyle(color: SabanzuriColors.lightish_red, fontSize: 12), textAlign: TextAlign.left).pOnly(left: 8)).pOnly(bottom: 8)
                                                :
                                            Container()
                                          ]
                                      ),
                                    )
                                  ],
                                )
                              ),
                            )

                          ),
                          ShakeWidget(
                            controller: currencyShakeController,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                      color: isDarkThemeOn ? SabanzuriColors.cetaceanBlue : SabanzuriColors.white,
                                      border: Border.all(color: isNewValueCurrencyChosen ? SabanzuriColors.lightish_red : SabanzuriColors.grey_blue, width: 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.currency_pound_rounded,
                                          color: SabanzuriColors.grey_blue, size: 24).pOnly(left: 8),
                                      Expanded(
                                        child: DropdownButton(
                                            value: currencyDropDownItemValue,
                                            menuMaxHeight: 300,
                                            style: const TextStyle(
                                                color: SabanzuriColors.grey_blue, fontSize: 18),
                                            dropdownColor: SabanzuriColors.cetaceanBlue,
                                            underline: Container(),
                                            iconSize: 0,
                                            items: getHardcodedCurrencyList()
                                                .map((dynamic items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                currencyDropDownItemValue = newValue ?? getHardcodedCurrencyList()[0];
                                                isNewValueCurrencyChosen = false;
                                              });
                                            }).pOnly(left: 8),
                                      ),
                                      const Icon(Icons.arrow_drop_down,
                                          color: SabanzuriColors.grey_blue).pOnly(right: 10),
                                    ],
                                  ),
                                ).pSymmetric(v: 8),
                                isNewValueCurrencyChosen
                                    ?
                                      Align(
                                    alignment: Alignment.centerLeft,
                                    child: const Text("Please select currency",
                                        style: TextStyle(color: SabanzuriColors.lightish_red, fontSize: 12), textAlign: TextAlign.left).pOnly(left: 8)).pOnly(bottom: 8)
                                    :
                                      Container()
                              ],
                            ),
                          ),
                          _referAFriendTextField(isDarkThemeOn),
                          const Spacer(),
                          _juvenileText(isDarkThemeOn),
                          _termAndCondition(isDarkThemeOn),
                          _generateOtpButton(isDarkThemeOn),
                        ],
                      ).p20(),
                    ),
                  ],
                )),
          ),
        ),
      );
    });
  }

  _mobTextField(bool isDarkThemeOn) {
    return ShakeWidget(
      controller: mobShakeController,
      child: SabanzuriTextField(
        autoFocus: true,
        maxLength: 15,
        hintText: context.l10n.mobHintTextInfinitiLotto,
        controller: mobController,
        inputType: TextInputType.number,
        prefix: const Icon(
          Icons.phone_android,
          color: SabanzuriColors.grey_blue,
        ),
        validator: (value) {
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
        obscureText: obscurePass,
        inputType: TextInputType.text,
        maxLength: 16,
        prefix: const Icon(
          Icons.vpn_key,
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
            if (isGenerateOtpButtonPressed) {
              passShakeController.shake();
            }
            return validateInput(TotalTextFields.password);
          } else {
            return null;
          }
        },
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }

  _confPassTextField(bool isDarkThemeOn) {
    return ShakeWidget(
      controller: confPassShakeController,
      child: SabanzuriTextField(
        hintText: context.l10n.confPassword,
        controller: confPassController,
        obscureText: obscureConfPass,
        inputType: TextInputType.text,
        maxLength: 16,
        validator: (value) {
          if(validateInput(TotalTextFields.confirmPassword).isNotEmpty) {
            if (isGenerateOtpButtonPressed) {
              confPassShakeController.shake();
            }
            return validateInput(TotalTextFields.confirmPassword);
          } else {
            return null;
          }
        },
        prefix: const Icon(
          Icons.vpn_key,
          color: SabanzuriColors.grey_blue,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureConfPass
                ? Icons.visibility_off
                : Icons.remove_red_eye_rounded,
            color: SabanzuriColors.grey_blue,
          ),
          onPressed: () {
            setState(() {
              obscureConfPass = !obscureConfPass;
            });
          },
        ),
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }

  _referAFriendTextField(bool isDarkThemeOn) {
    return ShakeWidget(
      controller: referShakeController,
      child: SabanzuriTextField(
        maxLength: 6,
        hintText: "Refer Code",
        controller: referController,
        inputType: TextInputType.text,
        prefix: const Icon(
          Icons.wallet_giftcard,
          color: SabanzuriColors.grey_blue,
        ),
        validator: (value) {
          var referText = referController.text.trim();
          if (referText.isEmpty) {
            //   return context.l10n.enterMobileNumber;
          }
          return null;
        },
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }


  _juvenileText(bool isDarkThemeOn) {
    return Text(
      context.l10n.juvenileConfText,
      style: TextStyle(
        color:
            isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.grey_blue,
        fontSize: 16.0,
      ),
    );
  }

  _termAndCondition(bool isDarkThemeOn) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Screen.common_web_view_screen,
        arguments: Url.TNC_URL,
      ),
      child: Text(
        context.l10n.termsAndConditions,
        style: TextStyle(
          color: isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
          fontSize: 16.0,
        ),
      ),
    );
  }

  _generateOtpButton(bool isDarkThemeOn) {
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpReceived) {
          setState(() {
            isGenerateOtpLoading = false;
          });
          String? otp = state.otpResponse.data?.mobVerificationCode;
          if (otp != null) {
            PushNotification.show(otp: otp);
          }
          Navigator.pop(context);
          RegistrationBottomSheet.show(
            context: context,
            referCode: referController.text,
            mobNumber: mobController.text.trim(),
            password: passController.text.trim(),
            currencyCode: currencyDropDownItemValue.toString().split(" ")[0],
            countryCode: countryItemList.where((element) => element.countryName == countryDropDownItemValue).first.countryCode ?? "",
            referTextController: referController,
            title: context.l10n.enterOtp,
            isDarkThemeOn: isDarkThemeOn,
          );
        } else if (state is CheckMobileNoAvailabilityLoading) {
          setState(() {
            isGenerateOtpLoading = true;
          });
          BottomSheetTheme.show(
            context: context,
              enableDrag: false,
            sheet: SabanzuriBottomSheet(
              description: [
                WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Lottie.asset('assets/lottie/gradient_loading.json'),
                  ).py(16),
                )
              ],
              isDarkThemeOn: isDarkThemeOn,
            ),
            isDarkThemeOn: isDarkThemeOn,
          );
        } else if (state is OtpError) {
          setState(() {
            isGenerateOtpLoading = false;
          });
          Navigator.of(context).pop();
          Alert.show(
            title: context.l10n.registrationError,
            subtitle: state.otpResponse.errorMessage!,
            buttonText: context.l10n.ok.toUpperCase(),
            context: context,
            isDarkThemeOn: isDarkThemeOn,
          );
        } else if(state is CheckMobileNoAvailabilityError) {
          setState(() {
            isGenerateOtpLoading = false;
          });
          Navigator.of(context).pop();
          Alert.show(
            title: context.l10n.registrationError,
            subtitle: state.errorMessage!,
            buttonText: context.l10n.ok.toUpperCase(),
            context: context,
            isDarkThemeOn: isDarkThemeOn,
          );
        }
      },
      child: PrimaryButton(
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
          if (_registrationForm.currentState!.validate()) {
            print("validateInput(TotalTextFields.mobileNumber): ${validateInput(TotalTextFields.mobileNumber)}");
            print("validateInput(TotalTextFields.password): ${validateInput(TotalTextFields.password)}");
            print("validateInput(TotalTextFields.confirmPassword): ${validateInput(TotalTextFields.confirmPassword)}");
            if (countryDropDownItemValue == countryDropDownItemList[0]) {
              countryShakeController.shake();
              setState(() {
                isNewValueCountryChosen = true;
              });
              return;

            } else if (currencyDropDownItemValue == getHardcodedCurrencyList()[0]) {
              currencyShakeController.shake();
              setState(() {
                isNewValueCurrencyChosen = true;
              });
              return;
            }
            isInternetConnect().then((value) {
              if(value) {
                BlocProvider.of<OtpBloc>(context).add(RegisterCheckMobileNoAvailabilityEvent(context: context, mobileNo: mobController.text));
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
        text: context.l10n.generateOtp.toUpperCase(),
        borderRadius: 67,
        isDarkThemeOn: isDarkThemeOn,
      ),
    );
  }

  String validateInput(TotalTextFields textField) {
    switch(textField) {
      case TotalTextFields.mobileNumber :
        print("mb");
        var mobText = mobController.text.trim();
        if (mobText.isEmpty) {
          return context.l10n.enterMobileNumber;

        } else if (mobText.length > 16) {
          return context.l10n.enterValidMobNumber;
        }
        print("mb1");

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
      case TotalTextFields.oldPassword:
        // TODO: Handle this case.
        break;
    }
    return "";
  }


}
