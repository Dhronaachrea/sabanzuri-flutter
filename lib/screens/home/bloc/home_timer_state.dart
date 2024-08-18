part of 'home_timer_bloc.dart';

abstract class HomeTimerState {
  const HomeTimerState();
}

class HomeTimerInitial extends HomeTimerState {
  const HomeTimerInitial() : super();
}

class TimerRunInProgress extends HomeTimerState {
  final String days;
  final String hours;
  final String minutes;
  final String seconds;

  const TimerRunInProgress({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });
}

class TimerRunComplete extends HomeTimerState {
  const TimerRunComplete();
}
