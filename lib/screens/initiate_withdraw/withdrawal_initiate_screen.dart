import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/dge_game_model.dart';
import 'package:sabanzuri/model/response/WithdrawalInitiatePaymentOptionResponse.dart';
import 'package:sabanzuri/screens/initiate_withdraw/WithdrawalPhoneNoDialog.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/FetchPendingScanNPlayWithdrawalResponse.dart' as fetchPendingWithdrawal;
import 'package:sabanzuri/screens/initiate_withdraw/bloc/withdraw_initiate_event.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:sabanzuri/model/ige_game_model.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/show_toast.dart';
import '../../utils/user_info.dart';
import 'package:velocity_x/velocity_x.dart';

import 'bloc/withdraw_initiate_bloc.dart';
import 'bloc/withdraw_initiate_state.dart';

class WithdrawalInitiateScreen extends StatefulWidget {
  final bool? showAppBar;
  const WithdrawalInitiateScreen({Key? key, this.showAppBar}) : super(key: key);

  @override
  State<WithdrawalInitiateScreen> createState() => _WithdrawalInitiateScreenState();
}

class _WithdrawalInitiateScreenState extends State<WithdrawalInitiateScreen> with SingleTickerProviderStateMixin {
  DgeGameModel? dgeGameModel;
  IgeGameModel? igeGameModel;
  final FocusNode focusNode = FocusNode();
  TextEditingController withdrawalAmountController = TextEditingController();
  double mAnimatedButtonSize = 280.0;
  double mAnimatedButtonHeight = 50.0;
  double bannerHeight = 0.0;
  bool isLoggingIn = false;
  bool mButtonTextVisibility = true;
  bool isDarkThemeOn = false;
  bool isFinished = false;
  bool isFetchingPendingWithdrawal = false;
  int anonWithdrawalLimit = 0;
  ButtonShrinkStatus mButtonShrinkStatus = ButtonShrinkStatus.notStarted;
  int? paymentTypeId  = 0;
  int? providerId     = 0;
  int? subTypeId      = 0;
  List<fetchPendingWithdrawal.Data> fetchPendingScanNplayWithdrawalList = [];
  late AnimationController animationController;
  List<WithdrawalInitiatePaymentOptionData> paymentOptionList = [];
  int selectedPaymentIndex = -1;
  double minValueLimit = 0;
  double maxValueLimit = 0;
  bool isResendWithdrawalOtpCalled = false;
  int isResendWithdrawalOtpClickedIndex = -1;
  bool isPaymentOptionCall = false;

  @override
  void initState() {
    print("-------------->${UserInfo.profileType}");
    BlocProvider.of<WithdrawalInitiateBloc>(context).add(WithdrawalPaymentOptionEvent());
    BlocProvider.of<WithdrawalInitiateBloc>(context).add(FetchScanNPlayPendingWithdrawalCallApiEvent());
    if(UserInfo.profileType == "ANONYMOUS"){
        BlocProvider.of<WithdrawalInitiateBloc>(context).add(
          GetConfigValueCallApiEvent()
        );
    }
    animationController = AnimationController(vsync: this);

    animationController.addListener(() {
      if (animationController.value >= 0.68) {
        animationController.stop();
      }
    });

    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    FocusScope.of(context).requestFocus(focusNode);
    String? cashBalance = context.watch<AuthBloc>().cashBalance ?? UserInfo.cashBalance;// total balance
    // withdrawalAmountController.text = cashBalance;
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SabanzuriScaffold(
      title: "Withdraw Initiate",
      showDrawer: false,
      showAppBar: widget.showAppBar ?? true,
      child: BlocListener<AuthBloc, AuthState>(
          listener : (cxt, state) {
            if (state is AuthLoggedOut) {
              setState(() {
                isLoggingIn = false;
              });
              resetLoader();
              Future.delayed(const Duration(milliseconds: 1500), () {
                Navigator.of(context).pop();
              });
            }
          },
          child: BlocListener<WithdrawalInitiateBloc, WithdrawInitiateState>(
        listener: (BuildContext context, state) {
          switch(state.runtimeType) {
            case WithdrawInitiateLoading: {
              setState(() {
                isLoggingIn = true;
              });
            }
            break;
            case WithdrawInitiateSuccess: {
              setState(() {
                isLoggingIn = false;
                resetLoader();
                fetchHeaderInfo(context);
                BlocProvider.of<WithdrawalInitiateBloc>(context).add(FetchScanNPlayPendingWithdrawalCallApiEvent());
                selectedPaymentIndex = -1;
                withdrawalAmountController.text = "";
                Navigator.pushNamedAndRemoveUntil(context, Screen.home_screen, (route) => false);
                ShowToast.showToast("${(state as WithdrawInitiateSuccess).responseData.respMsg}", context, type: ToastType.SUCCESS);
              });

            }
            break;
            case WithdrawInitiateError: {
              setState(() {
                isLoggingIn = false;
                resetLoader();
              });
              ShowToast.showToast("${(state as WithdrawInitiateError).errorMessage}", context, type: ToastType.ERROR);
            }

            break;
            case GetConfigValueSuccess: {
              setState(() {
                isLoggingIn         = false;
                anonWithdrawalLimit = int.parse((state as GetConfigValueSuccess).responseData.responseData?.data?.aNONWITHDRAWALLIMIT ?? "0");
                print("=====> limit ----> $anonWithdrawalLimit");
              });
            }
            break;
            case GetConfigValueError: {
              setState(() {
                isLoggingIn = false;
                resetLoader();
              });
            }
            break;
            case WithdrawalPaymentOptionLoading : {
              setState(() {
                isPaymentOptionCall = true;
              });
            }
            break;
            case WithdrawalPaymentOptionLoaded:{
             setState(() {
               Map<String, dynamic> paymentOptions = (state as WithdrawalPaymentOptionLoaded).paymentOption["payTypeMap"];

               for( String key in paymentOptions.keys) {

                 Map<String, dynamic> subTypeIdJson     = paymentOptions[key]["subTypeMap"];
                 Map<String, dynamic> providerIdJson    = paymentOptions[key]["providerMap"];

                 for (String key in subTypeIdJson.keys) {
                   subTypeId  =   int.parse(key);
                 }

                 for (String key in providerIdJson.keys) {
                   providerId  =   int.parse(key);
                 }

                  paymentOptionList.add(
                    WithdrawalInitiatePaymentOptionData(
                      paymentTypeId: paymentOptions[key]["payTypeId"] ?? 0,
                      subTypeId: subTypeId,
                      providerId: providerId,
                      displayName: paymentOptions[key]["payTypeDispCode"] ?? "--",
                      maxValue: paymentOptions[key]["maxValue"],
                      minValue: paymentOptions[key]["minValue"]
                    )
                  );
               }

               isPaymentOptionCall = false;
               print("---------------------------------------------------------");
               print("===================> $paymentOptionList");


             });

            }
            break;

            case WithdrawalPaymentOptionError:{
              setState(() {
                isLoggingIn = false;
                isPaymentOptionCall = false;
                resetLoader();
              });
            }
            break;
            case FetchPendingScanNPlayWithdrawalLoading: {
              setState(() {
                isFetchingPendingWithdrawal = true;
              });
            }
            break;
            case FetchPendingScanNPlayWithdrawalSuccess: {
              setState(() {
                isFetchingPendingWithdrawal           = false;
                fetchPendingScanNplayWithdrawalList   = (state as FetchPendingScanNPlayWithdrawalSuccess).responseData.data ?? [];
                print("--------------> $fetchPendingScanNplayWithdrawalList");
              });
            }
            break;
            case FetchPendingScanNPlayWithdrawalError: {
              setState(() {
                isFetchingPendingWithdrawal = false;
              });
            }
            break;
            case ResendWithdrawalOtpSuccess: {
              setState(() {
                isResendWithdrawalOtpCalled = false;
                selectedPaymentIndex = -1;
                ShowToast.showToast(context.l10n.otp_sent_successfully, context, type: ToastType.SUCCESS);
              });
            }
            break;
            case ResendWithdrawalOtpError: {
              setState(() {
                isResendWithdrawalOtpCalled = false;
                ShowToast.showToast("Otp Not Send, try again", context, type: ToastType.ERROR);
              });
            }
          }

        },
        child: isPaymentOptionCall
                ? const Center(child: CircularProgressIndicator(color: SabanzuriColors.azul,))
                : paymentOptionList.isEmpty
                    ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset("assets/lottie/no_data.json", width: 250, height: 250),
                                  Text(
                                    context.l10n.no_payment_options_available,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: SabanzuriColors.violet_blue
                                    ),
                                  ),
                                ],

                              ),
                            )
                    : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Payment Options",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ).pOnly(left: 10),
                  _paymentOptions(),
                  const HeightBox(20),
                  if (selectedPaymentIndex != -1)...[
                    AbsorbPointer(
                      absorbing: false,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: SabanzuriTextField(
                          maxLength: 8,
                          inputType: TextInputType.number,
                          hintText: "Withdrawal amount",
                          focusNode: focusNode,
                          controller: withdrawalAmountController,
                          prefix: const Icon(
                            Icons.wallet,
                            color: SabanzuriColors.shamrock_green,
                          ),
                          isDarkThemeOn: isDarkThemeOn,
                        ).pSymmetric(v: 8),
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: isLoggingIn,
                      child: InkWell(
                        onTap: () {
                          if (withdrawalAmountController.text.isEmptyOrNull) {
                            ShowToast.showToast("Enter a amount first", context, type: ToastType.ERROR);
                          }
                          else {
                            if ((anonWithdrawalLimit < int.parse(withdrawalAmountController.text.toString().split(".")[0])) && UserInfo.profileType == "ANONYMOUS") {
                              // open dialog for ask phone number.
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const WithdrawalPhoneNoDialog();
                                  }
                              ).then((mobileNo)=>
                                  setState((){
                                    print("value ==============> $mobileNo");
                                    callMyWithdrawalInitiateApi(context, mobileNo);
                                  })

                              );


                            }
                            else {

                              double enteredAmount = double.parse(withdrawalAmountController.text.trim());
                              if ( enteredAmount <= maxValueLimit  && enteredAmount >= minValueLimit) {
                                if (selectedPaymentIndex != -1) {
                                  setState(() {
                                    mAnimatedButtonSize   = 50.0;
                                    mButtonTextVisibility = false;
                                    mButtonShrinkStatus   = ButtonShrinkStatus.notStarted;
                                  });
                                  BlocProvider.of<WithdrawalInitiateBloc>(context).add(WithdrawInitiateCallApiEvent(context: context, amount: withdrawalAmountController.text, paymentTypeId: paymentTypeId, providerId: providerId, subTypeId: subTypeId));
                                } else {
                                  ShowToast.showToast("Please select a payment option first.", context, type: ToastType.ERROR);
                                }
                              } else {
                                ShowToast.showToast("Entered Amount should be in range ( $minValueLimit - $maxValueLimit )", context, type: ToastType.ERROR);
                              }

                            }
                          }


                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy_blue,
                                borderRadius: BorderRadius.circular(60)),
                            child: AnimatedContainer(
                              width: mAnimatedButtonSize,
                              height: 50,
                              onEnd: () {
                                setState(() {
                                  if (mButtonShrinkStatus != ButtonShrinkStatus.over) {
                                    mButtonShrinkStatus = ButtonShrinkStatus.started;
                                  } else {
                                    mButtonShrinkStatus = ButtonShrinkStatus.notStarted;
                                  }
                                });
                              },
                              curve: Curves.easeIn,
                              duration: const Duration(milliseconds: 200),
                              child: SizedBox(
                                  width: mAnimatedButtonSize,
                                  height: mAnimatedButtonHeight,
                                  child: mButtonShrinkStatus == ButtonShrinkStatus.started
                                      ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                        color: isDarkThemeOn ? SabanzuriColors.navy_blue : SabanzuriColors.white),
                                  )
                                      : Center(
                                      child: Visibility(
                                        visible: mButtonTextVisibility,
                                        child: Text(
                                          context.l10n.withdrawal,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: isDarkThemeOn ? SabanzuriColors.navy_blue : SabanzuriColors.white,
                                          ),
                                        ),
                                      ))),
                            )),
                      ).pOnly(top: 30),
                    )
                  ]

                ],
              ),
            ).pOnly(top: 20),
            horizontalLine(),
            if (selectedPaymentIndex != -1 && paymentOptionList[selectedPaymentIndex].displayName == "SCAN_AND_PLAY")...[
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      isFetchingPendingWithdrawal
                          ?  const CircularProgressIndicator(color: SabanzuriColors.violet_blue,)
                          :  fetchPendingScanNplayWithdrawalList.isEmpty
                          ? LottieBuilder.asset(
                        "assets/lottie/no_data_lottie.json",
                        controller: animationController,
                        onLoaded: (LottieComposition composition) {
                          animationController..duration = composition.duration..forward();
                        },
                      )
                          : AnimationLimiter(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: fetchPendingScanNplayWithdrawalList.length,
                          itemBuilder: (BuildContext listContext, int index) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: SabanzuriColors.black)
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Id: ${fetchPendingScanNplayWithdrawalList[index].requestId}",
                                        style: const TextStyle(
                                          color: SabanzuriColors.warm_grey_four,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Text(
                                        "${UserInfo.getCurrencyCode} ${fetchPendingScanNplayWithdrawalList[index].amount}",
                                        style: const TextStyle(
                                          color: SabanzuriColors.navy,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: "SegoeUI",
                                        ),
                                      ),
                                      Text(
                                        "${fetchPendingScanNplayWithdrawalList[index].createdAt}",
                                        style: const TextStyle(
                                          color: SabanzuriColors.warm_grey_four,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),

                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  fetchPendingScanNplayWithdrawalList[index].otp != null
                                      ? Column(
                                    children: [
                                      Text(
                                        otpVisibility(fetchPendingScanNplayWithdrawalList[index]),
                                        style: const TextStyle(
                                          color: SabanzuriColors.navy,
                                          fontSize: 19,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: "SegoeUI",
                                        ),
                                      ),

                                      IconButton(
                                        icon: fetchPendingScanNplayWithdrawalList[index].isOtpVisible == true  ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            fetchPendingScanNplayWithdrawalList[index].isOtpVisible =  (fetchPendingScanNplayWithdrawalList[index].isOtpVisible == true) ? false : true;
                                          });
                                        },
                                      )
                                    ],
                                  )
                                      : LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
                                    return InkWell(
                                        onTap: () {
                                          // call api to get pin
                                          setState(() {
                                            isResendWithdrawalOtpCalled = true;
                                            isResendWithdrawalOtpClickedIndex = index;
                                            BlocProvider.of<WithdrawalInitiateBloc>(context).add(
                                                ResendWithdrawalOtpEvent(
                                                    userTxnId: int.parse(fetchPendingScanNplayWithdrawalList[index].userTxnId ?? "0")
                                                )
                                            );
                                          });

                                        },
                                        child: Container(
                                          width: MediaQuery.of(ctx).size.width * 0.2,
                                          height: MediaQuery.of(ctx).size.height * 0.05,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(40),
                                              color: SabanzuriColors.navy_blue
                                          ),
                                          child: Center(
                                              child: (isResendWithdrawalOtpCalled && isResendWithdrawalOtpClickedIndex == index)
                                                  ? const SizedBox(width: 25, height: 25, child: CircularProgressIndicator( color: SabanzuriColors.white,))
                                                  : Text(
                                                context.l10n.get_pin.capitalized,
                                                style: const TextStyle(
                                                    color: SabanzuriColors.white
                                                ),
                                              )
                                          ),
                                        )
                                    );
                                  })


                                ],
                              ).p(10),
                            ).pSymmetric(h: 15, v: 10);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]


          ],
        )
      )
      )
    );
  }

  resetLoader() {
    setState(() {
      mAnimatedButtonSize = 280.0;
      mButtonTextVisibility = true;
      mButtonShrinkStatus = ButtonShrinkStatus.over;
    });
  }

  callMyWithdrawalInitiateApi(BuildContext context, String mobileNo) {
    BlocProvider.of<WithdrawalInitiateBloc>(context).add(WithdrawInitiateCallApiEvent(context: context, amount: withdrawalAmountController.text, mobileNumber: mobileNo, isLimitExceed: true, paymentTypeId: paymentTypeId, providerId: providerId,subTypeId: subTypeId));
  }

  Widget horizontalLine() {
    return Container(
      height: 2,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
    ).pSymmetric(v: 20);
  }

  String otpVisibility(fetchPendingWithdrawal.Data fetchPendingScanNplayWithdrawalData) {

    return (fetchPendingScanNplayWithdrawalData.isOtpVisible == true)
              ? fetchPendingScanNplayWithdrawalData.otp ?? "--"
              : ("*" * (fetchPendingScanNplayWithdrawalData.otp ?? "").length);
  }

  _paymentOptions() {
    print(paymentOptionList);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
                crossAxisSpacing: 8
            ),
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: paymentOptionList.length,
            itemBuilder: (context, index) {
              return InkWell(
                customBorder: const RoundedRectangleBorder( // add
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)
                    )
                ),
                onTap: () {
                  setState(() {
                    selectedPaymentIndex  = index;
                    maxValueLimit         = paymentOptionList[index].maxValue ?? 0;
                    minValueLimit         = paymentOptionList[index].minValue ?? 0;
                    providerId            = paymentOptionList[index].providerId ?? 0;
                    subTypeId             = paymentOptionList[index].subTypeId ?? 0;
                    paymentTypeId         = paymentOptionList[index].paymentTypeId ?? 0;
                  });

                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border:Border.all(
                        width: 2,
                        color: (selectedPaymentIndex == index) ? Colors.red : Colors.grey
                    ),
                  ),
                  child:FittedBox(
                    child: Row(
                      children: [
                        /*Image.asset(
                          "assets/icons/${(newPaymentOptionList?.payTypeCode ?? "").toLowerCase()}.png",
                          width: 45,
                          height: 45,
                          errorBuilder: (context, exception, stackTrace) {
                            return Container();},
                        ).pOnly(left: 10),*/

                        Text(
                          paymentOptionList[index].displayName ?? "--" ,
                          style: TextStyle(
                              fontSize: 18,
                              color: (selectedPaymentIndex == index) ? Colors.red : Colors.grey,
                              fontWeight: FontWeight.w500
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ).p(12),
                      ],
                    ),
                  ),
                ).p(3),
              );
            },
          ),
        ),
      ],
    );
  }

}
