part of 'wallet_widget.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    context.read<WalletBloc>().add(WithdrawalPaymentOption());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state is! WithdrawalPaymentOptionLoaded) {
          return const Center(child: LoadingIndicator());
        } else {
          var paymentOption = state.paymentOption;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaymentOption(
                  paymentOption: state.paymentOption,
                ),
                const SelectAccount(),
                CurrencyAmount(
                  amountController: amountController,
                ),
                const HeightBox(10),
                Row(
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
                              isDeposit: false,
                              isDarkThemeOn: false,
                              context: context,
                              onConfirm: () {
                                Navigator.pop(context);
                                context.read<WalletBloc>().add(
                                      Withdrawal(
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
                        text: context.l10n.withdraw.toUpperCase(),
                      ),
                    ),
                  ],
                ),
                const HeightBox(20),
                const HorizontalBorder(),
              ],
            ).pSymmetric(
              h: 12,
              v: 8,
            ),
          );
        }
      },
    );
  }
}
