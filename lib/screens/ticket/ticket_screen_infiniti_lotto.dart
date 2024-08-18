import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/ticket_detail_infiniti_lotto_response.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/screens/ticket/ticket_widget/select_date_infiniti_lotto.dart';
import 'package:sabanzuri/screens/ticket/ticket_widget/ticket_card_infiniti_lotto.dart';
import 'package:sabanzuri/screens/ticket/ticket_widget/ticket_widget.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:velocity_x/velocity_x.dart';

import 'bloc/ticket_bloc_infiniti_lotto.dart';
import 'bloc/ticket_event_infiniti_lotto.dart';
import 'bloc/ticket_state_infiniti_lotto.dart';

class TicketScreenInfinitiLotto extends StatefulWidget {
  const TicketScreenInfinitiLotto({Key? key}) : super(key: key);

  @override
  State<TicketScreenInfinitiLotto> createState() =>
      _TicketScreenInfinitiLottoState();
}

class _TicketScreenInfinitiLottoState extends State<TicketScreenInfinitiLotto> {
  List<TicketList>? ticketList        = [];
  List<TicketList> ticketDummyList    = [];
  List<TicketList> ticketMainList     = [];

  var ticketScrollController          = ScrollController();
  bool hasMoreTickets                 = true;
  bool isLoadingForTickets            = true;
  bool isMoreTicketsAvailable         = false;
  var offset                          = 0;
  late String fromDate;
  late String toDate;
  bool isBackPressedAllowed           = true;

  @override
  void initState() {
    isInternetConnect().then((value) {
      if(value) {
        context.read<TicketBlocInfinitiLotto>().add(GetTicketInfinitiLotto(context: context, offset: null));
      } else {
        ApiService.showErrorSheet();
      }
    });

    ticketScrollController.addListener(ticketPagination);
    fromDate  = context.read<TicketBlocInfinitiLotto>().fromDate;
    toDate    = context.read<TicketBlocInfinitiLotto>().toDate;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    return BlocListener<TicketBlocInfinitiLotto, TicketStateInfinitiLotto>(
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
        if (state is TicketLoadedInfinitiLotto) {
          List<TicketList> ticketTempList = [];
          ticketList = state.ticketList?.isNotEmpty == true ? state.ticketList : [];
          //ticketList = [];
          ticketTempList = ticketList ?? [];
          setState(() {
            isLoadingForTickets = false;
          });
          ticketDummyList.addAll(ticketTempList);
          ticketMainList = ticketDummyList;
          hasMoreTickets = ticketList!.isEmpty ? false : true;

          if (ticketTempList.isNotEmpty) {
            if(ticketTempList.length < 20) {
              setState(() {
                isMoreTicketsAvailable = false;
              });
            } else {
              setState(() {
                isMoreTicketsAvailable = true;
              });
            }

          } else {
            setState(() {
              isMoreTicketsAvailable = false;
            });
          }
        }
        if (state is TicketLoadingErrorInfinitiLotto) {
          if (state.response.errorCode == AppConstants.sessionExpiryCode) {
           showSnackMsg(context, state.response.respMsg ?? "", Colors.red,
                isDarkThemeOn: isDarkThemeOn);
          } else {
            Alert.show(
              title: context.l10n.myTicketError,
              subtitle: state.response.respMsg ?? "Ticket Error",
              buttonText: context.l10n.ok.toUpperCase(),
              context: context,
              isDarkThemeOn: isDarkThemeOn,
            );
          }
        }
      },
      child:  SabanzuriScaffold(
          showDrawer: false,
          title: context.l10n.myTicket,
          child: Column(
            children: [
              Container(
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
                          SelectDateInfinitiLotto(
                            title: context.l10n.from,
                            date: fromDate,
                            onTap: () {
                              context.read<TicketBlocInfinitiLotto>().add(
                                PickFromDateInfinitiLotto(context: context),
                              );
                            },
                          ).pOnly(left: 8, right: 8),
                          SelectDateInfinitiLotto(
                            title: context.l10n.to,
                            date: context.read<TicketBlocInfinitiLotto>().toDate,
                            onTap: () {
                              context.read<TicketBlocInfinitiLotto>().add(
                                PickToDateInfinitiLotto(context: context),
                              );
                            },
                          ).pOnly(right: 8),
                          Forward(
                            isDarkThemeOn: isDarkThemeOn,
                            onTap: () {
                              setState(() {
                                ticketDummyList         = [];
                                offset                  = 0;
                                isLoadingForTickets     = true;
                                isMoreTicketsAvailable  = false;

                              });
                              isInternetConnect().then((value) {
                                if(value) {
                                  context.read<TicketBlocInfinitiLotto>().add(GetTicketInfinitiLotto(context: context, offset: offset));
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
              Flexible(
                child: SingleChildScrollView(
                  controller: ticketScrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        ticketDummyList.isEmpty
                          ? isLoadingForTickets
                            ? Column(
                                children: [
                                  const HeightBox(20),
                                  SizedBox(width: 60, height: 60, child: Lottie.asset('assets/lottie/gradient_loading.json'))
                                ],
                              )
                             : ticketList!.isEmpty == true
                                ? Column(
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
                                )
                               : Container()

                          : AnimationLimiter(
                            child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (ticketDummyList.length),
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 350),
                                child: SlideAnimation(
                                  verticalOffset: 50,
                                  child: InkWell(
                                    onTap: () {
                                      if (ticketDummyList[index].serviceCode.toString().toLowerCase() != "ige") {
                                        Navigator.pushNamed(
                                            context,
                                            Screen.ticket_webview_screen,
                                            arguments: {
                                              "transactionId" : ticketDummyList[index].transactionId.toString() ,
                                              "gameType": ticketDummyList[index].serviceCode.toString().toLowerCase(),
                                              "gameName": ticketDummyList[index].gameName,
                                              "refTxnNo": ticketDummyList[index].refTxnNo
                                            }
                                        );
                                      }

                                    },
                                    child: TicketCardInfinitiLotto(
                                        isDarkThemeOn: isDarkThemeOn,
                                        ticketList: ticketDummyList[index]),
                                  ),
                                ),
                              );
                            },
                        ),
                          ),
                      isMoreTicketsAvailable
                          ? SizedBox(width: 60, height: 60, child: Lottie.asset('assets/lottie/gradient_loading.json'))
                          : Container()

                    ],
                  ),
                ),
              ),
            ],

          ),
        )
      /*listener: (context, state) {

      },*/
    );
  }

  void ticketPagination() {
    if (ticketScrollController.position.pixels == ticketScrollController.position.maxScrollExtent) {
      if (hasMoreTickets) {
        setState(() {
          offset += int.parse(AppConstants.ticketLimit);
        });
        isInternetConnect().then((value) {
          if(value) {
            context.read<TicketBlocInfinitiLotto>().add(GetTicketInfinitiLotto(context: context, offset: offset));
          } else {
            ApiService.showErrorSheet();
          }
        });

      }
    }
  }
}
