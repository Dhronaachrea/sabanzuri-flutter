part of 'profile_widget.dart';

class ProfilePic extends StatefulWidget {
  final String? profileImage;

  const ProfilePic({Key? key, this.profileImage}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  XFile? xFile;
  File? userImage;
  String? profileImage;

  @override
  Widget build(BuildContext context) {
    profileImage = widget.profileImage;
    return InkWell(
      // onTap: () => _showFileOptions(context),
      onTap: () => {},
      child: userImage == null
          ? CachedNetworkImage(
              imageUrl: profileImage ?? "",
              placeholder: (context, url) => const PlaceholderImage(),
              errorWidget: (context, url, error) => const PlaceholderImage(),
              imageBuilder: (context, image) => CircleAvatar(
                backgroundImage: image,
                radius: 50,
              ),
            )
          : CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: FileImage(userImage!),
              radius: 50.0,
            ),
    );
  }

  _showFileOptions(BuildContext context) async {
    FileTypeSelect? result = await SelectFileOptions.show(
      context: context,
      types: [
        FileTypeSelect.camera,
        FileTypeSelect.gallery,
      ],
    );
    ImageSource source;

    if (result == FileTypeSelect.camera) {
      source = ImageSource.camera;
    } else if (result == FileTypeSelect.gallery) {
      source = ImageSource.gallery;
    } else {
      return;
    }
    _pickProfileImage(source);
  }

  _pickProfileImage(source) async {
    try {
      xFile = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
      );
    } catch (e) {
      log("[PROFILE IMAGE] $e");
    }

    if (xFile != null) {
      context.read<ProfileBloc>().add(
            UpdateAvatar(context: context, xFile: xFile!),
          );
    }
  }
}
