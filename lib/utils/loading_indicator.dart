import 'package:flutter/material.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: SabanzuriColors.yellow_orange,
    );
  }
}
