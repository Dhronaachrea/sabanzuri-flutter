part of "refer_widget.dart";

class SharingWidget extends StatelessWidget {
  final bool isDarkThemeOn;
  final String path;
  final String title;
  final VoidCallback onShare;

  const SharingWidget({
    Key? key,
    required this.isDarkThemeOn,
    required this.path,
    required this.title,
    required this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onShare();
      },
      child: Column(
        children: [
          Image.asset(
            path,
            width: 50,
            height: 40,
          ),
          const HeightBox(15),
          Text(title.toUpperCase(),
              style: TextStyle(
                  color: isDarkThemeOn
                      ? SabanzuriColors.white_two
                      : SabanzuriColors.warm_grey_four,
                  fontWeight: FontWeight.w300,
                  fontFamily: "SegoeUI",
                  fontStyle: FontStyle.normal,
                  fontSize: 18),
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
