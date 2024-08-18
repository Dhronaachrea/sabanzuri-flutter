part of "inbox_widget.dart";

class ConfirmationSheet {
  static show({
    required PlrInboxList inboxList,
    required bool isDarkThemeOn,
    required BuildContext context,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    return BottomSheetTheme.show(
      context: context,
      sheet: SabanzuriBottomSheet(
        title: inboxList.subject,
        description: [
          Text(
            inboxList.contentId ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
                color: isDarkThemeOn
                    ? SabanzuriColors.white
                    : SabanzuriColors.navy),
          ),
        ],
        bottomWidget: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                text: context.l10n.delete.toUpperCase(),
                type: ButtonType.line_art,
                borderColor:
                    isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
                textColor:
                    isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
                borderRadius: 10.0,
                onPressed: onConfirm,
                isDarkThemeOn: isDarkThemeOn,
              ),
            ),
            const WidthBox(10.0),
            Expanded(
              child: PrimaryButton(
                text: context.l10n.close.toUpperCase(),
                fillEnableColor:
                    isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
                fillDisableColor:
                    isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
                textColor: SabanzuriColors.white,
                borderRadius: 10.0,
                onPressed: onCancel,
              ),
            ),
          ],
        ).px24(),
        isDarkThemeOn: isDarkThemeOn,
      ),
      isDarkThemeOn: isDarkThemeOn,
    );
  }
}
