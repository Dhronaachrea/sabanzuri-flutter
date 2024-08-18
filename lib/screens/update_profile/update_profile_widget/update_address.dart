part of 'update_profile_widget.dart';

class UpdateAddress extends StatefulWidget {
  final TextEditingController addController;
  final String? emptyText;
  final bool isRequiredField;

  const UpdateAddress({Key? key, required this.addController, this.emptyText, this.isRequiredField = true})
      : super(key: key);

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  ShakeController addressShakeController  = ShakeController();

  @override
  Widget build(BuildContext context) {
    final bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;

    return ShakeWidget(
      controller: addressShakeController,
      child: SabanzuriTextField(
        autoFocus: true,
        maxLength: 150,
        minLine: 4,
        maxLine: 4,
        alignLabelWithHint: true,
        controller: widget.addController,
        hintText: context.l10n.address,
        prefix: const Icon(
          Icons.location_on_outlined,
          color: SabanzuriColors.grey_blue,
        ),
        validator: (value) {
          var dob = widget.addController.text.trim();
          if(widget.isRequiredField && dob.isEmpty) {
            addressShakeController.shake();
            return "Enter Address";
          } else {
            return null;
          }
        },
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );

    return SabanzuriTextField(
      controller: widget.addController,
      isDarkThemeOn: isDarkThemeOn,
      alignLabelWithHint: true,
      minLine: 4,
      maxLine: 4,
    ).pSymmetric(v: 8);
  }
}
