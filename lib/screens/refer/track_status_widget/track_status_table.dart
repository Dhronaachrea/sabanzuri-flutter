part of 'track_status_widget.dart';

class TrackStatusTable extends StatelessWidget {
  final bool isDarkThemeOn;
  final List<PlrTrackBonusList> plrTrackBonusList;

  const TrackStatusTable({
    Key? key,
    required this.isDarkThemeOn,
    required this.plrTrackBonusList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns;
    List<DataRow> rows;
    var columnsTextStyle = const TextStyle(
      color: SabanzuriColors.white_two,
      fontWeight: FontWeight.w400,
      fontFamily: "SegoeUI",
      fontStyle: FontStyle.normal,
      fontSize: 18.0,
    );
    var rowTextStyle = TextStyle(
      color: isDarkThemeOn
          ? SabanzuriColors.white_two
          : SabanzuriColors.brownish_grey_three,
      fontWeight: FontWeight.w400,
      fontFamily: "SegoeUI",
      fontStyle: FontStyle.normal,
      fontSize: 18.0,
    );
    columns = [
      DataColumn(
        label: Align(
          alignment: Alignment.center,
          child: Text(context.l10n.referDetails,
              style: columnsTextStyle, textAlign: TextAlign.left),
        ),
      ),
      DataColumn(
        label: Align(
          alignment: Alignment.center,
          child: Text(context.l10n.register,
              style: columnsTextStyle, textAlign: TextAlign.left),
        ),
      ),
      DataColumn(
        label: Align(
          alignment: Alignment.center,
          child: Text(context.l10n.addCash,
              style: columnsTextStyle, textAlign: TextAlign.left),
        ),
      ),
    ];
    rows = plrTrackBonusList
        .map(
          (element) => DataRow(
            cells: [
              DataCell(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(element.userName != null && element.userName != "null"
                          ? element.userName!
                          : element.emailId != null && element.emailId != "null"
                            ? element.emailId!
                            : "NA"
                      ,
                      style: rowTextStyle,
                    ),
                    const HeightBox(5),
                    Opacity(
                      opacity: 0.6,
                      child: Text(
                        formatDate(
                              date: element.referralDate!,
                              inputFormat: Format.apiDateFormat,
                              outputFormat: Format.trackStatusDateFormat,
                            ) ??
                            DateTime.now().toIso8601String(),
                        style: rowTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    element.register!
                        ? "assets/icons/icon_success.png"
                        : "assets/icons/icon_error.png",
                  ).p(20),
                ),
              ),
              DataCell(
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    element.depositor!
                        ? "assets/icons/icon_success.png"
                        : "assets/icons/icon_error.png",
                  ).p(20),
                ),
              ),
            ],
          ),
        )
        .toList();

    return FittedBox(
      child: DataTable(
        dataRowHeight: 80,
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => SabanzuriColors.grey_blue,
        ),
        border: TableBorder.all(color: SabanzuriColors.grey_blue, width: 2),
        columns: columns,
        rows: rows,
      ).px16(),
    );
  }
}
