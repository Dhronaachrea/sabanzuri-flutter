import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/transaction_response.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/screens/ticket/ticket_widget/ticket_widget.dart';
import 'package:sabanzuri/screens/transaction/transaction_widgets/transaction_widget.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:velocity_x/velocity_x.dart';

import 'bloc/transaction_bloc.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late Map<int, String> transactionTypeListMap;
  late Map<int, String> transactionTypeListTagMap;

  late int selectedTab;
  late var fromDate;
  late var toDate;

  List<TxnList>? transactionList        = [];
  List<TxnList> transactionDummyList    = [];
  List<TxnList> transactionMainList     = [];
  var transactionScrollController       = ScrollController();
  bool hasMoreTransactions              = true;
  bool isLoadingForTransactions         = true;
  bool isSelectableAllowed              = false;
  bool isMoreTransactionsAvailable      = false;
  var offset                            = 0;

  @override
  void initState() {
    super.initState();
    selectedTab               = 0;
    transactionTypeListMap    = {};
    transactionTypeListTagMap = {};

    isInternetConnect().then((value) {
      if(value) {
        context.read<TransactionBloc>().add(
          GetTransaction(
            context: context,
            txnType: AppConstants.txnAll,
          ),
        );
      } else {
        ApiService.showErrorSheet();
      }
    });
    fromDate = context.read<TransactionBloc>().fromDate;
    toDate = context.read<TransactionBloc>().toDate;
    transactionScrollController.addListener(transactionPagination);

  }

  @override
  Widget build(BuildContext context) {
    transactionTypeListMap[0]     = context.l10n.all;
    transactionTypeListMap[1]     = context.l10n.wager;
    transactionTypeListMap[2]     = context.l10n.deposit;
    transactionTypeListMap[3]     = context.l10n.withdrawal;
    transactionTypeListMap[4]     = context.l10n.winning;
    transactionTypeListMap[5]     = context.l10n.wagerRefund;
    transactionTypeListMap[6]     = context.l10n.withdrawalCancel;
    transactionTypeListMap[7]     = context.l10n.bonus;

    transactionTypeListTagMap[0]  = AppConstants.txnAll;
    transactionTypeListTagMap[1]  = AppConstants.txnWager;
    transactionTypeListTagMap[2]  = AppConstants.txnDeposit;
    transactionTypeListTagMap[3]  = AppConstants.txnWithdrawal;
    transactionTypeListTagMap[4]  = AppConstants.txnWinning;
    transactionTypeListTagMap[5]  = AppConstants.txnWagerRefund;
    transactionTypeListTagMap[6]  = AppConstants.txnWithdrawalCancel;
    transactionTypeListTagMap[7]  = AppConstants.txnBonus;
    bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;

    return SabanzuriScaffold(
        showDrawer: false,
        title: context.l10n.myTransactions,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              color: SabanzuriColors.white,
              child: AbsorbPointer(
                absorbing: isSelectableAllowed,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: transactionTypeListMap.length,
                  itemBuilder: (BuildContext context, int i) {
                    return i == selectedTab
                        ? Center(
                            child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedTab = i;
                                    transactionDummyList = [];
                                    offset               = 0;
                                    isLoadingForTransactions = true;
                                    isMoreTransactionsAvailable = false;
                                  });
                                  isInternetConnect().then((value) {
                                    if(value) {
                                      context.read<TransactionBloc>().add(
                                          GetTransaction(
                                              context: context,
                                              txnType: transactionTypeListTagMap
                                                  .values
                                                  .toList()[i]));
                                    } else {
                                      ApiService.showErrorSheet();
                                    }
                                  });
                                },
                                child: Container(
                                  height: 70,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              transactionTypeListMap.values.toList()[i],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: SabanzuriColors.selected_violet,
                                                fontWeight: FontWeight.w700,
                                              ),
                                          ).pOnly(top:8)
                                        ),
                                      ),
                                      Container(
                                        height: 10,
                                        width: 90,
                                        decoration: const BoxDecoration(
                                            color: SabanzuriColors.selected_violet,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                      )
                                    ],
                                  )
                                ),
                              )
                            ],
                          )).pOnly(left: 16, right: 16)
                        : Center(
                            child: FittedBox(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTab = i;
                                  transactionDummyList     = [];
                                  offset              = 0;
                                  isLoadingForTransactions = true;
                                  isMoreTransactionsAvailable = false;
                                });
                                isInternetConnect().then((value) {
                                  if(value) {
                                    context.read<TransactionBloc>().add(
                                        GetTransaction(
                                            context: context,
                                            txnType: transactionTypeListTagMap.values
                                                .toList()[i]));
                                  } else {
                                    ApiService.showErrorSheet();
                                  }
                                });

                              },
                              child: Container(
                                height: 40,
                                color: Colors.white,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        transactionTypeListMap.values.toList()[i],
                                      style: const TextStyle(color: SabanzuriColors.warm_grey_four, fontSize: 14)),
                                ),
                              ).pOnly(left: 20, right: 20),
                            ),
                          ));
                  },
                ),
              ),
            ),
            AbsorbPointer(
              absorbing: isSelectableAllowed,
              child: Container(
              color: isDarkThemeOn
                  ? SabanzuriColors.deep_shaded_blue
                  : SabanzuriColors.white,
              constraints: BoxConstraints(
                minHeight: context.screenHeight / 6,
              ),
              child: FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      isDarkThemeOn
                          ?
                      SvgPicture.asset('assets/icons/svg/calendar.svg', width: 24, height: 24)
                          :
                      SvgPicture.asset('assets/icons/svg/calendar_dark.svg', width: 24, height: 24),
                      const WidthBox(8),
                      Text("Dates", style: TextStyle(color: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.cetaceanBlue, fontSize: 16))
                    ],
                  ).pOnly(left: 24, top: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SelectDate(
                        title: context.l10n.from,
                        date: context.read<TransactionBloc>().fromDate,
                        onTap: () {
                          context.read<TransactionBloc>().add(
                            PickFromDate(context: context),
                          );
                        },
                      ).pOnly(left: 8, right: 8),
                      SelectDate(
                        title: context.l10n.to,
                        date: context.read<TransactionBloc>().toDate,
                        onTap: () {
                          context.read<TransactionBloc>().add(
                            PickToDate(context: context),
                          );
                        },
                      ).pOnly(right: 8),
                      Forward(
                        isDarkThemeOn: isDarkThemeOn,
                        onTap: () {
                          setState(() {
                            transactionDummyList     = [];
                            offset              = 0;
                            isLoadingForTransactions = true;
                            isMoreTransactionsAvailable = false;

                          });
                          isInternetConnect().then((value) {
                            if(value) {
                              context.read<TransactionBloc>().add(GetTransaction(context: context, txnType: transactionTypeListTagMap.values.toList()[selectedTab], offset: offset),);
                            } else {
                              ApiService.showErrorSheet();
                            }
                          });

                        },
                      ),
                    ],
                  ).pSymmetric(v: 16, h: 10),
                ],
                  ),
              ),
            ),
            ),
            BlocListener<TransactionBloc, TransactionState>(
              listener: (context, state) {
                if (state is FromDateUpdatedInfinitiLotto) {
                  setState(() {
                    fromDate = state.date;
                  });
                } else if (state is ToDateUpdatedInfinitiLotto) {
                  setState(() {
                    toDate = state.date;
                  });
                }
                if (state is TransactionLoaded) {

                  transactionList = [];
                  transactionList = state.transactionList;
                  List<TxnList> dgeTransactionTempList = [];
                  //ticketList = [];
                  transactionList = state.transactionList?.isNotEmpty == true ? state.transactionList : [];
                  //ticketList = [];
                  dgeTransactionTempList = transactionList ?? [];
                  setState(() {
                    isLoadingForTransactions = false;
                    isSelectableAllowed = false;
                  });
                  transactionDummyList.addAll(dgeTransactionTempList);
                  transactionMainList = transactionDummyList;
                  hasMoreTransactions = transactionList!.isEmpty ? false : true;

                  if (dgeTransactionTempList.isNotEmpty) {
                    if(dgeTransactionTempList.length < 20) {
                      setState(() {
                        isMoreTransactionsAvailable = false;
                      });
                    } else {
                      setState(() {
                        isMoreTransactionsAvailable = true;
                      });
                    }

                  } else {
                    setState(() {
                      isMoreTransactionsAvailable = false;
                    });
                  }
                } else if(state is TransactionLoading) {
                  setState(() {
                    isSelectableAllowed = true;
                  });

                }  else if (state is TransactionLoadingError) {
                  setState(() {
                    isSelectableAllowed = false;
                  });
                  if (state.errorCode == AppConstants.sessionExpiryCode) {
                    showSnackMsg(context, state.errorMsg ?? "", Colors.red,
                        isDarkThemeOn: isDarkThemeOn);
                  } else {
                    Alert.show(
                      title: context.l10n.myTransactionError,
                      subtitle: state.errorMsg ?? "Ticket Error",
                      buttonText: context.l10n.ok.toUpperCase(),
                      context: context,
                      isDarkThemeOn: isDarkThemeOn,
                    );
                  }
                }
              },
                child: Flexible(
                  child:
                  transactionDummyList.isNotEmpty
                      ? SingleChildScrollView(
                          controller: transactionScrollController,
                          child:
                          Column(mainAxisSize: MainAxisSize.min, children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              itemCount: (transactionDummyList!.length + 1),
                              itemBuilder: (context, index) {
                                if (index == transactionDummyList!.length) {
                                  return const SizedBox();
                                }
                                return TransactionCard(
                                  isDarkThemeOn: isDarkThemeOn,
                                  txnDetails:
                                  transactionDummyList![index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Container(
                                  width: context.screenWidth,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: SabanzuriColors.grey_blue,
                                      width: 0.5,
                                    ),
                                  ),
                                );
                              },
                            ),
                            /*transactionDummyList.isNotEmpty
                                ? ListView.separated(
                                  shrinkWrap: true,
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  itemCount: (transactionDummyList!.length + 1),
                                  itemBuilder: (context, index) {
                                    if (index == transactionDummyList!.length) {
                                      return const SizedBox();
                                    }
                                    return TransactionCard(
                                      isDarkThemeOn: isDarkThemeOn,
                                      txnDetails:
                                      transactionDummyList![index],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
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
                                )
                                : Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: context.screenHeight / 4,
                                    child: Lottie.asset(
                                        'assets/lottie/no_data.json'),
                                  ),
                                  Text(
                                      "${context.l10n.noTransactionAvailableMsg} \n ${context.l10n.pleaseCheckForAnotherDates}",
                                      style: const TextStyle(
                                        color:
                                        SabanzuriColors.pumpkin_orange,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            ),*/

                            isMoreTransactionsAvailable
                                ? SizedBox(width: 60, height: 60, child: Lottie.asset('assets/lottie/gradient_loading.json'))
                                : Container()

                          ]))
                      :
                        isLoadingForTransactions
                           ?
                              Center(
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Lottie.asset(
                                      'assets/lottie/gradient_loading.json'),
                                ),

                              )
                           : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: context.screenHeight / 4,
                                child: Lottie.asset(
                                    'assets/lottie/no_data.json'),
                              ),
                              Text(
                                  "${context.l10n.noTransactionAvailableMsg} \n ${context.l10n.pleaseCheckForAnotherDates}",
                                  style: const TextStyle(
                                    color:
                                    SabanzuriColors.pumpkin_orange,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        )
                )
            ),
          ],
        )

        /*TransactionTabBar(
        tabBarTitles: [
          Tab(text: context.l10n.all),
          Tab(text: context.l10n.wager),
          Tab(text: context.l10n.deposit),
          Tab(text: context.l10n.withdrawal),
          Tab(text: context.l10n.winning),
          Tab(text: context.l10n.cashIn),
          Tab(text: context.l10n.cashOut),
        ],
        tabBarViews: const [
          AllTransaction(),
          WagerTransaction(),
          DepositTransaction(),
          WithdrawalTransaction(),
          WinningTransaction(),
          CashInTransaction(),
          CashOutTransaction(),
        ],
      ),*/
        );
  }

  void transactionPagination() {
    if (transactionScrollController.position.pixels == transactionScrollController.position.maxScrollExtent) {
      if (hasMoreTransactions) {
        setState(() {
          offset += int.parse(AppConstants.ticketLimit) + 1;
        });
        isInternetConnect().then((value) {
          if(value) {
            context.read<TransactionBloc>().add(GetTransaction(context: context, offset: offset, txnType: transactionTypeListTagMap.values.toList()[selectedTab]));
          } else {
            ApiService.showErrorSheet();
          }
        });

      }
    }
  }
}
