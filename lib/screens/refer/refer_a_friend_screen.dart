import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/refer/bloc/refer_bloc.dart';
import 'package:sabanzuri/screens/refer/common/refer_bottom_button.dart';
import 'package:sabanzuri/screens/refer/refer_widget/refer_widget.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_type.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';
import 'package:sabanzuri/widgets/show_toast.dart';
import 'package:velocity_x/velocity_x.dart';

import 'model/friend_contact_model.dart';

class ReferAFriend extends StatefulWidget {
  const ReferAFriend({Key? key}) : super(key: key);

  @override
  State<ReferAFriend> createState() => _ReferAFriendState();
}

class _ReferAFriendState extends State<ReferAFriend> {
  final ShakeController nameShakeController = ShakeController();
  final ShakeController emailShakeController = ShakeController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  List<FriendContactModel?> friendContactList = [];
  bool isInviting = false;

  @override
  void dispose() {
    nameShakeController.dispose();
    emailShakeController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    return SabanzuriScaffold(
      title: context.l10n.referAFriend,
      showDrawer: false,
      showLogin: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HeightBox(20),
            InformationText(
              isDarkThemeOn: isDarkThemeOn,
            ),
            const HeightBox(20),
            ReferralCode(
              isDarkThemeOn: isDarkThemeOn,
            ),
            const HeightBox(20),
            FittedBox(
              child: ReferralLink(
                isDarkThemeOn: isDarkThemeOn,
              ),
            ),
            const HeightBox(20),
            OrWidget(
              isDarkThemeOn: isDarkThemeOn,
            ),
            const HeightBox(20),
            ChooseHowToInvite(
              isDarkThemeOn: isDarkThemeOn,
            ),
            const HeightBox(20),
            SharingOption(
              isDarkThemeOn: isDarkThemeOn,
            ),
            const HeightBox(20),
            OrWidget(
              isDarkThemeOn: isDarkThemeOn,
            ),
            const HeightBox(20),
            InviteManually(
              isDarkThemeOn: isDarkThemeOn,
            ),
            const HeightBox(20),
            friendContactList.isEmpty
                ? const SizedBox()
                : ContactList(
                    friendContactList: friendContactList,
                    isDarkThemeOn: isDarkThemeOn,
                    onRemove: (contactDetails) {
                      setState(() {
                        friendContactList.remove(contactDetails);
                      });
                    },
                  ),
            InviteManuallyDetails(
              nameShakeController: nameShakeController,
              emailShakeController: emailShakeController,
              nameController: nameController,
              emailController: emailController,
              isDarkThemeOn: isDarkThemeOn,
            ),
            const HeightBox(20),
            BlocListener<ReferBloc, ReferState>(
              listener: (context, state) {
                if (state is Invited) {
                  var response = state.response;
                  setState(() {
                    isInviting = false;
                    friendContactList.clear();
                    nameController.clear();
                    emailController.clear();
                  });
                  Alert.show(
                    type: AlertType.success,
                    context: context,
                    title: context.l10n.success,
                    subtitle: response.respMsg!,
                    buttonText: context.l10n.ok.toUpperCase(),
                    isDarkThemeOn: isDarkThemeOn,
                    buttonClick: () {
                      print("-------------------> track_status_screen");
                      Navigator.pushNamed(context, Screen.track_status_screen);
                    },
                  );
                } else if (state is InvitationError) {
                  var response = state.response;
                  setState(() {
                    isInviting = false;
                  });
                  Alert.show(
                    type: AlertType.error,
                    context: context,
                    title: context.l10n.error,
                    subtitle: response.respMsg!,
                    buttonText: context.l10n.ok.toUpperCase(),
                    buttonClick: () {
                      print("-----------------error--> track_status_screen");

                    },
                  );
                } else if(state is Inviting) {
                  print("-------------------------------------------------------------------------------------->>");
                    setState(() {
                      isInviting = true;
                    });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    borderRadius: 80,
                    type: isDarkThemeOn ? null : ButtonType.line_art,
                    text: context.l10n.addMore,
                    onPressed: () {
                      var emailId = emailController.text;
                      var name = nameController.text;
                      log("email ID: $emailId");
                      log("name : $name");
                      if (!verifyEmail(emailId)) {
                        ShowToast.showToast(context.l10n.validEmailText, context,
                            type: ToastType.ERROR);
                        emailShakeController.shake();
                      } else if (name.isEmpty) {
                        ShowToast.showToast(context.l10n.validNameText, context,
                            type: ToastType.ERROR);
                        nameShakeController.shake();
                      } else {
                        nameController.clear();
                        emailController.clear();
                        setState(() {
                          friendContactList.add(FriendContactModel(name, emailId));
                        });
                      }
                    },
                    isDarkThemeOn: isDarkThemeOn,
                  ).px16(),

                  isInviting
                      ?
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Lottie.asset('assets/lottie/gradient_loading.json'))
                      :
                        PrimaryButton(
                    borderRadius: 80,
                    fillDisableColor:
                    isDarkThemeOn ? SabanzuriColors.cherry : SabanzuriColors.azul,
                    text: context.l10n.inviteNow,
                    onPressed: () {
                      var emailId = emailController.text;
                      var name = nameController.text;
                      log("email ID: $emailId");
                      log("name : $name");
                      if (friendContactList.isEmpty && !verifyEmail(emailId)) {
                        ShowToast.showToast(context.l10n.validEmailText, context,
                            type: ToastType.ERROR);
                        emailShakeController.shake();
                      } else if (friendContactList.isEmpty && name.isEmpty) {
                        ShowToast.showToast(context.l10n.validNameText, context,
                            type: ToastType.ERROR);
                        nameShakeController.shake();
                      } else {
                        if(verifyEmail(emailId) && name.isNotEmpty){
                          friendContactList.add(FriendContactModel(name, emailId));
                        }
                        isInternetConnect().then((value) {
                          if(value) {
                            context.read<ReferBloc>().add(InviteNow(
                                context: context, contactDetails: friendContactList));
                          } else {
                            ApiService.showErrorSheet();
                          }
                        });

                      }
                    },
                    isDarkThemeOn: isDarkThemeOn,
                  ).px16(),
                ],
              )
            ),
            const HeightBox(20),
            ReferInformationText(
              isDarkThemeOn: isDarkThemeOn,
            ),
            const HeightBox(20),
            ReferBottomButton(
              title: context.l10n.trackStatus.toUpperCase(),
              isDarkThemeOn: isDarkThemeOn,
              onTap: () {
                Navigator.pushNamed(context, Screen.track_status_screen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
