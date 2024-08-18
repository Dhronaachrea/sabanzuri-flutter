import "package:flutter/material.dart";
import 'package:velocity_x/velocity_x.dart';

import 'package:sabanzuri/utils/sabanzuri_colors.dart';

class DrawerTitle extends StatelessWidget {
  final String title;

  const DrawerTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: SabanzuriColors.grey_blue, width: 0.5),
        ),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ).p(10),
    ).px4();
  }
}
