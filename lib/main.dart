import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sabanzuri/screens/registration/bloc/registration_bloc.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/DeepLinkHandler.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';
import 'package:sabanzuri/utils/router.dart';
import 'package:sabanzuri/utils/shared_prefs.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'l10n/l10n.dart';
import 'screens/password/change/bloc/change_password_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefUtils.init();
  await FkUserAgent.init();
  DeepLinkHandler.initPlatformState();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  print("Internet -> ${await InternetConnectionChecker().hasConnection}");
  isInternetConnect().then((value) => print("Internet function: $value"));
  /*var listener = InternetConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        print('Data connection is available.');
        break;
      case InternetConnectionStatus.disconnected:
        print('You are disconnected from the internet.');
        break;
    }
  });*/
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => SwitchCubit(),
        ),
        BlocProvider(
          create: (context) => RegistrationBloc(),
        ),
        BlocProvider(
          create: (context) => ChangePasswordBloc(),
        )
      ],
      child: const SabanzuriApp(),
    ),
  );
}

class SabanzuriApp extends StatefulWidget {
  const SabanzuriApp({Key? key}) : super(key: key);

  @override
  State<SabanzuriApp> createState() => _SabanzuriAppState();

  static _SabanzuriAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_SabanzuriAppState>()!;
}

class _SabanzuriAppState extends State<SabanzuriApp> {
  final AppRouter router = AppRouter();
  Locale _locale = const Locale('en', 'UK');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchCubit, SwitchState>(
      builder: (context, state) {
        return MaterialApp(
          theme: state.theme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: router.generateRoute,
          locale: _locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          navigatorObservers: [routeObserver],
          navigatorKey: navigatorKey,
        );
      },
    );
  }
}
