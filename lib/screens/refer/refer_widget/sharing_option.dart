part of "refer_widget.dart";

class SharingOption extends StatelessWidget {
  final bool isDarkThemeOn;

  const SharingOption({Key? key, required this.isDarkThemeOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SharingWidget(
          isDarkThemeOn: isDarkThemeOn,
          path: "assets/icons/gmail.png",
          title: context.l10n.gmail,
          onShare: () {
            log("gmail on share is called");
            FlutterSocialContentShare.shareOnEmail(
              recipients: ["xxxx.xxx@gmail.com"],
              subject: "Subject appears here",
              body: "Body appears here",
              isHTML: true,
            );
          },
        ),
        SharingWidget(
          isDarkThemeOn: isDarkThemeOn,
          path: "assets/icons/simple_facebook.png",
          title: context.l10n.facebook,
          onShare: () {
            log("fb on share is called");
            // flutterShareMe.shareToFacebook();
            FlutterSocialContentShare.share(
                // type: ShareType.facebookWithoutImage,
                type: ShareType.facebookWithoutImage,
                url: "https://www.apple.com",
                quote: "captions");
          },
        ),
        SharingWidget(
          isDarkThemeOn: isDarkThemeOn,
          path: "assets/icons/twitter.png",
          title: context.l10n.twitter,
          onShare: () {
            log("twitter on share is called");
            flutterShareMe.shareToTwitter();
          },
        ),
      ],
    );
  }
}
