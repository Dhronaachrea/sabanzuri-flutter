part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class BalanceRefreshing extends ProfileState {}

class BalanceRefreshed extends ProfileState {}

class BalanceRefreshError extends ProfileState {
  final GetBalanceResponse response;

  BalanceRefreshError({required this.response});
}
