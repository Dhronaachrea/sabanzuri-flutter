import 'package:flutter/cupertino.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/ticket_response.dart';
import 'package:sabanzuri/utils/date_format.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class TicketCard extends StatefulWidget {
  final TicketList ticketDetails;
  final bool isDarkThemeOn;

  const TicketCard({
    Key? key,
    required this.ticketDetails,
    required this.isDarkThemeOn,
  }) : super(key: key);

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  @override
  Widget build(BuildContext context) {
    String txnDate = formatDate(
      date: widget.ticketDetails.transactionDate.toString(),
      inputFormat: Format.apiDateFormat2,
      outputFormat: Format.dateFormat10,
    );
    String amount =
        double.parse(widget.ticketDetails.amount ?? "0.0").toStringAsFixed(2);
    return SizedBox(
      height: context.screenHeight / 7.5,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    "assets/icons/my_tickets_game_image_${widget.ticketDetails.gameId}.png"),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.ticketDetails.gameName ?? "",
                  style: TextStyle(
                    color: widget.isDarkThemeOn
                        ? SabanzuriColors.yellow_orange
                        : SabanzuriColors.rusty_red,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                const Spacer(),
                Text(
                  context.l10n.txnId +
                      ": ${widget.ticketDetails.transactionId}",
                  style: const TextStyle(
                    color: SabanzuriColors.pinkish_grey,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.italic,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  txnDate,
                  style: const TextStyle(
                    color: SabanzuriColors.pinkish_grey,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.italic,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ).pSymmetric(v: 16, h: 8),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  context.l10n.kes.toUpperCase() + " $amount",
                  // " ${widget.ticketDetails.amount}",
                  style: TextStyle(
                    color: widget.isDarkThemeOn
                        ? SabanzuriColors.sickly_yellow
                        : SabanzuriColors.ultramarine,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ).pSymmetric(v: 16, h: 8),
          ),
        ],
      ),
    );
  }
}
