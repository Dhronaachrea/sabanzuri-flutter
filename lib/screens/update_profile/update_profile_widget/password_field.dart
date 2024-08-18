import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';
import 'package:velocity_x/velocity_x.dart';


class PasswordField extends StatefulWidget {
  final TextEditingController passController;
  final String? emptyText;
  final bool isRequiredField;

  const PasswordField({Key? key, required this.passController, this.emptyText, this.isRequiredField = true})
      : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  ShakeController passShakeController  = ShakeController();
  bool passVisible = false;

  @override
  Widget build(BuildContext context) {
    final bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;

    return ShakeWidget(
      controller: passShakeController,
      child: SabanzuriTextField(
        autoFocus: true,
        maxLength: 15,
        controller: widget.passController,
        hintText: context.l10n.password,
        inputType: TextInputType.text,
        obscureText: !passVisible,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              passVisible = !passVisible;
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
          var password = widget.passController.text.trim();
          if(widget.isRequiredField && password.isEmpty) {
            passShakeController.shake();
            return context.l10n.enter_password;
          } else {
            return null;
          }
        },
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
  }
}
