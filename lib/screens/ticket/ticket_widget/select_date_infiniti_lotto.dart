import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/screens/ticket/bloc/ticket_bloc_infiniti_lotto.dart';
import 'package:sabanzuri/screens/ticket/bloc/ticket_state_infiniti_lotto.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class SelectDateInfinitiLotto extends StatefulWidget {
  final String title;
  final String date;
  final VoidCallback onTap;

  const SelectDateInfinitiLotto({
    Key? key,
    required this.title,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SelectDateInfinitiLotto> createState() => _SelectDateInfinitiLottoState();
}

class _SelectDateInfinitiLottoState extends State<SelectDateInfinitiLotto> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketBlocInfinitiLotto, TicketStateInfinitiLotto>(
      builder: (context, state) {
        return InkWell(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              color: SabanzuriColors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              border: Border.all(
                color: SabanzuriColors.navy.withOpacity(0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: SabanzuriColors.navy.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.italic,
                      fontSize: 16.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.date,
                      style: const TextStyle(
                          color: SabanzuriColors.navy,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0),
                    ),
                    const WidthBox(20),
                    Image.asset(
                      "assets/icons/down_arrow.png",
                      width: 15,
                      height: 20,
                      color: SabanzuriColors.navy,
                    ),
                  ],
                ),
              ],
            ).pSymmetric(v: 4, h: 12),
          ),
        );
      },
    );
  }
}
