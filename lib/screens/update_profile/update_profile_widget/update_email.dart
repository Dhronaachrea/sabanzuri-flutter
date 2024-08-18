part of 'update_profile_widget.dart';

class UpdateEmail extends StatefulWidget {
  final TextEditingController eController;
  final String? emptyText;
  final String? contentType;
  final bool isRequiredField;

  const UpdateEmail(
      {Key? key, required this.eController, this.emptyText, this.contentType, this.isRequiredField = true})
      : super(key: key);

  @override
  State<UpdateEmail> createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  ShakeController emailIdShakeController  = ShakeController();

  @override
  Widget build(BuildContext context) {
    final bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;

    return ShakeWidget(
      controller: emailIdShakeController,
      child: SabanzuriTextField(
        autoFocus: true,
        maxLength: 25,
        controller: widget.eController,
        hintText: context.l10n.email,
        prefix: const Icon(
          Icons.email,
          color: SabanzuriColors.grey_blue,
        ),
        validator: (value) {
          var email = widget.eController.text.trim();
          if(widget.isRequiredField && email.isEmpty) {
            emailIdShakeController.shake();
            return "Enter Email ID";
          } else {
            return null;
          }
        },
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );

    return SabanzuriTextField(
      controller: widget.eController,
      isDarkThemeOn: isDarkThemeOn,
      hintText: context.l10n.email,
      prefix: const Icon(
        Icons.email,
        color: SabanzuriColors.Manatee,
      ),
    ).pSymmetric(v: 8);
  }
}
