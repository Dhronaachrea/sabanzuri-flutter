part of 'profile_widget.dart';

class PlaceholderImage extends StatelessWidget {
  final double? radius;
  final double? iconSize;

  const PlaceholderImage({
    Key? key,
    this.radius = 50.0,
    this.iconSize = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Icon(
        Icons.person,
        size: iconSize,
      ),
      backgroundColor: SabanzuriColors.white,
      radius: radius,
    );
  }
}
