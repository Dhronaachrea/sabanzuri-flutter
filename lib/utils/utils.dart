import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/get_balance_response.dart';
import 'package:sabanzuri/screens/login/bloc/login_bloc.dart';
import 'package:sabanzuri/screens/login/login_screen.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';

import '../model/user/user.dart';
import '../repo/repository.dart';
import 'app_constants.dart';
import 'auth/auth_bloc.dart';

final navigatorKey = GlobalKey<NavigatorState>();

showSessionExpiredDialog() async {
  return Container();
}

encryptMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

enum ButtonShrinkStatus{notStarted, started, over}

prettyPrintJson(String input) {
  StringBuffer sb = StringBuffer();
  const JsonDecoder decoder = JsonDecoder();
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final dynamic object = decoder.convert(input);
  final String prettyString = encoder.convert(object);
  prettyString.split('\n').forEach((String element) => sb.writeln(element));
  log(sb.toString());
}

getVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String appVersion = version;
  return appVersion;
}

void fetchHeaderInfo(BuildContext context,{bool isDarkThemeOn = false}) async {
  var isDarkThemeOn = context.read<SwitchCubit>().state.isDarkThemeOn;
  Map<String, dynamic> request = {
    "domainName": AppConstants.domainNameInfiniti,
    "playerId": UserInfo.userId,
    "playerToken": UserInfo.userToken,
  };
  GetBalanceResponse? response = await Repository.getBalance(request);
  if (response != null) {
    if (response.errorCode == 0) {
      BlocProvider.of<AuthBloc>(context).add(
        UpdateUserInfo(
          user: User(
            cashBalance: response.wallet?.withdrawableBal != 0.0 ? response.wallet?.withdrawableBal?.toStringAsFixed(2) : response.wallet?.cashBalance?.toStringAsFixed(2)//response.wallet?.cashBalance?.toStringAsFixed(2),
          ),
        ),
      );
    } else {
      if (response.errorCode == AppConstants.sessionExpiryCode) {
        showSnackMsg(context, response.respMsg ?? "", Colors.red, isDarkThemeOn: isDarkThemeOn);

      } /*else {
        Alert.show(
          title: context.l10n.myTicketError,
          subtitle: response.respMsg ?? "getBalance Error",
          buttonText: context.l10n.ok.toUpperCase(),
          context: context,
          isDarkThemeOn: isDarkThemeOn,
        );
      }*/
    }
  }
}

Future<DateTime?> showCalendar(BuildContext context, DateTime? initialDate,
    DateTime? firstDate, DateTime? lastDate) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDatePickerMode: DatePickerMode.day,
    initialEntryMode:  DatePickerEntryMode.calendarOnly,
    initialDate: initialDate ?? DateTime(1990),
    firstDate: firstDate ?? DateTime(1900),
    lastDate:
        lastDate ?? DateTime.now().subtract(const Duration(days: 365 * 18)),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: SabanzuriColors.vivid_blue,
            onPrimary: SabanzuriColors.white,
            onSurface: SabanzuriColors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: SabanzuriColors.vivid_blue, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  ).then((pickedDate) {
    if (pickedDate == null) {
      return null;
    }
    return pickedDate;
  });
  return pickedDate;
}

formatDate({
  required String date,
  required String inputFormat,
  required String outputFormat,
}) {
  DateFormat inputDateFormat = DateFormat(inputFormat);
  DateTime input = inputDateFormat.parse(date);
  DateFormat outputDateFormat = DateFormat(outputFormat);
  return outputDateFormat.format(input);
}

void onConfirmLogout(BuildContext context) {
  BlocProvider.of<AuthBloc>(context).add(
    UserLogout(),
  );
}

List getHardcodedCurrencyList() {
  List currencyList = [];
  currencyList.add("Select Currency *");
  currencyList.add("EUR (€)");
  currencyList.add("DOGE (Ð)");
  currencyList.add("TRX (TRX)");
  currencyList.add("BTC (₿)");
  currencyList.add("LINK (LINK)");

  return currencyList;
}

showSnackMsg(BuildContext context, String msg, Color myColor,
    {bool isDarkThemeOn = false}) {
  Alert.show(
      title: "Session Expired",
      subtitle: "Login again to continue",
      buttonText: context.l10n.login,
      context: context,
      isBackPressedAllowed: false,
      isDarkThemeOn: isDarkThemeOn,
      buttonClick: () {
        onConfirmLogout(context);
        Navigator.popUntil(context, (route) => false);
        Navigator.pushNamed(context, Screen.home_screen);
        loginForSessionExpired(context);
      }
  );

  /*Flushbar(
    message: msg,
    duration: const Duration(seconds: 3),
    backgroundColor: myColor,
    flushbarStyle: FlushbarStyle.GROUNDED,
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);*/
}

 loginForSessionExpired(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: const LoginScreen(),
    ),
  );
}
bool verifyEmail(String emailId) {
  return emailId.isValidEmail();
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

DateTime? loginClickTime;

bool isRedundentClick() {
  DateTime currentTime = DateTime.now();
  if (loginClickTime == null) {
    loginClickTime = currentTime;
    return false;
  }
  if (currentTime.difference(loginClickTime!).inMilliseconds < 400) {
    return true;
  }

  loginClickTime = currentTime;
  return false;
}

enum TotalTextFields{mobileNumber, password, confirmPassword, oldPassword, otp}

Future<bool> isInternetConnect() async{
  return await InternetConnectionChecker().hasConnection;

}

