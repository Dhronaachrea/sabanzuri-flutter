part of 'update_profile_widget.dart';

class UpdateGender extends StatefulWidget {
  const UpdateGender({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateGender> createState() => _UpdateGenderState();
}

class _UpdateGenderState extends State<UpdateGender> {
  bool isMailSelect = true;

  @override
  Widget build(BuildContext context) {
    var isDarkModeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    return BlocBuilder<UpdateGenderBloc, Gender>(
      builder: (context, state) {
        return Container(
          height: 60.0,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: SabanzuriColors.grey_blue),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: SabanzuriColors.grey_blue,
            ),
            child: Row(
              children: [
                Text(
                  context.l10n.gender,
                  style: const TextStyle(
                    color: SabanzuriColors.grey_blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 20.0,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<Gender>(
                      activeColor: ((isMailSelect) ? (isDarkModeOn ? SabanzuriColors.white : SabanzuriColors.cetaceanBlue) : SabanzuriColors.grey_blue),
                      value: Gender.Male,
                      groupValue: context.watch<UpdateGenderBloc>().state,
                      onChanged: (Gender? value) {
                        isMailSelect = true;
                        context
                            .read<UpdateGenderBloc>()
                            .add(UpdateGenderEvent(gender: value!));
                      },
                    ),
                    Text(
                      context.l10n.male, //"Male",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ((isMailSelect) ? (isDarkModeOn ? SabanzuriColors.white : SabanzuriColors.cetaceanBlue) : SabanzuriColors.grey_blue),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<Gender>(
                      activeColor: ((isMailSelect) ? SabanzuriColors.grey_blue : (isDarkModeOn ? SabanzuriColors.white : SabanzuriColors.cetaceanBlue)),
                      value: Gender.Female,
                      groupValue: context.watch<UpdateGenderBloc>().state,
                      onChanged: (Gender? value) {
                        isMailSelect = false;
                        context
                            .read<UpdateGenderBloc>()
                            .add(UpdateGenderEvent(gender: value!));
                      },
                    ),
                    Text(
                      context.l10n.female, //"Female",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ((isMailSelect) ? SabanzuriColors.grey_blue : (isDarkModeOn ? SabanzuriColors.white : SabanzuriColors.cetaceanBlue)) ,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ).pSymmetric(v: 8, h: 12),
          ),
        ).pSymmetric(v: 8);
      },
    );
  }
}
