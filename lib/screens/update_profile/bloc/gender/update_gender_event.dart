part of 'update_gender_bloc.dart';

@immutable
abstract class UpdateProfileEvent {}

class UpdateGenderEvent extends UpdateProfileEvent {
  final Gender gender;

  UpdateGenderEvent({required this.gender});
}
