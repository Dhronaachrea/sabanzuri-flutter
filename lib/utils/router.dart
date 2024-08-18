import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/ScanLogin/Scan_Login_screen.dart';
import 'package:sabanzuri/screens/common_web_view/common_web_view_screen.dart';
import 'package:sabanzuri/screens/home/bloc/check_bonus/check_bonus_bloc.dart';
import 'package:sabanzuri/screens/home/game_cubit/dge_game_cubit.dart';
import 'package:sabanzuri/screens/home/game_cubit/ige_game_cubit.dart';
import 'package:sabanzuri/screens/home/infinity_home_screen.dart';
import 'package:sabanzuri/screens/home/lobby%20_game_cubit/game_list_cubit.dart';
import 'package:sabanzuri/screens/inbox/bloc/inbox_bloc.dart';
import 'package:sabanzuri/screens/inbox/inbox_screen.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/withdraw_initiate_bloc.dart';
import 'package:sabanzuri/screens/initiate_withdraw/withdrawal_initiate_screen.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/init_game_cubit.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/lobby_draw_game_cubit.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/lobby_ige_game_cubit.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/lobby_sports_lottery_cubit.dart';
import 'package:sabanzuri/screens/lobby/lobby_screen.dart';
import 'package:sabanzuri/screens/password/forgot/bloc/forgot_password_bloc.dart';
import 'package:sabanzuri/screens/password/forgot/forgot_password_screen.dart';
import 'package:sabanzuri/screens/password/change/bloc/change_password_bloc.dart';
import 'package:sabanzuri/screens/password/change/change_password_screen.dart';
import 'package:sabanzuri/screens/profile/profile_bloc.dart';
import 'package:sabanzuri/screens/profile/profile_screen.dart';
import 'package:sabanzuri/screens/quicklink/result_screen.dart';
import 'package:sabanzuri/screens/refer/bloc/refer_bloc.dart';
import 'package:sabanzuri/screens/refer/refer_a_friend_screen.dart';
import 'package:sabanzuri/screens/refer/track_status_screen.dart';
import 'package:sabanzuri/screens/registration/bloc/registration_bloc.dart';
import 'package:sabanzuri/screens/registration/registration_screen.dart';
import 'package:sabanzuri/screens/splash/bloc/splash_bloc.dart';
import 'package:sabanzuri/screens/splash/splash_screen.dart';
import 'package:sabanzuri/screens/ticket/bloc/ticket_bloc.dart';
import 'package:sabanzuri/screens/ticket/bloc/ticket_bloc_infiniti_lotto.dart';
import 'package:sabanzuri/screens/ticket/ticket_screen_infiniti_lotto.dart';
import 'package:sabanzuri/screens/ticket/ticket_webview_screen_infiniti.dart';
import 'package:sabanzuri/screens/transaction/bloc/transaction_bloc.dart';
import 'package:sabanzuri/screens/transaction/transaction_screen.dart';
import 'package:sabanzuri/screens/update_profile/bloc/gender/update_gender_bloc.dart';
import 'package:sabanzuri/screens/update_profile/bloc/update_profile_bloc.dart';
import 'package:sabanzuri/screens/update_profile/update_profile_screen.dart';
import 'package:sabanzuri/screens/wallet/bloc/wallet_bloc.dart';
import 'package:sabanzuri/screens/wallet/wallet_screen.dart';
import 'package:sabanzuri/screens/wallet/wallet_widget/deposit_webview.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/screens/otp/bloc/otp_bloc.dart';
import 'package:sabanzuri/widgets/drawer/drawer_widgets/app_version/sabanzuri_version_cubit.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<SabanzuriVersionCubit>(
                  create: (BuildContext context) => SabanzuriVersionCubit(),
                ),
                BlocProvider<SplashBloc>(
                  create: (BuildContext context) => SplashBloc(),
                ),
              ],
              child: const SplashScreen(),
            );
          },
        );
      case Screen.home_screen:
        var isFirstTimeLogin = settings.arguments as bool?;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<DgeGameCubit>(
                create: (BuildContext context) => DgeGameCubit(),
              ),
              BlocProvider<IgeGameCubit>(
                create: (BuildContext context) => IgeGameCubit(),
              ),
              BlocProvider<GameListCubit>(
                create: (BuildContext context) => GameListCubit(),
              ),
              BlocProvider<CheckBonusBloc>(
                create: (BuildContext context) => CheckBonusBloc(),
              ),
              BlocProvider<AuthBloc>(
                create: (BuildContext context) => AuthBloc(),
              ),
              BlocProvider<RegistrationBloc>(
                create: (BuildContext context) => RegistrationBloc(),
              ),
            ],
            // child: const HomeScreen(),
            child: InfinityHomeScreen(isFirstTimeLogin: isFirstTimeLogin),
          ),
        );

      case Screen.lobby_screen:
        var gameName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (BuildContext context) => InitGameCubit()),
              BlocProvider(
                  create: (BuildContext context) => LobbyDrawGameCubit()),
              BlocProvider(
                  create: (BuildContext context) => LobbyIgeGameCubit()),
              BlocProvider(
                  create: (BuildContext context) => LobbySportLotteryCubit()),
            ],
            child: GameLobby(gameName: gameName),
          ),
          settings: settings,
        );

      case Screen.registration_screen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => OtpBloc(),
            child: const RegistrationScreen(),
          ),
        );
      case Screen.forgot_password_screen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => ForgotPasswordBloc(),
              child: const ForgotPasswordScreen()),
        );
      case Screen.profile_screen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProfileBloc(),
            child: const UserProfile(),
          ),
        );
      case Screen.update_profile_screen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => UpdateGenderBloc(),
              ),
              BlocProvider(
                create: (context) => UpdateProfileBloc(),
              ),
            ],
            child: const UpdateProfile(),
          ),
        );
      case Screen.ticket_screen_infiniti_lotto:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TicketBlocInfinitiLotto(),
              ),
            ],
            child: const TicketScreenInfinitiLotto(),
          ),
        );
      case Screen.wallet_screen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => WalletBloc(),
              ),
              BlocProvider(
                create: (context) => WithdrawalInitiateBloc(),
              ),
            ],
            child: const WalletScreen(),
          ),
        );
      case Screen.deposit_webview:
        var mapValue = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => DepositWebView(mapValue: mapValue),
          settings: settings,
        );
      case Screen.transaction_screen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TransactionBloc(),
              ),
              BlocProvider(
                create: (context) => TicketBloc(),
              ),
            ],
            child: const TransactionScreen(),
          ),
        );
      case Screen.inbox_screen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => InboxBloc(),
              ),
            ],
            child: const InboxScreen(),
          ),
        );
      case Screen.result_screen:
        String resultType = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ResultScreen(resultType: resultType),
        );

        case Screen.ticket_webview_screen:
          Map<String, dynamic> ticketDetail = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => TicketWebViewScreen(ticketDetail: ticketDetail),
        );

      case Screen.common_web_view_screen:
        String url = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => CommonWebViewScreen(url: url),
        );
      case Screen.change_password_screen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ChangePasswordBloc(),
            child: const ChangePasswordScreen(),
          ),
        );
      case Screen.refer_a_friend_screen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ReferBloc(),
              ),
            ],
            child: const ReferAFriend(),
          ),
        );
      case Screen.track_status_screen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ReferBloc(),
              ),
            ],
            child: const TrackStatusScreen(),
          ),
        );

      case Screen.withdrawal_initiate_screen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => WithdrawalInitiateBloc(),
              ),
            ],
            child: const WithdrawalInitiateScreen(),
          ),
        );

        case Screen.scan_screen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => RegistrationBloc(),
              ),
            ],
            child: const ScanLoginScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) {
          return const SplashScreen();
        });
    }
  }
}
