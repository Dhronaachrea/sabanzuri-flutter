import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/drawer/drawer_widgets/theme.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../main.dart';
import 'drawer_widgets/app_version/sabanzuri_version_cubit.dart';
import 'drawer_widgets/change_password_logout.dart';
import 'drawer_widgets/header.dart';
import 'drawer_widgets/more_links.dart';
import 'drawer_widgets/my_accounts.dart';
import 'drawer_widgets/quick_links.dart';
import 'drawer_widgets/app_version/sabanzuri_version.dart';

class SabanzuriDrawer extends StatefulWidget {
  const SabanzuriDrawer({Key? key}) : super(key: key);

  @override
  State<SabanzuriDrawer> createState() => _SabanzuriDrawerState();
}

class _SabanzuriDrawerState extends State<SabanzuriDrawer> {
  final double flagSize = 35;
  int selectedFlag = 0;
  late AudioPlayer audioPlayer;


  @override
  void initState() {

    audioPlayer = AudioPlayer();

    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      if (s == PlayerState.completed) {
        // Playback completed
        print(" sound completed");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isLandscape = (orientation == Orientation.landscape);

    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: SizedBox(
        width: context.screenWidth * (isLandscape ? 0.45 : 0.9),
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BlocBuilder<SwitchCubit, SwitchState>(
                    builder: (context, state) {
                      return Image.asset(
                        "assets/icons/mask_group_3.png",
                        width: flagSize,
                        height: flagSize,
                        color: state.isDarkThemeOn
                            ? SabanzuriColors.white
                            : SabanzuriColors.navy_blue,
                      );
                    },
                  ),
                  const WidthBox(10),
                  InkWell(
                    onTap: () async{


                      // Play sound from a local asset
                       /* await audioPlayer.play(
                            AssetSource("notification.mp3"),
                        );
                        await audioPlayer.setPlaybackRate(2);*/
                      SabanzuriApp.of(context).setLocale(
                        const Locale('en', 'UK'),
                      );
                      setState(() {
                        selectedFlag = 0;
                      });
                    },
                    child: Image.asset(
                      "assets/icons/uk_flag.png",
                      width: selectedFlag == 0 ? flagSize + 10 : flagSize,
                      height: selectedFlag == 0 ? flagSize + 10 : flagSize,
                    ),
                  ),
                  const WidthBox(10),
                  /*InkWell(
                    onTap: () {
                      SabanzuriApp.of(context).setLocale(
                        const Locale('es', 'SP'),
                      );
                      setState(() {
                        selectedFlag = 1;
                      });
                    },
                    child: Image.asset(
                      "assets/icons/kenya_flag.png",
                      width: selectedFlag == 1 ? flagSize + 10 : flagSize,
                      height: selectedFlag == 1 ? flagSize + 10 : flagSize,
                    ),
                  ),
                  const WidthBox(10),
                  InkWell(
                    onTap: () {
                      SabanzuriApp.of(context).setLocale(
                        const Locale('fr', 'FR'),
                      );
                      setState(() {
                        selectedFlag = 2;
                      });
                    },
                    child: Image.asset(
                      "assets/icons/french_flag.png",
                      width: selectedFlag == 2 ? flagSize + 10 : flagSize,
                      height: selectedFlag == 2 ? flagSize + 10 : flagSize,
                    ),
                  ),*/
                  const Spacer(),
                  const ThemeOption(),
                ],
              ),
              const Header(),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeightBox(10),
                      MyAccount(),
                      HeightBox(20),
                      QuickLinks(),
                      HeightBox(20),
                      // HowToPlay(),
                      // HeightBox(20),
                      //ThemeOption(),
                      HeightBox(20),
                      MoreLinks(),
                      ChangePasswordLogout(),
                    ],
                  ),
                ),
              ),
              BlocProvider<SabanzuriVersionCubit>(
                create: (BuildContext context) => SabanzuriVersionCubit(),
                child: const SabanzuriVersion(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
