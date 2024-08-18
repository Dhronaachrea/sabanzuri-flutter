import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ThemeOption extends StatefulWidget {
  const ThemeOption({Key? key}) : super(key: key);

  @override
  State<ThemeOption> createState() => _ThemeOptionState();
}

class _ThemeOptionState extends State<ThemeOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<SwitchCubit, SwitchState>(builder: (context, state) {
          return FlutterSwitch(
            width: 120,
            height: 45,
            showOnOff: true,
            value: !(state.isDarkThemeOn),
            inactiveColor: SabanzuriColors.navy_blue,
            inactiveText: context.l10n.darkMode,
            valueFontSize: 12,
            inactiveTextColor: SabanzuriColors.white,
            inactiveIcon: Center(
                child: Image.asset(
              'assets/icons/dark_icon.png',
              color: SabanzuriColors.navy_blue,
              width: 100,
              height: 100,
            )),
            activeColor: SabanzuriColors.white,
            activeText: context.l10n.lightMode,
            activeTextColor: SabanzuriColors.navy,
            toggleSize: 30,
            activeIcon: Center(
                child: Image.asset(
              'assets/icons/light_icon.png',
              color: SabanzuriColors.white,
              width: 100,
              height: 100,
            )),
            activeToggleColor: SabanzuriColors.navy_blue,
            switchBorder: Border.all(
                color: !(state.isDarkThemeOn)
                    ? SabanzuriColors.navy
                    : SabanzuriColors.white_two,
                width: 4),
            onToggle: (value) {
              log("value = $value");
              setState(
                () {
                  context.read<SwitchCubit>().toggleSwitch(!value);
                },
              );
            },
          ).p(4);
        }),
      ],
    );
  }
}
