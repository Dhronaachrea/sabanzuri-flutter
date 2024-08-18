import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sabanzuri/screens/registration/bloc/registration_bloc.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/scanner_error.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:sabanzuri/widgets/show_toast.dart';
import 'package:velocity_x/velocity_x.dart';

class ScanLoginScreen extends StatefulWidget {
  final VoidCallback? onTap;
  const ScanLoginScreen({Key? key, this.onTap}) : super(key: key);


  @override
  State<ScanLoginScreen> createState() => _ScanLoginScreenState();
}

class _ScanLoginScreenState extends State<ScanLoginScreen> {
  //final ScanController _scanController = ScanController();

  final MobileScannerController _scanController = MobileScannerController(autoStart: true);

  // final MobileScannerController _scanController = MobileScannerController(
  //     autoStart: true,
  //     detectionSpeed: DetectionSpeed.normal,
  //     facing: CameraFacing.back);
 // QRViewController? controller;

  bool flashOn = false;

  bool _pendingWithdrawalLoader = false;
  bool _isApproved = false;
  String mRequestId = "";
  String mDomainId = "";
  String mAliasId = "";
  String mUserId = "";
  String mAmount = "";
  String mTxnId = "";
  String mCurrentData = "";
  bool isLastResultOrRePrintingOrCancelling = false;

  @override
  void initState() {
    super.initState();
    // String codeParam = "6014a374-eccd-4ce8-a4af-9e30c41da003";
    //
    // if (codeParam.length > 10) {
    //   BlocProvider.of<WithdrawalBloc>(context).add(PendingWithdrawalApiData(
    //     context: context,
    //     id: codeParam,
    //   ));
    // }

  }

  @override
  void dispose() {
    // _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {

          if (state is Registered) {
            print("registered");
            Navigator.of(context).pop();
            // Navigator.popUntil(context, ModalRoute.withName(Screen.home_screen));
            // ShowToast.showToast("Logged in Successfully, Play Now !", context, type: ToastType.SUCCESS);
          } else if (state is RegistrationError) {
            setState(() {
              isLastResultOrRePrintingOrCancelling = false;
            });
            ShowToast.showToast(state.registrationResponse?.errorMessage ?? "Something went wrong!", context, type: ToastType.ERROR);
          }
        },
        child: SabanzuriScaffold(
          showDrawer: false,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Text(
                    "Scan QR Code",
                    style: TextStyle(
                        color: SabanzuriColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width > 700
                      ? MediaQuery.of(context).size.width / 4
                      : MediaQuery.of(context).size.width,
                  color: SabanzuriColors.black,
                  child: Stack(
                    children: [

                      MobileScanner(
                        errorBuilder: (context, error, child) {
                          return ScannerError(
                            context: context,
                            error: error,
                          );
                        },
                        controller: _scanController,
                        onDetect: (capture) {
                          _scanController.stop();
                          try {
                            setState(() {
                              List<Barcode> barcodes = capture.barcodes;
                              String? validData = barcodes[0].rawValue;
                              print("scan value -----> $validData");

                              if (validData != null) {
                                Map<String, String> proceedData = {};
                                Uri uri = Uri.dataFromString(validData.toString());

                                /*proceedData["couponCode"]     = uri.queryParameters['couponCode']!;
                                proceedData["currencyCode"]   = uri.queryParameters['currencyCode']!;
                                proceedData["countryCode"]    = uri.queryParameters['countryCode']!;*/

                                proceedData["data"]    = uri.queryParameters['data']!;

                                isInternetConnect().then((value) {
                                  if (value) {
                                    setState(() {
                                      isLastResultOrRePrintingOrCancelling = true;
                                      BlocProvider.of<RegistrationBloc>(context).add(
                                          RegistrationUsingScan(
                                              context: context,
                                              data: Uri.decodeComponent(proceedData["data"] ?? "")
                                          )
                                      );
                                    });

                                  } else {
                                    _scanController.start();
                                    ShowToast.showToast("No Internet Available!", context,type: ToastType.ERROR);
                                  }
                                });


                                // call api
                              }
                            });
                          } catch (e) {
                            _scanController.start();
                            print("Something Went wrong with bar code: $e");
                          }
                        },
                      ),

                      Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              InkWell(
                                onTap: () {
                                  // on and off splash
                                  setState(() {
                                    _scanController.start();
                                    // controller?.toggleFlash();

                                    // _scanController.toggleTorchMode();
                                  });
                                },
                                child: const Icon(
                                  (Icons.refresh_outlined),
                                  color: SabanzuriColors.reddish_pink,
                                  size: 30,
                                ).p(10),
                              ),
                              InkWell(
                                onTap: () {
                                  // on and off splash
                                  setState(() {
                                    flashOn = !flashOn;
                                    _scanController.toggleTorch();
                                    // controller?.toggleFlash();

                                    // _scanController.toggleTorchMode();
                                  });
                                },
                                child: Icon(
                                  (flashOn ? Icons.flash_on : Icons.flash_off),
                                  color: SabanzuriColors.reddish_pink,
                                  size: 30,
                                ).p(10),
                              ),
                            ],
                          )
                      ),
                      _pendingWithdrawalLoader
                          ? const Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator())
                          : Container(),
                      Visibility(
                        visible: isLastResultOrRePrintingOrCancelling,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: SabanzuriColors.black.withOpacity(0.7),
                          child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: Lottie.asset('assets/lottie/gradient_loading.json'))),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
  }


}
