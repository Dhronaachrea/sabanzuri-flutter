import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowToast {
  static showToast(String msg, BuildContext context, {ToastType? type}) {
    return Flushbar(
      messageText: Text(
        msg,
        style: const TextStyle(fontSize: 14.0, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: type?.color ?? Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      maxWidth: context.screenWidth - 40,
      margin: const EdgeInsets.only(bottom: 20),
    ).show(context);
  }
}

enum ToastType {
  SUCCESS,
  ERROR,
  WARNING,
  INFO,
}

extension ToastExtention on ToastType {
  Color get color {
    switch (this) {
      case ToastType.SUCCESS:
        return SabanzuriColors.shamrock_green;
      case ToastType.ERROR:
        return SabanzuriColors.reddish_pink;
      default:
        return SabanzuriColors.reddish_pink;
    }
  }
}
