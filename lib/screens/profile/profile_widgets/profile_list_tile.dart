part of 'profile_widget.dart';

class ProfileListTile extends StatefulWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;

  const ProfileListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.subtitleColor,
  }) : super(key: key);

  @override
  State<ProfileListTile> createState() => _ProfileListTileState();
}

class _ProfileListTileState extends State<ProfileListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.icon,
        const WidthBox(20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 15,
                  color: widget.titleColor,
                ),
              ),
              Text(
                widget.subtitle,
                style: TextStyle(fontSize: 20, color: widget.subtitleColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
