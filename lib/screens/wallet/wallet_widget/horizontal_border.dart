part of 'wallet_widget.dart';

class HorizontalBorder extends StatefulWidget {
  const HorizontalBorder({Key? key}) : super(key: key);

  @override
  State<HorizontalBorder> createState() => _HorizontalBorderState();
}

class _HorizontalBorderState extends State<HorizontalBorder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 539.5,
      height: 0,
      decoration: BoxDecoration(
        border: Border.all(color: SabanzuriColors.grey_blue, width: 2),
      ),
    );
  }
}
