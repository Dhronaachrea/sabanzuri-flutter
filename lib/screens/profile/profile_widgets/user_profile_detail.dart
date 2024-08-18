part of 'profile_widget.dart';

class UserProfileDetail extends StatefulWidget {
  final bool isDarkThemeOn;
  final String userName;

  final String mobNumber;
  final String email;
  final String dob;
  final String gender;
  final String address;

  const UserProfileDetail({
    Key? key,
    required this.isDarkThemeOn,
    required this.userName,
    required this.mobNumber,
    required this.email,
    required this.dob,
    required this.gender,
    required this.address,
  }) : super(key: key);

  @override
  State<UserProfileDetail> createState() => _UserProfileDetailState();
}

class _UserProfileDetailState extends State<UserProfileDetail> {
  double horizontalTilePadding = 20.0;
  late Color titleColor;
  late Color subtitleColor;
  String dob = '';
  String gender = "Male";

  @override
  Widget build(BuildContext context) {
    titleColor = SabanzuriColors.Manatee;
    subtitleColor = widget.isDarkThemeOn
        ? SabanzuriColors.white
        : SabanzuriColors.russianViolet;
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileListTile(
            icon: Icon(
              Icons.person,
              color: subtitleColor,
              size: 30,
            ),
            title: context.l10n.name,
            titleColor: titleColor,
            subtitle: widget.userName,
            //"user name",
            subtitleColor: subtitleColor,
          ),
          HeightBox(horizontalTilePadding),
          ProfileListTile(
            icon: Icon(
              Icons.phone_android,
              color: subtitleColor,
              size: 30,
            ),
            title: context.l10n.mobileNumber,
            titleColor: titleColor,
            subtitle: widget.mobNumber,
            //"+ 254- 1111111111",
            subtitleColor: subtitleColor,
          ),
          HeightBox(horizontalTilePadding),
          ProfileListTile(
            icon: Icon(
              Icons.email_outlined,
              color: subtitleColor,
              size: 30,
            ),
            title: context.l10n.email,
            titleColor: titleColor,
            subtitle: widget.email,
            //"abc@gmail.com",
            subtitleColor: subtitleColor,
          ),
          HeightBox(horizontalTilePadding),
          ProfileListTile(
            icon: Icon(
              Icons.cake_outlined,
              color: subtitleColor,
              size: 30,
            ),
            title: context.l10n.dateOfBirth,
            titleColor: titleColor,
            subtitle: widget.dob,
            //"May 8, 2003",
            subtitleColor: subtitleColor,
          ),
          HeightBox(horizontalTilePadding),
          ProfileListTile(
            icon: Icon(
              Icons.male,
              color: subtitleColor,
              size: 30,
            ),
            title: context.l10n.gender,
            titleColor: titleColor,
            subtitle: widget.gender,
            //"Male",
            subtitleColor: subtitleColor,
          ),
          HeightBox(horizontalTilePadding),
          ProfileListTile(
            icon: Icon(
              Icons.location_on_outlined,
              color: subtitleColor,
              size: 30,
            ),
            title: context.l10n.address,
            titleColor: titleColor,
            subtitle: widget.address,
            //"abc Kenya",
            subtitleColor: subtitleColor,
          ),
        ],
      ).pSymmetric(h: 20, v: 10),
    );
  }
}
