import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sabanzuri/model/ige_game_model.dart';

class IgeGameCard extends StatefulWidget {
  final Game? igeGame;
  final int index;
  final bool isDarkThemeOn;
  final int clickIndex;

  const IgeGameCard({
    Key? key,
    required this.igeGame,
    required this.index,
    required this.isDarkThemeOn,
    required this.clickIndex,
  }) : super(key: key);

  @override
  State<IgeGameCard> createState() => _IgeGameCardState();
}

class _IgeGameCardState extends State<IgeGameCard> {
  var screenSize;
  var img_url = [
    'assets/images/draw_game_img.png',
    'assets/images/instant_game_img.png',
    'assets/images/sports_game_img.png',
    'assets/images/bingo_game_img_new.png',
    'assets/images/live_dealer_game_img.png',
    'assets/images/sports_beting_game_img.png',
    'assets/images/slot_game_img.png',
  ];
  var img_name = [
    'LOTTERY',
    'Instant\nGames',
    'SPORTSPOOL',
    'Bingo',
    'Live\nDealer',
    'Sports\nBetting',
    'Slot\nGames'
  ];

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Card(
      elevation: widget.clickIndex == widget.index ? 5 : 0,
      color: widget.clickIndex == widget.index
          ? widget.isDarkThemeOn
              ? SabanzuriColors.darkish_blue.withOpacity(0.4)
              : SabanzuriColors.white_four
          : widget.isDarkThemeOn
              ? SabanzuriColors.black.withOpacity(0.3)
              : SabanzuriColors.white_two,
      // color: SabanzuriColors.yellow_orange,
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              // imageUrl: widget.igeGame.imagePath!,
              imageUrl: '',
              fit: BoxFit.cover,
              width: screenSize.width * 0.35,
              //TODO need to change placeholder and error widget
              placeholder: (context, url) => Image.asset(
                "assets/images/draw_game_img.png",
              ),
              errorWidget: (context, url, error) =>
                  // Image.asset("assets/background/12_24_background.png"),
                  Image.asset(img_url[widget.index]),
            ),
          ),
          // const HeightBox(5.0),
          Text(
            // widget.igeGame.gameName ?? "",
            img_name[widget.index].toUpperCase() ?? "",
            style: TextStyle(
                color: widget.isDarkThemeOn
                    ? SabanzuriColors.white_two
                    : SabanzuriColors.black,
                // fontWeight: FontWeight.w700,
                fontFamily: "Arial",
                fontStyle: FontStyle.normal,
                fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
          const HeightBox(15.0),
        ],
      ),
    );
  }
}
