import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/model/dge_game_model.dart';
import 'package:sabanzuri/screens/home/bloc/home_timer_bloc.dart';

class GameTimer extends StatefulWidget {
  final Fivebyninety dgeGame;
  final CurrentTime currentTime;

  const GameTimer({Key? key, required this.dgeGame, required this.currentTime})
      : super(key: key);

  @override
  State<GameTimer> createState() => _GameTimerState();
}

class _GameTimerState extends State<GameTimer> {
  @override
  void initState() {
    BlocProvider.of<HomeTimerBloc>(context).add(
      TimerStarted(
        drawDateTime: widget.dgeGame.drawDate!,
        currentDateTime: widget.currentTime.date!,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String days = '00';
    String hours = '00';
    String minutes = '00';
    String seconds = '00';
    return BlocBuilder<HomeTimerBloc, HomeTimerState>(
      builder: (context, state) {
        if (state is TimerRunInProgress) {
          days = state.days;
          hours = state.hours;
          minutes = state.minutes;
          seconds = state.seconds;
        }
        if (state is TimerRunComplete) {
          days = '00';
          hours = '00';
          minutes = '00';
          seconds = '00';
          context.read<HomeTimerBloc>().add(const TimerReset());
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimeWidget(title: context.l10n.d.toUpperCase(), counter: days),
            TimeWidget(title: context.l10n.h.toUpperCase(), counter: hours),
            TimeWidget(title: context.l10n.m.toUpperCase(), counter: minutes),
            TimeWidget(title: context.l10n.s.toUpperCase(), counter: seconds),
          ],
        );
      },
    );
  }
}

class TimeWidget extends StatefulWidget {
  final String title;
  final String counter;

  const TimeWidget({Key? key, required this.title, required this.counter})
      : super(key: key);

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 25.0,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      color: SabanzuriColors.white,
      child: Column(
        children: [
          Text(widget.counter),
          Text(widget.title),
        ],
      ),
    );
  }
}
