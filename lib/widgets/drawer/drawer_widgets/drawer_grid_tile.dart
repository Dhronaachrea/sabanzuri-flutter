import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class DrawerGridTile extends StatelessWidget {
  final AssetImage icon;
  final String title;
  final VoidCallback? onTap;

  const DrawerGridTile({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    return InkWell(
      onTap: onTap != null
          ? () {
              Navigator.pop(context);
              onTap!();
            }
          : () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: SabanzuriColors.grey_blue,
            width: 0.5,
          ),
        ),
        child: Column(
          children: [
            const HeightBox(10),
            SizedBox(
              height: 30,
              width: 48,
              child: Image(
                image: icon,
                color: isDarkThemeOn ? Colors.white : SabanzuriColors.navy,
              ),
            ).p(10),
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                  color: isDarkThemeOn ? Colors.white : SabanzuriColors.navy,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ).p(10),
            ),
          ],
        ),
      ),
    );
  }
}
