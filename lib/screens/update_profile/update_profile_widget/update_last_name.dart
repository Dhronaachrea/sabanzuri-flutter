part of 'update_profile_widget.dart';

class UpdateLastName extends StatefulWidget {
  final TextEditingController lnController;
  final String? emptyText;
  final bool isRequiredField;

  const UpdateLastName({
    Key? key,
    required this.lnController,
    this.emptyText,
    this.isRequiredField = true
  }) : super(key: key);

  @override
  State<UpdateLastName> createState() => _UpdateLastNameState();
}

class _UpdateLastNameState extends State<UpdateLastName> {
  ShakeController lastNameShakeController  = ShakeController();

  @override
  Widget build(BuildContext context) {
    final bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;

    return ShakeWidget(
      controller: lastNameShakeController,
      child: SabanzuriTextField(
        autoFocus: true,
        maxLength: 15,
        controller: widget.lnController,
        hintText: context.l10n.lastName,
        prefix: const Icon(
          Icons.person,
          color: SabanzuriColors.grey_blue,
        ),
        validator: (value) {
          var lastName = widget.lnController.text.trim();
          if(widget.isRequiredField && lastName.isEmpty) {
            lastNameShakeController.shake();
            return "Enter Last Name";
          } else {
            return null;
          }
        },
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );

    return SabanzuriTextField(
      controller: widget.lnController,
      isDarkThemeOn: isDarkThemeOn,
      hintText: context.l10n.lastName,
      prefix: const Icon(
        Icons.person,
        color: SabanzuriColors.Manatee,
      ),
    ).pSymmetric(v: 8);
  }
}
