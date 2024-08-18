import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/model/user/user.dart';
import 'package:sabanzuri/screens/profile/profile_widgets/profile_widget.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/appbar_image.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: context.watch<AuthBloc>().profileImage ?? "",
                  placeholder: (context, url) =>
                      const PlaceholderImage(iconSize: 50, radius: 30),
                  errorWidget: (context, url, error) =>
                      const PlaceholderImage(iconSize: 50, radius: 30),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 30,
                  ),
                ),
                const WidthBox(20),
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  var usrName = UserInfo.userName.isNotEmpty == true ? UserInfo.userName : UserInfo.mobNumber;
                  String? userName    = context.watch<AuthBloc>().userName?.isNotEmpty == true ? context.watch<AuthBloc>().userName : usrName;
                  String? cashBalance = context.read<AuthBloc>().cashBalance ?? UserInfo.cashBalance;
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            UserInfo.isLoggedIn() ? userName ?? "" : "Hi, Guest!",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const HeightBox(4),
                        UserInfo.isLoggedIn()
                            ? RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: const TextStyle(
                                  color: SabanzuriColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                                text: "${UserInfo.getCurrencyCode} ",
                              ),
                              TextSpan(
                                style: const TextStyle(
                                  color: SabanzuriColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
                                ),
                                text: cashBalance ?? "0.0",
                              )
                            ],
                          ),
                        )
                            : Container()
                      ],
                    ),
                  );
                }),
              ],
            ).px8(),
          ),
          const HeightBox(10),
        ],
      ),
    );
  }
}
