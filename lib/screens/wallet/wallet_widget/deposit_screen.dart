part of 'wallet_widget.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({Key? key}) : super(key: key);

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  TextEditingController amountController = TextEditingController();
  Map<String, dynamic>? paymentOption;
  bool isLoading = false;
  int? paymentTypeId  = 0;
  int? providerId     = 0;
  int? subTypeId      = 0;
  List<WithdrawalInitiatePaymentOptionData> paymentOptionList = [];
  bool isPaymentOptionCall = false;
  double minValueLimit = 0;
  double maxValueLimit = 0;
  int selectedPaymentIndex      = -1;
  double mAnimatedButtonSize    = 280.0;
  double mAnimatedButtonHeight  = 50.0;
  ButtonShrinkStatus mButtonShrinkStatus = ButtonShrinkStatus.notStarted;
  bool mButtonTextVisibility = true;

  @override
  void initState() {
    context.read<WalletBloc>().add(DepositPaymentOption());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    return BlocListener<WalletBloc, WalletState>(

        listener: (context, state) {
          if (state is DepositPaymentOptionLoading) {
            setState(() {
              isPaymentOptionCall = true;
            });
          }
      else if (state is DepositPaymentOptionLoaded) {
        setState(() {
          isLoading = false;
          paymentOption = state.paymentOption;
          isPaymentOptionCall = false;

          setState(() {
            Map<String, dynamic> paymentOptions = state.paymentOption["payTypeMap"];

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

          });

        });

      } else if (state is DepositPaymentOptionError) {
        setState(() {
          isLoading = false;
          isPaymentOptionCall = false;
        });
      }

    },

      child: isLoading
              ? const Center(child: LoadingIndicator(),)
              : paymentOptionList.isEmpty
                ? Center(
                    child: Column(
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
          /*PaymentOption(
                    paymentOption: paymentOption,
                  ),*/
          _paymentOptions(),
          if (selectedPaymentIndex != -1)...[
            AbsorbPointer(
              absorbing: false,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: SabanzuriTextField(
                  maxLength: 8,
                  inputType: TextInputType.number,
                  hintText: "Deposit Amount",
                  controller: amountController,
                  prefix: const Icon(
                    Icons.wallet,
                    color: SabanzuriColors.shamrock_green,
                  ),
                  isDarkThemeOn: isDarkThemeOn,
                ).pSymmetric(v: 8),
              ),
            ),
            InkWell(
              onTap: () {
                if (amountController.text.isEmptyOrNull) {
                  ShowToast.showToast("Enter a amount first", context, type: ToastType.ERROR);
                } else {
                  // call api for deposit
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
                                context.l10n.deposit,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: isDarkThemeOn ? SabanzuriColors.navy_blue : SabanzuriColors.white,
                                ),
                              ),
                            ))),
                  )),
            ).pOnly(top: 30)
          ]
          /*const SelectAccount(),
                  CurrencyAmount(amountController: amountController),
                  const HeightBox(10),
                  Text(
                    context.l10n.amountSuggestions,
                    style: const TextStyle(
                        color: SabanzuriColors.warm_grey_two,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Arial",
                        fontStyle: FontStyle.normal,
                        fontSize: 15.5),
                    textAlign: TextAlign.left,
                  ).pSymmetric(h: 8),*/
          /*AmountSelection(
                      amountController: amountController,
                      isDarkThemeOn: isDarkThemeOn),*/
          /*Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () {
                            var paymentType = paymentOption?.payTypeMap?.the14;
                            var paymentAccount =
                                paymentOption?.paymentAccounts?.the2756;
                            DepositModel depositModel = DepositModel(
                              amount: amountController.text.trim(),
                              currencyCode: paymentType?.currencyMap?.the15 ??
                                  AppConstants.currencyCode,
                              paymentAccId:
                              paymentAccount?.paymentAccId?.toString() ?? "",
                              paymentTypeCode:
                              (paymentType?.payTypeCode ?? "").toString(),
                              paymentTypeId:
                              (paymentType?.payTypeId ?? "").toString(),
                              subTypeId:
                              (paymentAccount?.subTypeId ?? "").toString(),
                            );
                            DepositAmountConfSheet.show(
                                isDeposit: true,
                                isDarkThemeOn: false,
                                context: context,
                                onConfirm: () {
                                  Navigator.pop(context);
                                  context.read<WalletBloc>().add(
                                    Deposit(
                                        depositModel: depositModel,
                                        context: context),
                                  );
                                },
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                                amount: depositModel.amount);
                          },
                          enabled: true,
                          fillEnableColor: SabanzuriColors.cherry,
                          borderRadius: 10,
                          text: context.l10n.deposit.toUpperCase(),
                        ),
                      ),
                    ],
                  ),*/
          // const HeightBox(20),
          // const HorizontalBorder(),
        ],
      )
    );
  }

  _paymentOptions() {
    print("------> calling payment option <------------");
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

                        InkWell(
                          onTap :() {
                            print("click ---------> ${paymentOptionList[index].displayName}");
                            setState(() {
                              selectedPaymentIndex = index;
                            });
                          },
                          child: Text(
                            paymentOptionList[index].displayName ?? "--" ,
                            style: TextStyle(
                                fontSize: 18,
                                color: (selectedPaymentIndex == index) ? Colors.red : Colors.grey,
                                fontWeight: FontWeight.w500
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ).p(12),
                        ),
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

  startBtnLoader() {
    setState(() {
      mAnimatedButtonSize   = 50.0;
      mButtonTextVisibility = false;
      mButtonShrinkStatus   = ButtonShrinkStatus.notStarted;
    });
  }

  endBtnLoader() {
    setState(() {
      mAnimatedButtonSize = 280.0;
      mButtonTextVisibility = true;
      mButtonShrinkStatus = ButtonShrinkStatus.over;
    });
  }
}
