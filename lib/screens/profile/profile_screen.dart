import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/profile/profile_bloc.dart';
import 'package:sabanzuri/screens/profile/profile_widgets/profile_widget.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';
import 'package:sabanzuri/utils/date_format.dart';
import 'package:sabanzuri/utils/loading_indicator.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:sabanzuri/widgets/scale_animation.dart';
import 'package:velocity_x/velocity_x.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> with TickerProviderStateMixin {
  final ScaleController _balanceController = ScaleController();

  late final AnimationController  _outerShareBtnAnimationController;
  late final Animation<double>    outerShareBtnAnimation;

  @override
  void initState() {
    super.initState();
    _outerShareBtnAnimationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    outerShareBtnAnimation = Tween<double>(begin: 2, end: 1)
        .animate(_outerShareBtnAnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _outerShareBtnAnimationController.reset();
        }
      });
    _outerShareBtnAnimationController.reset();
    isInternetConnect().then((value) {
      if(value) {
        context.read<ProfileBloc>().add(BalanceRefresh(context: context));
      } else {
        ApiService.showErrorSheet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchCubit, SwitchState>(
      builder: (context, state) {
        bool isDarkThemeOn = state.isDarkThemeOn;
        var usrName = UserInfo.userName.isNotEmpty == true ? UserInfo.userName : UserInfo.mobNumber;
        print("-"*100);
        print("context.watch<AuthBloc>().userName: ${context.watch<AuthBloc>().userName}");
        print("userName: usrName");
        print("-"*100);
        String userName    = context.watch<AuthBloc>().userName?.isNotEmpty == true ? context.watch<AuthBloc>().userName ?? usrName: usrName;
        String mobNumber    = context.watch<AuthBloc>().mobNumber?.isNotEmpty == true ? context.watch<AuthBloc>().mobNumber ?? UserInfo.mobNumber : UserInfo.mobNumber;
        String email        = context.watch<AuthBloc>().email?.isNotEmpty == true ? context.watch<AuthBloc>().email?? UserInfo.email : UserInfo.email;
        String authDob      = context.watch<AuthBloc>().dob?.isNotEmpty == true ? context.watch<AuthBloc>().dob?? UserInfo.dob : UserInfo.dob;
        String authGender   = context.watch<AuthBloc>().gender?.isNotEmpty == true ? context.watch<AuthBloc>().gender?? UserInfo.gender : UserInfo.gender;
        String address      = context.watch<AuthBloc>().address?.isNotEmpty == true ? context.watch<AuthBloc>().address?? UserInfo.address : UserInfo.address;
        String cashBalance  = context.watch<AuthBloc>().cashBalance?.isNotEmpty == true ? context.watch<AuthBloc>().cashBalance ?? UserInfo.cashBalance : UserInfo.cashBalance;
        String dob = "";
        String? profileImage = UserInfo.profileImage;
        if (authDob != "") {
          dob = formatDate(
            date: authDob,
            inputFormat: Format.calendarFormat,
            outputFormat: Format.dateFormat7,
          );
        }
        String gender = authGender == "M"
            ? "Male"
            : authGender != ""
                ? "Female"
                : "";
        return SabanzuriScaffold(
          mResizeToAvoidBottomInset: false,
          showDrawer: false,
          title: context.l10n.profile,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: context.screenHeight / 3,
                    width: context.screenWidth,
                    color: isDarkThemeOn
                        ? SabanzuriColors.spaceCadet
                        : SabanzuriColors.water,
                    child: Column(
                      children: [
                        const HeightBox(20),
                        ProfilePic(profileImage: profileImage),
                        const HeightBox(10),
                        UserName(
                          isDarkThemeOn: isDarkThemeOn,
                          userName: userName,
                        ),
                        const HeightBox(10),
                        /*UserId(
                        isDarkThemeOn: isDarkThemeOn,
                        userId: '1',
                      ),*/
                      ],
                    ),
                  ),
                  const HeightBox(80),
                  Expanded(
                    child: UserProfileDetail(
                      isDarkThemeOn: isDarkThemeOn,
                      userName: userName,
                      mobNumber: mobNumber,
                      email: email,
                      dob: dob,
                      gender: gender,
                      address: address,
                    ),
                  ),
                  const HeightBox(100),
                ],
              ),
              Positioned(
                top: context.screenHeight / 3 - 50,
                left: 40,
                right: 40,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: isDarkThemeOn
                        ? SabanzuriColors.russianViolet
                        : SabanzuriColors.water,
                    border: Border.all(color: SabanzuriColors.denim),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: BlocConsumer<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_balance_wallet,
                                color: isDarkThemeOn
                                    ? SabanzuriColors.white
                                    : SabanzuriColors.russianViolet,
                              ),
                              const WidthBox(10.0),
                              Text(context.l10n.balance,
                                  style: TextStyle(
                                    color: isDarkThemeOn
                                        ? SabanzuriColors.white
                                        : SabanzuriColors.Manatee,
                                    fontSize: 20.0,
                                  )),
                            ],
                          ),
                          const HeightBox(10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ScaleAnimate(
                                controller: _balanceController,
                                child: Text(
                                  UserInfo.currencyDisplayCode + " ${cashBalance}",
                                  style: TextStyle(
                                    color: isDarkThemeOn
                                        ? SabanzuriColors.inchWorm
                                        : SabanzuriColors.russianViolet,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              const WidthBox(30.0),
                              InkWell(
                                onTap: () {
                                  _outerShareBtnAnimationController.forward();
                                  isInternetConnect().then((value) {
                                    if(value) {
                                      context.read<ProfileBloc>().add(BalanceRefresh(context: context));
                                    } else {
                                      ApiService.showErrorSheet();
                                    }
                                  });
                                },
                                child: RotationTransition(
                                  turns:outerShareBtnAnimation,
                                  child: Icon(
                                    Icons.loop,
                                    color: isDarkThemeOn
                                        ? SabanzuriColors.white
                                        : SabanzuriColors.reddish_pink,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    listener: (context, state) {
                      if (state is BalanceRefreshError) {
                        if (state.response.errorCode == AppConstants.sessionExpiryCode) {
                          showSnackMsg(context, "Refresh Balance Error" ?? "", Colors.red,
                              isDarkThemeOn: isDarkThemeOn);
                        } else {
                          Alert.show(
                            title: "Refresh Balance",
                            subtitle: "Error occured while fetching balance",
                            buttonText: context.l10n.ok.toUpperCase(),
                            context: context,
                            isDarkThemeOn: isDarkThemeOn,
                          );
                        }
                      } else if (state is BalanceRefreshed) {
                        _balanceController.scale(from: 0.3);
                      }
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: UpdateButton(
                  isDarkThemeOn: isDarkThemeOn,
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
