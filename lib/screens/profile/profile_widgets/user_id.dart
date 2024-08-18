part of 'profile_widget.dart';

class UserId extends StatefulWidget {
  final bool isDarkThemeOn;
  final String userId;

  const UserId({Key? key, required this.userId, required this.isDarkThemeOn})
      : super(key: key);

  @override
  State<UserId> createState() => _UserIdState();
}

class _UserIdState extends State<UserId> {
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      color: widget.isDarkThemeOn
          ? SabanzuriColors.yellow_orange
          : SabanzuriColors.russianViolet,
      fontWeight: FontWeight.w400,
      fontFamily: "Roboto",
      fontStyle: FontStyle.normal,
      fontSize: 21.0,
    );
    return Text(
      context.l10n.id.toUpperCase() + " #${widget.userId}",
      style: style,
    );
  }
}
