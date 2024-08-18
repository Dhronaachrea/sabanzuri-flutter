import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/ticket_response.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/screens/ticket/ticket_widget/ticket_card.dart';
import 'package:sabanzuri/screens/ticket/ticket_widget/ticket_widget.dart';
import 'package:sabanzuri/utils/loading_indicator.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:velocity_x/velocity_x.dart';

import 'bloc/ticket_bloc.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  List<TicketList>? ticketList = [];

  @override
  void initState() {
    context.read<TicketBloc>().add(GetTicket(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) {
        bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
        if (state is TicketLoaded) {
          ticketList = state.ticketList;
        }
        return SabanzuriScaffold(
          showDrawer: false,
          title: context.l10n.myTicket,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: isDarkThemeOn
                    ? SabanzuriColors.sky_blue.withOpacity(0.3)
                    : SabanzuriColors.white,
                constraints: BoxConstraints(
                  minHeight: context.screenHeight / 7,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SelectDate(
                      title: context.l10n.from,
                      date: context.read<TicketBloc>().fromDate,
                      onTap: () {
                        context.read<TicketBloc>().add(
                              PickFromDate(context: context),
                            );
                      },
                    ),
                    SelectDate(
                      title: context.l10n.to,
                      date: context.read<TicketBloc>().toDate,
                      onTap: () {
                        context.read<TicketBloc>().add(
                              PickToDate(context: context),
                            );
                      },
                    ),
                    Forward(
                      isDarkThemeOn: isDarkThemeOn,
                      onTap: () {
                        context.read<TicketBloc>().add(
                              GetTicket(
                                context: context,
                              ),
                            );
                      },
                    ),
                  ],
                ).pSymmetric(v: 16, h: 10),
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
              Expanded(
                child: Stack(
                  children: [
                    ticketList!.isEmpty
                        ? const SizedBox()
                        : ListView.separated(
                            itemCount: (ticketList!.length + 1),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index == ticketList!.length) {
                                return const SizedBox();
                              }
                              return TicketCard(
                                isDarkThemeOn: isDarkThemeOn,
                                ticketDetails: ticketList![index],
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
                          ),
                    state is TicketLoading
                        ? const Center(
                            child: LoadingIndicator(),
                          )
                        : const SizedBox(),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
