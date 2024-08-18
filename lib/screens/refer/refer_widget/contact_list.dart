part of 'refer_widget.dart';

class ContactList extends StatelessWidget {
  final List<FriendContactModel?> friendContactList;
  final bool isDarkThemeOn;
  final Function(FriendContactModel friendContactDetail) onRemove;

  const ContactList({
    Key? key,
    required this.friendContactList,
    required this.isDarkThemeOn,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: DataTable(
        showBottomBorder: true,
        border: TableBorder.all(color: SabanzuriColors.grey_blue, width: 1),
        columns: [
          DataColumn(
            label: Align(
              alignment: Alignment.center,
              child: Text(
                context.l10n.name,
                style: TextStyle(
                  color: isDarkThemeOn
                      ? SabanzuriColors.white_two
                      : SabanzuriColors.brownish_grey_three,
                  fontWeight: FontWeight.w400,
                  fontFamily: "SegoeUI",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          DataColumn(
            label: Align(
              alignment: Alignment.center,
              child: Text(
                context.l10n.email,
                style: TextStyle(
                  color: isDarkThemeOn
                      ? SabanzuriColors.white_two
                      : SabanzuriColors.brownish_grey_three,
                  fontWeight: FontWeight.w400,
                  fontFamily: "SegoeUI",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          DataColumn(
            label: Align(
              alignment: Alignment.center,
              child: Text(
                context.l10n.remove,
                style: TextStyle(
                  color: isDarkThemeOn
                      ? SabanzuriColors.white_two
                      : SabanzuriColors.brownish_grey_three,
                  fontWeight: FontWeight.w400,
                  fontFamily: "SegoeUI",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        rows: friendContactList
            .map(
              (contactDetails) => DataRow(cells: [
                DataCell(
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      contactDetails!.name,
                      style: TextStyle(
                        color: isDarkThemeOn
                            ? SabanzuriColors.white_two
                            : SabanzuriColors.brownish_grey_three,
                        fontWeight: FontWeight.w400,
                        fontFamily: "SegoeUI",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataCell(
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      contactDetails.emailId,
                      style: TextStyle(
                        color: isDarkThemeOn
                            ? SabanzuriColors.white_two
                            : SabanzuriColors.brownish_grey_three,
                        fontWeight: FontWeight.w400,
                        fontFamily: "SegoeUI",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                DataCell(
                  InkWell(
                    onTap: () {
                      onRemove(contactDetails);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/icons/icon_error.png",
                      ).p(8),
                    ),
                  ),
                ),
              ]),
            )
            .toList(),
      ).p(16),
    );
    // return ListView.builder(
    //     itemCount: friendContactList.length,
    //     physics: const NeverScrollableScrollPhysics(),
    //     shrinkWrap: true,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Expanded(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               context.l10n.name + " : " + friendContactList[index]!.name,
    //               style: TextStyle(
    //                 color: isDarkThemeOn
    //                     ? SabanzuriColors.white_two
    //                     : SabanzuriColors.brownish_grey_three,
    //                 fontWeight: FontWeight.w400,
    //                 fontFamily: "SegoeUI",
    //                 fontStyle: FontStyle.normal,
    //                 fontSize: 18.0,
    //               ),
    //               textAlign: TextAlign.center,
    //             ).px16(),
    //             const HeightBox(8),
    //             Text(
    //               context.l10n.email +
    //                   " : " +
    //                   friendContactList[index]!.emailId,
    //               style: TextStyle(
    //                 color: isDarkThemeOn
    //                     ? SabanzuriColors.white_two
    //                     : SabanzuriColors.brownish_grey_three,
    //                 fontWeight: FontWeight.w400,
    //                 fontFamily: "SegoeUI",
    //                 fontStyle: FontStyle.normal,
    //                 fontSize: 18.0,
    //               ),
    //               textAlign: TextAlign.center,
    //             ).px16(),
    //           ],
    //         ),
    //       );
    //     });
  }
}
