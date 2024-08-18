part of 'update_profile_widget.dart';

class ConfirmationText extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool isDarkThemeOn;

  const ConfirmationText(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.isDarkThemeOn})
      : super(key: key);

  @override
  State<ConfirmationText> createState() => _ConfirmationTextState();
}

class _ConfirmationTextState extends State<ConfirmationText> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: widget.title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: widget.isDarkThemeOn
                ? SabanzuriColors.white
                : SabanzuriColors.navy),
        children: <TextSpan>[
          const TextSpan(text: ": "),
          TextSpan(
            text: widget.subtitle,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: widget.isDarkThemeOn
                    ? SabanzuriColors.white
                    : SabanzuriColors.navy),
          ),
        ],
      ),
    );
  }
}
