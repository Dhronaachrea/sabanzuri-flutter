part of 'profile_widget.dart';

class UpdateButton extends StatefulWidget {
  final bool isDarkThemeOn;

  const UpdateButton({Key? key, required this.isDarkThemeOn}) : super(key: key);

  @override
  State<UpdateButton> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      borderRadius: 10.0,
      fillEnableColor: widget.isDarkThemeOn
          ? SabanzuriColors.spaceCadet
          : SabanzuriColors.water,
      fillDisableColor: widget.isDarkThemeOn
          ? SabanzuriColors.spaceCadet
          : SabanzuriColors.water,
      width: double.infinity,
      text: context.l10n.update.toUpperCase(),
      textColor: widget.isDarkThemeOn
          ? SabanzuriColors.yellow_orange
          : SabanzuriColors.navy,
      onPressed: () {
        Navigator.pushNamed(
          context,
          Screen.update_profile_screen,
        );
      },
    ).pSymmetric(v: 10, h: 20);
  }
}
