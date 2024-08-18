part of 'track_status_widget.dart';

class TrackStatusInformation extends StatelessWidget {
  final bool isDarkThemeOn;

  const TrackStatusInformation({Key? key, required this.isDarkThemeOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(context.l10n.trackStatusInformationText,
        style: TextStyle(
            color: isDarkThemeOn
                ? SabanzuriColors.white
                : SabanzuriColors.brownish_grey_three,
            fontWeight: FontWeight.w400,
            fontFamily: "SegoeUI",
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
        textAlign: TextAlign.center).pOnly(left: 8, right: 8);
  }
}
