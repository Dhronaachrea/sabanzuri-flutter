part of 'refer_widget.dart';

class ChooseHowToInvite extends StatelessWidget {
  final bool isDarkThemeOn;

  const ChooseHowToInvite({Key? key, required this.isDarkThemeOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6000000238418579,
      child: Text(context.l10n.chooseHowToInvite,
          style: TextStyle(
            color: isDarkThemeOn ? SabanzuriColors.white_two : SabanzuriColors.brownish_grey_three,
            fontWeight: FontWeight.w400,
            fontFamily: "SegoeUI",
            fontStyle: FontStyle.normal,
            fontSize: 18,
          ),
          textAlign: TextAlign.center),
    );
  }
}
