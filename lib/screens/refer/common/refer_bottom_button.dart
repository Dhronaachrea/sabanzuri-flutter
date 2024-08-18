import 'package:flutter/material.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ReferBottomButton extends StatelessWidget {
  final bool isDarkThemeOn;
  final VoidCallback onTap;
  final String title;

  const ReferBottomButton({
    Key? key,
    required this.isDarkThemeOn,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: isDarkThemeOn
            ? SabanzuriColors.dark_indigo
            : SabanzuriColors.pale_lilac,
      ),
      child: PrimaryButton(
        fillDisableColor: SabanzuriColors.shamrock_green,
        text: title,
        textSize: 20,
        onPressed: onTap,
      ).pSymmetric(v: 5, h: 40),
    );
  }
}
