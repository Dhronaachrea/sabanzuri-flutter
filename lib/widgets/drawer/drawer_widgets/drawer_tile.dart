import 'package:flutter/material.dart';

import 'package:sabanzuri/utils/sabanzuri_colors.dart';

class DrawerTile extends StatelessWidget {
  final String heading;
  final IconData? icon;
  final AssetImage? image;
  final VoidCallback? onTap;
  final VoidCallback? onClick;
  final Widget? trailing;

  const DrawerTile({
    Key? key,
    required this.heading,
    this.icon,
    this.image,
    this.onTap,
    this.onClick,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: SabanzuriColors.grey_blue, width: 0.5),
        ),
      ),
      child: ListTile(
        leading: image != null
            ? Image(
                width: 40,
                height: 40,
                image: image!,
              )
            : null,
        title: Text(
          heading,
        ),
        trailing: trailing,
        onTap: onClick != null
            ? () {
                onClick!();
              }
            : onTap != null
                ? () {
                    Navigator.pop(context);
                    onTap!();
                  }
                : () => Navigator.pop(context),
      ),
    );
  }
}
