import 'package:flutter/material.dart';

import 'package:sabanzuri/utils/sabanzuri_colors.dart';

enum AppTheme {
  LightAppTheme,
  DarkAppTheme,
}

final appThemeData = {
  AppTheme.DarkAppTheme: ThemeData(
    scaffoldBackgroundColor: SabanzuriColors.navy,
    primaryColor: SabanzuriColors.navy,
    drawerTheme: const DrawerThemeData(
      backgroundColor: SabanzuriColors.navy,
    ),
    listTileTheme: const ListTileThemeData(
      style: ListTileStyle.drawer,
    ),
    textTheme: const TextTheme(
      //To Style Drawer heading
      headline3: TextStyle(
        color: SabanzuriColors.yellow_orange,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      // to style drawer subheading list tile title
      bodyText1: TextStyle(
        color: SabanzuriColors.white,
        fontSize: 18,
      ),
    ),
  ),
  AppTheme.LightAppTheme: ThemeData(
    scaffoldBackgroundColor: SabanzuriColors.white,
    primaryColor: SabanzuriColors.white,
    drawerTheme: const DrawerThemeData(
      backgroundColor: SabanzuriColors.white,
    ),
    listTileTheme: const ListTileThemeData(
      style: ListTileStyle.drawer,
    ),
    textTheme: const TextTheme(
      headline3: TextStyle(
        color: SabanzuriColors.navy,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
        color: SabanzuriColors.dolphin,
        fontSize: 18,
      ),
    ),
  )
};
