part of 'refer_widget.dart';

class ReferInformationText extends StatelessWidget {
  final bool isDarkThemeOn;

  const ReferInformationText({Key? key, required this.isDarkThemeOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.bonusEligibilityText + "\n\n" + context.l10n.howToShareText,
      style: TextStyle(
        color: isDarkThemeOn
            ? SabanzuriColors.white_two
            : SabanzuriColors.brownish_grey_three,
        fontWeight: FontWeight.w400,
        fontFamily: "SegoeUI",
        fontStyle: FontStyle.normal,
        fontSize: 18.0,
      ),
      textAlign: TextAlign.center,
    ).px16();
  }
}
