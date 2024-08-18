part of 'update_profile_widget.dart';

class ConfirmationSheet {
  static show({
    required User user,
    required bool isDarkThemeOn,
    required BuildContext context,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    String toShowGender = user.gender == "M" ? "Male" : "Female";
    String toShowDob = '';
    bool isUpdateButtonClicked = false;
    if (user.dob != null && user.dob != '') {
      toShowDob = formatDate(
        date: user.dob!,
        inputFormat: Format.apiDateFormat3,
        outputFormat: Format.dateFormat7,
      );
    }
    return BottomSheetTheme.show(
      context: context,
      enableDrag: false,
      sheet: SabanzuriBottomSheet(
        title: context.l10n.confirmation,
        description: [
          ConfirmationText(
            title: context.l10n.firstName,
            subtitle: user.firstName ?? "",
            isDarkThemeOn: isDarkThemeOn,
          ),
          ConfirmationText(
            title: context.l10n.lastName,
            subtitle: user.lastName ?? "",
            isDarkThemeOn: isDarkThemeOn,
          ),
          ConfirmationText(
            title: context.l10n.email,
            subtitle: user.email ?? "",
            isDarkThemeOn: isDarkThemeOn,
          ),
          ConfirmationText(
            title: context.l10n.dob,
            subtitle: toShowDob,
            isDarkThemeOn: isDarkThemeOn,
          ),
          ConfirmationText(
            title: context.l10n.gender,
            subtitle: toShowGender,
            isDarkThemeOn: isDarkThemeOn,
          ),
          ConfirmationText(
            title: context.l10n.address,
            subtitle: user.address ?? "",
            isDarkThemeOn: isDarkThemeOn,
          ),
          const HeightBox(20.0),
        ],
        bottomWidget: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                text: context.l10n.cancel.toUpperCase(),
                type: ButtonType.line_art,
                borderColor:
                    isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
                textColor:
                    isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
                borderRadius: 10.0,
                onPressed: onCancel,
                isDarkThemeOn: isDarkThemeOn,
              ),
            ),
            const WidthBox(10.0),
            Expanded(
              child: PrimaryButton(
                text: context.l10n.update.toUpperCase(),
                fillEnableColor:
                    isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
                fillDisableColor:
                    isDarkThemeOn ? SabanzuriColors.azul : SabanzuriColors.navy,
                textColor: SabanzuriColors.white,
                borderRadius: 10.0,
                onPressed: onConfirm,
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
