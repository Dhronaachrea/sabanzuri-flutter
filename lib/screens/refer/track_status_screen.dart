import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/track_status_response.dart';
import 'package:sabanzuri/screens/refer/bloc/refer_bloc.dart';
import 'package:sabanzuri/screens/refer/track_status_widget/track_status_widget.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_type.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:velocity_x/velocity_x.dart';

import 'common/refer_bottom_button.dart';
import 'model/friend_contact_model.dart';

class TrackStatusScreen extends StatefulWidget {
  const TrackStatusScreen({Key? key}) : super(key: key);

  @override
  State<TrackStatusScreen> createState() => _TrackStatusScreenState();
}

class _TrackStatusScreenState extends State<TrackStatusScreen> {
  List<PlrTrackBonusList> plrTrackBonusList = [];
  List<FriendContactModel?> friendContactList = [];

  @override
  void initState() {
    context.read<ReferBloc>().add(TrackStatus(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    return SabanzuriScaffold(
      title: context.l10n.referAFriend,
      showDrawer: false,
      showLogin: false,
      child: BlocConsumer<ReferBloc, ReferState>(
        listener: (context, state) {
          if (state is Invited) {
            var response = state.response;
            Alert.show(
              type: AlertType.success,
              context: context,
              title: context.l10n.success,
              subtitle: response.respMsg!,
              buttonText: context.l10n.ok.toUpperCase(),
              isDarkThemeOn: isDarkThemeOn,
              buttonClick: () {
                Navigator.pop(context);
              },
            );
          } else if (state is InvitationError) {
            var response = state.response;
            Alert.show(
              type: AlertType.error,
              context: context,
              title: context.l10n.error,
              subtitle: response.respMsg!,
              buttonText: context.l10n.ok.toUpperCase(),
              buttonClick: () {
                Navigator.pop(context);
              },
            );
          }
        },
        builder: (context, state) {
          if (state is TrackedStatus) {
            plrTrackBonusList = state.response.plrTrackBonusList!;
            return plrTrackBonusList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: context.screenHeight / 3,
                          child: Lottie.asset('assets/lottie/no_data.json'),
                        ),
                        Text(context.l10n.noOrderToTrack,
                            style: const TextStyle(
                              color: SabanzuriColors.pumpkin_orange,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const HeightBox(20),
                        TrackStatusInformation(isDarkThemeOn: isDarkThemeOn),
                        const HeightBox(20),
                        TrackStatusTable(
                          isDarkThemeOn: isDarkThemeOn,
                          plrTrackBonusList: plrTrackBonusList,
                        ),
                        const HeightBox(20),
                        ReferBottomButton(
                          title: context.l10n.inviteNow.toUpperCase(),
                          isDarkThemeOn: isDarkThemeOn,
                          onTap: () {
                            plrTrackBonusList
                                .map(
                                  (e) => friendContactList.add(
                                    FriendContactModel(
                                      e.userName ?? "NA",
                                      e.emailId ?? "NA",
                                    ),
                                  ),
                                )
                                .toList();
                            context.read<ReferBloc>().add(InviteNow(
                                context: context,
                                contactDetails: friendContactList));
                          },
                        ),
                      ],
                    ),
                  );
          } else if (state is Invited || state is InvitationError) {
            return Container();
          } else {
            return Center(
              child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Lottie.asset('assets/lottie/gradient_loading.json')),
            );
          }
        },
      ),
    );
  }
}
