import 'package:flutter/material.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';

class GradientLine extends StatelessWidget {
  final double? height;
  final BorderRadius? borderRadius;

  const GradientLine({Key? key, this.height, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 10.0,
      decoration: BoxDecoration(
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(0)),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            SabanzuriColors.reddish_pink,
            SabanzuriColors.sunflower_yellow,
            SabanzuriColors.lightish_red,
            SabanzuriColors.vivid_blue,
          ],
        ),
      ),
    );
  }
}
