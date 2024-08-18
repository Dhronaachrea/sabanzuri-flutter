import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_gender_event.dart';

enum Gender { Male, Female }

class UpdateGenderBloc extends Bloc<UpdateGenderEvent, Gender> {
  UpdateGenderBloc() : super(Gender.Male) {
    on<UpdateGenderEvent>(_onUpdateGender);
  }

  Gender gender = Gender.Male;

  FutureOr<void> _onUpdateGender(
      UpdateGenderEvent event, Emitter<Gender> emit) {
    gender = event.gender;
    emit(gender);
  }
}
