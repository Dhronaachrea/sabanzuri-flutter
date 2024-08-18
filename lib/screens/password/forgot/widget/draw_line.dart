part of 'reset_password_widget.dart';

class DrawLine extends StatelessWidget {
  final bool isDarkThemeOn;

  const DrawLine({Key? key, required this.isDarkThemeOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy,
        ),
      ),
    ).pSymmetric(v: 10);
  }
}
