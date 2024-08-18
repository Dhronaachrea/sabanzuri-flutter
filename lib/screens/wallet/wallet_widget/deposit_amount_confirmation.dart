part of "wallet_widget.dart";

class DepositAmountConfSheet {
  static show({
    required bool isDarkThemeOn,
    required BuildContext context,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
    required String amount,
    required bool isDeposit,
  }) {
    return BottomSheetTheme.show(
      context: context,
      sheet: SabanzuriBottomSheet(
        title: isDeposit
            ? context.l10n.depositConfirmation
            : context.l10n.withdrawalConfirmation,
        description: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: isDeposit
                  ? context.l10n.areYouSureToDeposit
                  : context.l10n.areYouSureToWithdrawal,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: isDarkThemeOn
                    ? SabanzuriColors.white
                    : SabanzuriColors.navy,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: " " + context.l10n.kes.toUpperCase() + ' $amount ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkThemeOn
                        ? SabanzuriColors.white
                        : SabanzuriColors.navy,
                  ),
                ),
                TextSpan(
                  text: context.l10n.using,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: isDarkThemeOn
                        ? SabanzuriColors.white
                        : SabanzuriColors.navy,
                  ),
                ),
                TextSpan(
                  text: " MPESA ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkThemeOn
                        ? SabanzuriColors.white
                        : SabanzuriColors.navy,
                  ),
                ),
                TextSpan(
                  text: isDeposit
                      ? context.l10n.toYourWallet
                      : context.l10n.fromYourWallet,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: isDarkThemeOn
                        ? SabanzuriColors.white
                        : SabanzuriColors.navy,
                  ),
                ),
              ],
            ),
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
                text: isDeposit
                    ? context.l10n.deposit.toUpperCase()
                    : context.l10n.withdraw.toUpperCase(),
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
