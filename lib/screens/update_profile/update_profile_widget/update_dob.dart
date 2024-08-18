part of 'update_profile_widget.dart';

class UpdateDob extends StatefulWidget {
  final TextEditingController dobController;
  final String? emptyText;
  final bool isRequiredField;

  const UpdateDob(
      {Key? key, required this.dobController, required this.emptyText, this.isRequiredField = true})
      : super(key: key);

  @override
  State<UpdateDob> createState() => _UpdateDobState();
}

class _UpdateDobState extends State<UpdateDob> {
  ShakeController dobShakeController  = ShakeController();

  @override
  Widget build(BuildContext context) {
    final bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;

    return ShakeWidget(
      controller: dobShakeController,
      child: SabanzuriTextField(
        autoFocus: true,
        maxLength: 15,
        controller: widget.dobController,
        hintText: context.l10n.dateOfBirth,
        isCalendar: true,
        prefix: const Icon(
          Icons.calendar_month,
          color: SabanzuriColors.grey_blue,
        ),
        validator: (value) {
          var dob = widget.dobController.text.trim();
          if(widget.isRequiredField && dob.isEmpty) {
            dobShakeController.shake();
            return "Select your's Date of Birth";
          } else {
            return null;
          }
        },
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );

    return SabanzuriTextField(
      isDarkThemeOn: isDarkThemeOn,
      controller: widget.dobController,
      isCalendar: true,
      hintText: context.l10n.dateOfBirth,
      prefix: Image.asset(
        "assets/icons/icon_calendar.png",
        color: SabanzuriColors.Manatee,
      ),
    ).pSymmetric(v: 8);
  }
}
