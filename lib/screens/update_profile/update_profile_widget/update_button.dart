part of 'update_profile_widget.dart';

class UpdateButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String btnText;

  const UpdateButton({Key? key, required this.onPressed, required this.btnText}) : super(key: key);

  @override
  State<UpdateButton> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      width: context.screenWidth - 40,
      onPressed: widget.onPressed,
      enabled: true,
      text: widget.btnText.toUpperCase(),
      borderRadius: 67,
    );
  }
}
