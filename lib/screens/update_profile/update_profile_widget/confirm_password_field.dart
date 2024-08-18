import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';
import 'package:velocity_x/velocity_x.dart';


class ConfirmPasswordField extends StatefulWidget {
  final TextEditingController confPassController;
  final TextEditingController passController;
  final String? emptyText;

  const ConfirmPasswordField({Key? key, required this.confPassController, required this.passController, this.emptyText})
      : super(key: key);

  @override
  State<ConfirmPasswordField> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  ShakeController confPassShakeController  = ShakeController();
  bool passVisible = false;

  @override
  Widget build(BuildContext context) {
    final bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;

    return ShakeWidget(
      controller: confPassShakeController,
      child: SabanzuriTextField(
        autoFocus: true,
        maxLength: 15,
        controller: widget.confPassController,
        hintText: context.l10n.confPassword,
        inputType: TextInputType.visiblePassword,
        obscureText: !passVisible,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              passVisible = ! passVisible;
            });
          },
          icon: Icon(
            passVisible ? Icons.visibility : Icons.visibility_off,
            color: SabanzuriColors.grey_blue,
          ),
        ),
        prefix: const Icon(
          Icons.phone_android,
          color: SabanzuriColors.grey_blue,
        ),
        validator: (value) {
          var password = widget.confPassController.text.trim();
          if(password.isEmpty) {
            confPassShakeController.shake();
            return context.l10n.enter_password;
          } else if (widget.passController.text != widget.confPassController.text){
            confPassShakeController.shake();
            return context.l10n.passMatchError;
          }
            else {
            return null;
          }
        },
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
    return SabanzuriTextField(
      controller: widget.confPassController,
      isDarkThemeOn: isDarkThemeOn,
      hintText: context.l10n.firstName,
      prefix: const Icon(
        Icons.person,
        color: SabanzuriColors.Manatee,
      ),
    ).pSymmetric(v: 8);
  }
}
