import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_type.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';

class ChangePasswordLogout extends StatefulWidget {
  const ChangePasswordLogout({Key? key}) : super(key: key);

  @override
  State<ChangePasswordLogout> createState() => _ChangePasswordLogoutState();
}

class _ChangePasswordLogoutState extends State<ChangePasswordLogout> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      final bool isDarkThemeOn =
          context.watch<SwitchCubit>().state.isDarkThemeOn;
      if (UserInfo.isLoggedIn() || state is AuthLoggedIn || state is UserInfoUpdated) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          height: 50,
          decoration: BoxDecoration(
            color: isDarkThemeOn
                ? SabanzuriColors.grey_blue
                : SabanzuriColors.navy,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Screen.change_password_screen);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.vpn_key_outlined,
                            color: Colors.white,
                          ).px8(),
                          FittedBox(
                            child: Text(
                              context.l10n.changePassword,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const VerticalDivider(
                color: Colors.white,
                width: 1,
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Alert.show(
                        type: AlertType.confirmation,
                        title: context.l10n.logout.toUpperCase(),
                        subtitle: context.l10n.logoutConfirmation,
                        buttonText: context.l10n.ok.toUpperCase(),
                        context: context,
                        isCloseButton: true,
                        isDarkThemeOn: isDarkThemeOn,
                        buttonClick: _onConfirmLogout,
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ).px4(),
                            Text(
                              context.l10n.logout,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ).py20();
      } else {
        return const SizedBox();
      }
    });
  }

  void _onConfirmLogout() {
    BlocProvider.of<AuthBloc>(context).add(
      UserLogout(),
    );
  }
}
