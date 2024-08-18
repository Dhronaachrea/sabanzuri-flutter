import 'package:flutter/cupertino.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';

enum FileTypeSelect {
  gallery,
  camera,
}

class SelectFileOptions {
  static show(
      {required BuildContext context, required List<FileTypeSelect> types}) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          context.l10n.pickOption,
          style: const TextStyle(
            fontSize: 20,
            color: SabanzuriColors.eerieBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (types.contains(FileTypeSelect.camera))
            CupertinoActionSheetAction(
              child: Text(
                context.l10n.takePhoto,
                style: const TextStyle(
                    fontSize: 20,
                    color: SabanzuriColors.eerieBlack,
                    fontWeight: FontWeight.normal),
              ),
              onPressed: () {
                Navigator.pop(context, FileTypeSelect.camera);
              },
            ),
          if (types.contains(FileTypeSelect.gallery))
            CupertinoActionSheetAction(
              child: Text(
                context.l10n.chooseFromGallery,
                style: const TextStyle(
                    fontSize: 20,
                    color: SabanzuriColors.eerieBlack,
                    fontWeight: FontWeight.normal),
              ),
              onPressed: () {
                Navigator.pop(context, FileTypeSelect.gallery);
              },
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            context.l10n.cancel,
            style: const TextStyle(
                fontSize: 20,
                color: SabanzuriColors.eerieBlack,
                fontWeight: FontWeight.normal),
          ),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
