
import 'package:sabanzuri/model/response/CheckBonusStatusResponse.dart';

abstract class CheckBonusState {
  const CheckBonusState();
}

class CheckBonusInitial extends CheckBonusState {}

class CheckBonusSuccess extends CheckBonusState {
  final List<Data>? responseData;
  CheckBonusSuccess(this.responseData);
}
