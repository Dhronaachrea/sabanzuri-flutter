part of "ticket_widget.dart";

class Forward extends StatefulWidget {
  final VoidCallback onTap;
  final bool isDarkThemeOn;

  const Forward({Key? key, required this.onTap, required this.isDarkThemeOn})
      : super(key: key);

  @override
  State<Forward> createState() => _ForwardState();
}

class _ForwardState extends State<Forward> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: widget.isDarkThemeOn
              ? SabanzuriColors.pumpkin_orange
              : SabanzuriColors.navy,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_forward_ios,
          color: SabanzuriColors.white,
        ),
      ),
    );
  }
}
