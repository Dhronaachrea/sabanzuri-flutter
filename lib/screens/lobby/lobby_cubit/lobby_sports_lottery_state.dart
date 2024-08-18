import 'package:sabanzuri/screens/lobby/lobby_model/sport_lottery_response.dart';

abstract class LobbySportLotteryState {}

class LobbySportLotteryInitial extends LobbySportLotteryState {}

class LobbySportLotteryLoading extends LobbySportLotteryState {}

class LobbySportLotteryError extends LobbySportLotteryState {
  final String error;

  LobbySportLotteryError({required this.error});
}

class LobbySportLotteryLoaded extends LobbySportLotteryState {
  SportLotteryResponse sportLotteryResponse;
  LobbySportLotteryLoaded({required this.sportLotteryResponse});
}
