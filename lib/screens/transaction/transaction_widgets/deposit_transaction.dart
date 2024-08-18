part of 'transaction_widget.dart';

class DepositTransaction extends StatefulWidget {
  const DepositTransaction({Key? key}) : super(key: key);

  @override
  State<DepositTransaction> createState() => _DepositTransactionState();
}

class _DepositTransactionState extends State<DepositTransaction> {
  List<TxnList>? transactionList = [];

  @override
  void initState() {
    context.read<TransactionBloc>().add(
          GetTransaction(
            context: context,
            txnType: AppConstants.txnDeposit,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    return BlocConsumer<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoaded) {
          transactionList = state.transactionList;
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TransactionDate(
              isDarkThemeOn: isDarkThemeOn,
              txnType: AppConstants.txnDeposit,
            ),
            isDarkThemeOn
                ? const SizedBox()
                : Container(
                    width: context.screenWidth,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: SabanzuriColors.grey_blue,
                        width: 1,
                      ),
                    ),
                  ),
            Flexible(
              fit: FlexFit.loose,
              child: Stack(
                children: [
                  transactionList!.isEmpty&& state is TransactionLoaded
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: context.screenHeight / 3,
                              child: Lottie.asset('assets/lottie/no_data.json'),
                            ),
                            Text(
                                "${context.l10n.noTransactionAvailableMsg} \n ${context.l10n.pleaseCheckForAnotherDates}",
                                style: const TextStyle(
                                  color: SabanzuriColors.pumpkin_orange,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      )
                      : AnimationLimiter(
                        child: ListView.separated(
                            itemCount: (transactionList!.length + 1),
                            itemBuilder: (context, index) {
                              if (index == transactionList!.length) {
                                return const SizedBox();
                              }
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 254),
                                child: SlideAnimation(
                                  verticalOffset: 50,
                                  child: FadeInAnimation(
                                    child: TransactionCard(
                                      isDarkThemeOn: isDarkThemeOn,
                                      txnDetails: transactionList![index],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return Container(
                                width: context.screenWidth,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: SabanzuriColors.grey_blue,
                                    width: 1,
                                  ),
                                ),
                              );
                            },
                          ),
                      ),
                  state is TransactionLoading
                      ? const Center(
                          child: LoadingIndicator(),
                        )
                      : const SizedBox(),
                ],
              ),
            )
          ],
        );
      },
      listener: (context, state) {
        if (state is TransactionLoaded) {
          var txnList = state.transactionList;
          if (txnList!.isEmpty) {
            bool isDarkThemeOn =
                context.read<SwitchCubit>().state.isDarkThemeOn;
          }
        } else if (state is TransactionLoadingError){
          if (state.errorCode == AppConstants.sessionExpiryCode) {
            showSnackMsg(context, state.errorMsg ?? "", Colors.red, isDarkThemeOn: isDarkThemeOn);

          } else {
            Alert.show(
              title: context.l10n.myTicketError,
              subtitle: state.errorMsg ?? "Ticket Error",
              buttonText: context.l10n.ok.toUpperCase(),
              context: context,
              isDarkThemeOn: isDarkThemeOn,
            );
          }
        }
      },
    );
  }
}
