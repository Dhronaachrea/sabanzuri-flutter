part of 'refer_widget.dart';

class OrWidget extends StatelessWidget {
  final bool isDarkThemeOn;

  const OrWidget({Key? key, required this.isDarkThemeOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isDarkThemeOn
                    ? SabanzuriColors.white
                    : SabanzuriColors.navy,
              ),
            ),
          ),
        ).px16(),
        // Divider(
        //     color: isDarkThemeOn
        //         ? SabanzuriColors.white
        //         : SabanzuriColors.navy),
        Container(
          color: isDarkThemeOn ? SabanzuriColors.navy : SabanzuriColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(context.l10n.or.toUpperCase(),
              style: TextStyle(
                  color: isDarkThemeOn
                      ? SabanzuriColors.pinkish_grey
                      : SabanzuriColors.navy_blue,
                  fontWeight: FontWeight.w600,
                  fontFamily: "SegoeUI",
                  fontStyle: FontStyle.normal,
                  fontSize: 20),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
