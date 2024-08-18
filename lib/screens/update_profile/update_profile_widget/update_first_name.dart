part of 'update_profile_widget.dart';

class UpdateFirstName extends StatefulWidget {
  final TextEditingController fnController;
  final String? emptyText;
  final bool isRequiredField;

  const UpdateFirstName({Key? key, required this.fnController, this.emptyText, this.isRequiredField = true})
      : super(key: key);

  @override
  State<UpdateFirstName> createState() => _UpdateFirstNameState();
}

class _UpdateFirstNameState extends State<UpdateFirstName> {
  ShakeController firstNameShakeController  = ShakeController();

  @override
  Widget build(BuildContext context) {
    final bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;

    return ShakeWidget(
      controller: firstNameShakeController,
      child: SabanzuriTextField(
        autoFocus: true,
        maxLength: 15,
        controller: widget.fnController,
        hintText: context.l10n.firstName,
        isRequiredField: widget.isRequiredField,
        prefix: const Icon(
          Icons.person,
          color: SabanzuriColors.grey_blue,
        ),
        validator: (value) {
          var firstName = widget.fnController.text.trim();
          if(widget.isRequiredField && firstName.isEmpty) {
            firstNameShakeController.shake();
            return "Enter First Name";
          } else {
            return null;
          }
        },
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
    return SabanzuriTextField(
      controller: widget.fnController,
      isDarkThemeOn: isDarkThemeOn,
      hintText: context.l10n.firstName,
      prefix: const Icon(
        Icons.person,
        color: SabanzuriColors.Manatee,
      ),
    ).pSymmetric(v: 8);
  }
}
