import 'package:http/http.dart';
import 'package:sabanzuri/model/dge_game_model.dart';
import 'package:sabanzuri/model/response/CheckBonusStatusResponse.dart';
import 'package:sabanzuri/model/response/CountryListResponse.dart';
import 'package:sabanzuri/model/response/FullRegistrationOtpResponse.dart';
import 'package:sabanzuri/model/response/ResendWithdrawalOtpResponse.dart';
import 'package:sabanzuri/model/response/change_password_response.dart';
import 'package:sabanzuri/model/response/check_availability_response.dart';
import 'package:sabanzuri/model/response/deposit_response.dart';
import 'package:sabanzuri/model/response/get_balance_response.dart';
import 'package:sabanzuri/model/response/inbox_response.dart';
import 'package:sabanzuri/model/response/payment_option_response.dart';
import 'package:sabanzuri/model/response/ticket_detail_infiniti_lotto_response.dart';
import 'package:sabanzuri/model/response/ticket_response.dart';
import 'package:sabanzuri/model/response/track_status_response.dart';
import 'package:sabanzuri/model/response/transaction_response.dart';
import 'package:sabanzuri/model/response/update_profile_response.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/FetchPendingScanNPlayWithdrawalResponse.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/GetConfigValueResponse.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/WithdrawalInitiateResponse.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/NewDrawGamesResponse.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/ige_game_response.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/init_game_response.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/sport_lottery_response.dart';
import 'package:sabanzuri/services/microservices/base_service.dart';
import 'package:sabanzuri/model/ige_game_model.dart';
import 'package:sabanzuri/services/microservices/cashier_service.dart';
import 'package:sabanzuri/services/microservices/ticket_result_service.dart';
import 'package:sabanzuri/model/response/otp_response.dart';
import 'package:sabanzuri/services/microservices/ram_service.dart';
import 'package:sabanzuri/model/response/registration_response.dart';
import 'package:sabanzuri/model/response/version_response.dart';
import 'package:sabanzuri/services/microservices/weaver_service.dart';
import 'package:sabanzuri/model/response/header_response.dart';

class Repository {
  /* --------------- DRAWER Service --------------- */
  static Future<DgeGameModel?> fetchDgeGame(String? screenName) =>
      BaseService.fetchDgeGame(screenName!);

  /* --------------- TICKET RESULT Service --------------- */

  static Future<IgeGameModel?> fetchIgeGame() =>
      TicketResultService.fetchIgeGame();

  /* --------------- RAM Service --------------- */
  static Future<CountryListResponse?> getCountryList(
          Map<String, dynamic> request) =>
      RamService.getCountryList(request);

  static Future<OtpResponse?> getOtp(Map<String, dynamic> request) =>
      RamService.getOtp(request);

  static Future<RegistrationResponse?> register(Map<String, dynamic> request) =>
      RamService.register(request);

  static Future<RegistrationResponse?> login(Map<String, dynamic> request) =>
      RamService.login(request);

  static Future<RegistrationResponse?> loginByQr(Map<String, dynamic> request) =>
      RamService.loginByQr(request);

  static Future<UpdateProfileResponse?> updateProfile(
          Map<String, String> request) =>
      RamService.updateProfile(request);

  static Future<FullRegistrationOtpResponse?> callGetOtpProfileUpdate(
      Map<String, String> request) =>
      RamService.callGetOtpProfileUpdate(request);

  /* --------------- Infinity Games Service --------------- */
  Future<InitGameResponse?> initGames(Map<String, dynamic> params) =>
      WeaverService.initGames(params);

  Future<NewDrawGamesResponse> fetchDrawGames(Map<String, dynamic> params) =>
      WeaverService.drawGames(params);

  Future<IgeGameResponse?> fetchIgeGames(Map<String, dynamic> params) =>
      WeaverService.igeGames(params);

  static Future<dynamic> fetchIgeGamesSplash(Map<String, dynamic> params) =>
      WeaverService.igeGamesSplash(params);

  Future<SportLotteryResponse?> fetchSportLotteryGames(
          Map<String, dynamic> params) =>
      WeaverService.sportLotteryGames(params);

  /* --------------- WEAVER Service --------------- */
  static Future<VersionResponse?> version(Map<String, dynamic> request) =>
      WeaverService.version(request);

  static Future<HeaderResponse?> fetchHeader(Map<String, dynamic> request) =>
      WeaverService.fetchHeader(request);

  static Future<GetBalanceResponse?> getBalance(Map<String, dynamic> request) =>
      WeaverService.getBalance(request);

  static Future<CheckBonusStatusResponse?> checkBonusStatus(Map<String, dynamic> request) =>
      WeaverService.checkBonusStatus(request);

  static Future<GetBalanceResponse?> refreshBalance(
          Map<String, dynamic> request) =>
      WeaverService.refreshBalance(request);

  static Future uploadAvatar(Map<String, dynamic> params, MultipartFile file) =>
      WeaverService.uploadAvatar(params, file);

  static Future<TicketResponse?> getTicket(Map<String, dynamic> request) =>
      WeaverService.getTicket(request);

  static Future<TicketDetailInfinitiLottoResponse?> getTicketInfinitiLotto(
          Map<String, dynamic> request) =>
      WeaverService.getTicketInfinitiLotto(request);

  static Future<TicketDetailInfinitiLottoResponse?>
      getInfinitiLottoTicketDetails(Map<String, dynamic> request) =>
          WeaverService.getTicketInfinitiLotto(request);

  static Future<TransactionResponseModel?> getTransaction(
          Map<String, dynamic> request) =>
      WeaverService.getTransaction(request);

  static Future<InboxResponseModel?> getInbox(Map<String, dynamic> request) =>
      WeaverService.getInbox(request);

  static Future<InboxResponseModel?> inboxActivity(
          Map<String, dynamic> request) =>
      WeaverService.inboxActivity(request);

  static Future<ChangePasswordResponseModel?> changePassword(
          Map<String, dynamic> request) =>
      WeaverService.changePassword(request);

  static Future<ChangePasswordResponseModel?> changeInitialPassword(
          Map<String, dynamic> request) =>
      WeaverService.changeInitialPassword(request);

  static Future<ChangePasswordResponseModel?> sendOtp(
          Map<String, dynamic> request) =>
      WeaverService.sendOtp(request);

  static Future<ChangePasswordResponseModel?> resetPassword(
          Map<String, dynamic> request) =>
      WeaverService.resetPassword(request);

  static Future<CheckAvailabilityResponse?> checkAvailability(
          Map<String, dynamic> request) =>
      WeaverService.checkAvailability(request);

  static Future<ChangePasswordResponseModel?> inviteFriend(
      Map<String, dynamic> request) =>
      WeaverService.inviteFriend(request);

  static Future<TrackStatusResponseModel?> trackStatus(
      Map<String, dynamic> request) =>
      WeaverService.trackStatus(request);

  /* --------------- CASHIER Service --------------- */
  static Future<Map<String, dynamic>> getPaymentOption(
          Map<String, dynamic> request) =>
      CashierService.getPaymentOption(request);

  static Future<PaymentOptionResponse?> getWithdrawPaymentOption(
      Map<String, dynamic> request) =>
      CashierService.getWithdrawPaymentOption(request);

  static Future<Map<String, dynamic>> getWithdrawalPaymentOption(Map<String, dynamic> request) =>
      CashierService.getWithdrawalPaymentOption(request);

  static Future<DepositResponse?> withdrawalRequest(
          Map<String, dynamic> request) =>
      CashierService.withdrawalRequest(request);

  static Future<WithdrawalInitiateResponse?> callWithdrawalInitiateApi(Map<String, dynamic> request) =>
      CashierService.callWithdrawalInitiateApi(request);

  static Future<FetchPendingScanNPlayWithdrawalResponse?> callFetchScanNPlayPendingWithdrawalApi(Map<String, dynamic> request) =>
      CashierService.callFetchScanNPlayPendingWithdrawalApi(request);

  static Future<GetConfigValueResponse?> callGetConfigValueApi(Map<String, dynamic> request) =>
      CashierService.callGetConfigValueApi(request);

  static Future<ResendWithdrawalOtpResponse?> callResendWithdrawalOtp(Map<String, dynamic> request) =>
      CashierService.callResendWithdrawalOtp(request);
}
