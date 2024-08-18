import 'package:flutter/material.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sabanzuri/utils/gradient_line.dart';

class SabanzuriBottomSheet extends StatefulWidget {
  final String? title;
  final List<Widget>? description;
  final bool? isDarkThemeOn;
  final Widget? bottomWidget;

  const SabanzuriBottomSheet({
    this.title,
    this.description,
    this.isDarkThemeOn = true,
    this.bottomWidget,
    Key? key,
  }) : super(key: key);

  @override
  State<SabanzuriBottomSheet> createState() => _SabanzuriBottomSheetState();
}

class _SabanzuriBottomSheetState extends State<SabanzuriBottomSheet> {
  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = widget.isDarkThemeOn ?? true;
    return Container(
      color: isDarkModeOn ? SabanzuriColors.navy : SabanzuriColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const GradientLine(),
          widget.title != null ? const HeightBox(30) : const SizedBox(),
          HeaderText(
            title: widget.title ?? '',
          ),
          widget.title != null ? const HeightBox(20) : const SizedBox(),
          SingleChildScrollView(
            child: _buildBody(),
          ),
          _buildBottom()
        ],
      ),
    );
  }

  _buildBody() {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.description != null
            ? widget.description!
            : [const SizedBox()],
      ).px24(),
    );
  }

  _buildBottom() {
    return widget.bottomWidget ?? const SizedBox();
  }
}

class HeaderText extends StatelessWidget {
  final String title;

  const HeaderText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 26,
          color: SabanzuriColors.yellow_orange,
          fontWeight: FontWeight.w700,
        ),
      ).px20(),
    );
  }
}

class BottomSheetTheme {
  static show({
    required BuildContext context,
    required SabanzuriBottomSheet sheet,
    Color? backgroundColor,
    bool? enableDrag,
    bool? isDarkThemeOn,
  }) {
    final bool isDarkModeOn = isDarkThemeOn ?? true;
    return showModalBottomSheet(
      backgroundColor: backgroundColor ??
          (isDarkModeOn ? SabanzuriColors.navy : SabanzuriColors.white),
      isScrollControlled: false,
      isDismissible: false,
      enableDrag: enableDrag ?? true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return sheet;
        });
      },
    );
  }
}
