part of 'profile_widget.dart';

class UserName extends StatefulWidget {
  final bool isDarkThemeOn;
  final String userName;

  const UserName(
      {Key? key, required this.userName, required this.isDarkThemeOn})
      : super(key: key);

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.userName,
      style: TextStyle(
          color: widget.isDarkThemeOn
              ? SabanzuriColors.white
              : SabanzuriColors.russianViolet,
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
          fontStyle: FontStyle.normal,
          fontSize: 21.0),
    );
  }
}
