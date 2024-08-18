part of 'refer_widget.dart';

class InviteManuallyDetails extends StatelessWidget {
  final bool isDarkThemeOn;
  final ShakeController nameShakeController;
  final ShakeController emailShakeController;
  final TextEditingController nameController;
  final TextEditingController emailController;

  const InviteManuallyDetails({
    Key? key,
    required this.isDarkThemeOn,
    required this.nameShakeController,
    required this.emailShakeController,
    required this.nameController,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: SabanzuriColors.denim, width: 2),
        color:
            isDarkThemeOn ? SabanzuriColors.dark_indigo : SabanzuriColors.white,
      ),
      child: Column(
        children: [
          const HeightBox(10),
          ShakeWidget(
            controller: nameShakeController,
            child: SabanzuriTextField(
              maxLength: 30,
              controller: nameController,
              prefix: const Icon(
                Icons.person,
                color: SabanzuriColors.grey_blue,
              ),
              hintText: context.l10n.nameOfFriend,
              isDarkThemeOn: isDarkThemeOn,
            ).px16(),
          ),
          const HeightBox(10),
          ShakeWidget(
            controller: emailShakeController,
            child: SabanzuriTextField(
              maxLength: 30,
              controller: emailController,
              prefix: const Icon(
                Icons.email_outlined,
                color: SabanzuriColors.grey_blue,
              ),
              hintText: context.l10n.emailOfFriend,
              isDarkThemeOn: isDarkThemeOn,
            ).px16(),
          ),
          const HeightBox(10),
        ],
      ),
    ).px16();
  }
}
