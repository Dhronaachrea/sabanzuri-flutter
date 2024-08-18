import 'package:flutter/material.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';

class PullToRefresh extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const PullToRefresh({Key? key, required this.child, required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      color: SabanzuriColors.yellow_orange,
      displacement: 60,
      // backgroundColor: ZeplinColors.aquamarine,
      edgeOffset: 50,
      strokeWidth: 3,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
