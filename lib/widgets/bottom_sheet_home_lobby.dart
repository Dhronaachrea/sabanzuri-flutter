import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/utils/global_variable.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:velocity_x/velocity_x.dart';

class MyBottomSheetHomeLobby extends StatefulWidget {
  const MyBottomSheetHomeLobby({
    Key? key,
    this.image,
    this.lottoFile,
    this.heading,
    this.imageHeight,
    required this.description,
    this.buttonText,
    this.bottomWidgets,
    this.onTap,
    this.wrapContent = false,
    this.onClose,
    this.title,
    this.height,
    this.loginScreenValue,
    this.onWillPop,
  }) : super(key: key);

  final String? loginScreenValue;
  final AssetImage? image;
  final String? lottoFile;
  final String? heading;
  final List<Widget> description;
  final String? buttonText;
  final List<Widget>? bottomWidgets;
  final VoidCallback? onTap;
  final VoidCallback? onClose;
  final bool? wrapContent;
  final String? title;
  final double? imageHeight;
  final double? height;
  final WillPopCallback? onWillPop;

  @override
  State<MyBottomSheetHomeLobby> createState() => _MyBottomSheetHomeLobbyState();
}

class _MyBottomSheetHomeLobbyState extends State<MyBottomSheetHomeLobby>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    Future.delayed(const Duration(milliseconds: 200), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    double? height = widget.height ?? context.screenHeight - 100;
    return WillPopScope(
      onWillPop: widget.onWillPop,
      child: SizedBox(
        height: widget.wrapContent == true ? null : height,
        child: widget.wrapContent == true
            ? Wrap(
                children: [
                  HeaderText(
                      title: widget.title ?? '',
                      onClose: widget.onClose,
                      cancelCheck: widget.loginScreenValue ?? ''),
                  _buildBody(),
                  widget.buttonText != null ? _buildBottom() : const SizedBox(),
                ],
              )
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      HeaderText(
                        title: widget.title ?? '',
                        onClose: widget.onClose,
                      ),
                      _buildBody(),
                      widget.buttonText != null
                          ? _buildBottom()
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _buildBody() {
    return Wrap(
      children: [
        Column(
          children: [
            widget.image != null
                ? ScaleTransition(
                    scale: _animation,
                    child: SizedBox(
                        height: context.screenHeight / 6,
                        // child: Image(image: widget.image!, fit: BoxFit.cover),
                        child: widget.lottoFile != null
                            ? Lottie.asset(widget.lottoFile!)
                            : Image(image: widget.image!, fit: BoxFit.cover)),
                  )
                : Container(),
            widget.heading != null
                ? Text(
                    widget.heading!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: SabanzuriColors.navy_blue,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ).py12()
                : Container(),
            Column(
              children: widget.description,
            ),
            ...widget.bottomWidgets ?? [],
          ],
        )
      ],
    );
  }

  _buildBottom() {
    return Container(
      decoration: const BoxDecoration(
        color: SabanzuriColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: PrimaryButton(
                text: widget.buttonText,
                enabled: true,
                onPressed: widget.onTap ??
                    () {
                      if (widget.loginScreenValue != 'SplashScreen') {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                      GlobleVariables.isInternetAvailability = true;
                    },
              ),
            ),
          ),
          const DividerLine(),
          const HeightBox(20),
        ],
      ),
    );
  }
}

class DividerLine extends StatelessWidget {
  const DividerLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      decoration: BoxDecoration(
        border: Border.all(
          color: SabanzuriColors.grey_blue,
          width: 1,
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  final String title;
  final VoidCallback? onClose;
  final String? cancelCheck;

  const HeaderText(
      {Key? key, required this.title, this.onClose, this.cancelCheck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: SabanzuriColors.navy_blue,
            fontWeight: FontWeight.w700,
          ),
        ).px20(),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: SabanzuriColors.navy_blue,
          ),
        )
      ],
    );
  }
}

displayModalBottomSheetHomeLobby(context, MyBottomSheetHomeLobby bottomSheet,
    {bool? enableDrag}) async {
  await showModalBottomSheet(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(18),
      ),
    ),
    isScrollControlled: true,
    isDismissible: false,
    context: context,
    enableDrag: enableDrag ?? false,
    builder: (BuildContext context) {
      return bottomSheet;
    },
  ).then((value) => isVisible = true);
}

bool isVisible = false;
