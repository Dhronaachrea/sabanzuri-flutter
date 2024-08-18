import 'package:flutter/material.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/utils.dart';

enum ButtonType {
  solid,
  line_art,
}

class PrimaryButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final bool? enabled;
  final Widget? child;
  final double? borderRadius;
  final double? width;
  final EdgeInsets? margin;
  final double? height;
  final ButtonType? type;
  final Color? textColor;
  final Color? borderColor;
  final Color? fillEnableColor;
  final Color? fillDisableColor;
  final bool? isDarkThemeOn;
  final double? textSize;

  const PrimaryButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.enabled,
    this.child,
    this.borderRadius,
    this.width,
    this.margin,
    this.height,
    this.type = ButtonType.solid,
    this.textColor,
    this.borderColor,
    this.fillEnableColor,
    this.fillDisableColor,
    this.isDarkThemeOn = true,
    this.textSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var enabledStyle = ElevatedButton.styleFrom(
      primary: fillEnableColor ??
          (isDarkThemeOn! ? SabanzuriColors.azul : SabanzuriColors.navy),
      onPrimary: Colors.white,
      shadowColor: fillEnableColor ??
          (isDarkThemeOn! ? SabanzuriColors.azul : SabanzuriColors.navy),
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
      ),
    );
    var disabledStyle = ElevatedButton.styleFrom(
      primary: fillDisableColor ?? SabanzuriColors.grey_blue,
      onPrimary: Colors.white,
      shadowColor: fillDisableColor ?? SabanzuriColors.grey_blue,
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
      ),
      side: borderColor != null
          ? BorderSide(
              width: 2,
              color: borderColor!,
            )
          : null,
    );
    var lineArtStyle = ElevatedButton.styleFrom(
      primary: Colors.transparent,
      onPrimary: isDarkThemeOn! ? SabanzuriColors.azul : SabanzuriColors.navy,
      // textColor
      shadowColor: Colors.transparent,
      elevation: 10,
      onSurface: SabanzuriColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
      ),
      side: BorderSide(
        width: 2,
        color: borderColor ??
            (isDarkThemeOn! ? SabanzuriColors.azul : SabanzuriColors.navy),
      ),
    );
    return Container(
      height: height ?? 51,
      width: width,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 12),
      child: ElevatedButton(
        onPressed: () {
          if (isRedundentClick()) return;
          onPressed();
        },
        style: type == ButtonType.solid
            ? (enabled == true ? enabledStyle : disabledStyle)
            : lineArtStyle,
        child: text != null
            ? FittedBox(
                fit: BoxFit.fitHeight,
                child: Center(
                  child: Text(
                    text!,
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: textSize ?? 17,
                      fontWeight: FontWeight.w700,
                      color: (type == ButtonType.line_art)
                          ? textColor ??
                              (isDarkThemeOn!
                                  ? SabanzuriColors.azul
                                  : SabanzuriColors.navy)
                          : textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : child,
      ),
    );
  }
}
