import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/sabanzuri_text_field.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';
import 'package:velocity_x/velocity_x.dart';


class UpdatePhoneNo extends StatefulWidget {
  final TextEditingController mnController;
  final String? emptyText;

  const UpdatePhoneNo({Key? key, required this.mnController, this.emptyText})
      : super(key: key);

  @override
  State<UpdatePhoneNo> createState() => _UpdatePhoneNoState();
}

class _UpdatePhoneNoState extends State<UpdatePhoneNo> {
  ShakeController mobileNoShakeController  = ShakeController();

  @override
  Widget build(BuildContext context) {
    final bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;

    return ShakeWidget(
      controller: mobileNoShakeController,
      child: SabanzuriTextField(
        autoFocus: true,
        maxLength: 15,
        controller: widget.mnController,
        hintText: context.l10n.mobileNumber,
        inputType: TextInputType.phone,
        prefix: const Icon(
          Icons.phone_android,
          color: SabanzuriColors.grey_blue,
        ),
        validator: (value) {
          var mobileNo = widget.mnController.text.trim();
          if(mobileNo.isEmpty) {
            mobileNoShakeController.shake();
            return context.l10n.enterMobileNumber;
          } else {
            return null;
          }
        },
        isDarkThemeOn: isDarkThemeOn,
      ).pSymmetric(v: 8),
    );
    return SabanzuriTextField(
      controller: widget.mnController,
      isDarkThemeOn: isDarkThemeOn,
      hintText: context.l10n.firstName,
      prefix: const Icon(
        Icons.person,
        color: SabanzuriColors.Manatee,
      ),
    ).pSymmetric(v: 8);
  }
}
