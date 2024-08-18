part of "refer_widget.dart";

class ReferralLink extends StatelessWidget {
  final bool isDarkThemeOn;

  ReferralLink({
    Key? key,
    required this.isDarkThemeOn,
  }) : super(key: key);

  String url = 'https://www-wls.infinitilotto.com/refer-friend';

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [6, 7],
      color: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy_blue,
      child: InkWell(
        onTap: () {
          print("->");
          Share.share("$url/?data=${UserInfo.getReferCode}", subject: "Invite Link");
        },
        child: Row(
          children: [
            Image.asset(
              'assets/icons/feather_link.png',
              color: isDarkThemeOn
                  ? SabanzuriColors.white
                  : SabanzuriColors.navy_blue,
              width: 24,
              height: 16,
            ).p(8),
            const WidthBox(2),
            FittedBox(
              child: Text(
                url,
                style: TextStyle(
                  color: isDarkThemeOn
                      ? SabanzuriColors.white
                      : SabanzuriColors.navy_blue,
                  fontWeight: FontWeight.w400,
                  fontFamily: "SegoeUI",
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ).pOnly(right: 8),
            )
          ],
        ),
      ),
    ).px16();
  }
  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse("$url/?data=${UserInfo.getReferCode}"))) {
      throw 'Could not launch $url/?data=${UserInfo.getReferCode}';
    }
  }
}
