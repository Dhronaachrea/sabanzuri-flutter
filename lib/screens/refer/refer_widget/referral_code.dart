part of "refer_widget.dart";

class ReferralCode extends StatefulWidget {
  final bool isDarkThemeOn;

  ReferralCode({Key? key, required this.isDarkThemeOn}) : super(key: key);

  @override
  State<ReferralCode> createState() => _ReferralCodeState();
}

class _ReferralCodeState extends State<ReferralCode> with TickerProviderStateMixin {
  String referralCode   = '';

  late String tapToCopyText = "Tap to copy";

  late final Animation<double>    animationReferCodeText;

  late final Animation<double>    animationFadeText;

  late final AnimationController  _lottieController;

  late final AnimationController  _referCodeTextAnimatedController;

  late final AnimationController  _fadeAnimatedController;

  @override void initState() {
    super.initState();

    _lottieController = AnimationController(vsync: this,duration: const Duration(seconds: 1),)..repeat(reverse: false)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _lottieController.reset();
      }
    });
    _lottieController.reset();

    _referCodeTextAnimatedController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    animationReferCodeText      = Tween<double>(begin: 1.2, end: 1.5).animate(CurvedAnimation(parent: _referCodeTextAnimatedController, curve: Curves.easeInOut,))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _referCodeTextAnimatedController.reverse();
        }
      })
      ..addStatusListener((state) => print('$state'));
    _referCodeTextAnimatedController.reset();

    _fadeAnimatedController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    animationFadeText = Tween<double>(begin: 1.0, end: 0.2).animate(_fadeAnimatedController);
    _fadeAnimatedController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        _fadeAnimatedController.reverse();
      }
    });
    _fadeAnimatedController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [6, 7],
      color: widget.isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy_blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Copy referral code.
          InkWell(
            onTap: () {
              _referCodeTextAnimatedController.forward();
              _fadeAnimatedController.forward();
              _lottieController.forward();
              setState(() {
                tapToCopyText = "Copied";
                referralCode = UserInfo.getReferCode;
              });
              Clipboard.setData(ClipboardData(
                  text: referralCode));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Image.asset('assets/images/confetti.png'),
                Lottie.asset("assets/lottie/confetti.json",
                    width:125, height: 100, controller: _lottieController, repeat: false),
                Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: animationReferCodeText,
                      child: Text(
                        UserInfo.getReferCode,
                        style: TextStyle(
                          color: widget.isDarkThemeOn
                              ? SabanzuriColors.white
                              : SabanzuriColors.navy_blue,
                          fontWeight: FontWeight.w600,
                          fontFamily: "SegoeUI",
                          fontStyle: FontStyle.normal,
                          fontSize: 30.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const HeightBox(5),
                    FadeTransition(
                      opacity: animationFadeText,
                      child: Text(
                        tapToCopyText,
                        style: const TextStyle(
                          color: SabanzuriColors.yellow_orange,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).px16();
  }
}
