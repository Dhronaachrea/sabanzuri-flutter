part of 'update_profile_widget.dart';

class UpdateCountry extends StatefulWidget {
  final TextEditingController cController;
  final String? emptyText;

  const UpdateCountry({Key? key, required this.cController, this.emptyText})
      : super(key: key);

  @override
  State<UpdateCountry> createState() => _UpdateCountryState();
}

class _UpdateCountryState extends State<UpdateCountry> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    return SabanzuriTextField(
      controller: widget.cController,
      isDarkThemeOn: isDarkThemeOn,
      prefix: const Icon(
        Icons.location_on_outlined,
        color: SabanzuriColors.Manatee,
      ),
    ).pSymmetric(v: 8);
  }
}
