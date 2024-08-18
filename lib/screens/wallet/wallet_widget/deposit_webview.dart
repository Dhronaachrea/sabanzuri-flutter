import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/utils/loading_indicator.dart';
import 'package:sabanzuri/utils/url.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io' show Platform;

class DepositWebView extends StatefulWidget {
  final mapValue;

  const DepositWebView({
    Key? key,
    this.mapValue,
  }) : super(key: key);

  @override
  _DepositWebViewState createState() => _DepositWebViewState();
}

class _DepositWebViewState extends State<DepositWebView> {
  late WebViewController _controller;
  String paymentTypeId = '';
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return SabanzuriScaffold(
      showDrawer: false,
      title: context.l10n.myWallet,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
            ),
            child: WebView(
              navigationDelegate: (action) {
                return NavigationDecision.navigate;
              },
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                loadHtmlFile();
              },
              onPageFinished: (url) {
                _onPageFinished();
              },
              debuggingEnabled: true,
              onProgress: (progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
          progress < 1.0
              ? const Center(child: LoadingIndicator())
              : Container(),
        ],
      ),
    );
  }

  void loadHtmlFile() {
    final url = Uri.dataFromString(
      getHtmlStringValue(),
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
    log("[Deposit Request]: " + getHtmlStringValue());
    _controller.loadUrl(url);
  }

  String getHtmlStringValue() {
    String? amount = widget.mapValue['amount'];
    String? currencyCode = widget.mapValue['currencyCode'];
    String? deviceType = widget.mapValue['deviceType'];
    String? domainName = widget.mapValue['domainName'];
    String? paymentAccId = widget.mapValue['paymentAccId'];
    String? paymentTypeCode = widget.mapValue['paymentTypeCode'];
    String? paymentTypeId = widget.mapValue['paymentTypeId'];
    String? playerId = widget.mapValue['playerId'];
    String? playerToken = widget.mapValue['playerToken'];
    String? subTypeId = widget.mapValue['subTypeId'];
    String? txnType = widget.mapValue['txnType'];
    String? userAgent = widget.mapValue['userAgent'];

    String fileHtmlContents = '''
<html>
  <head>
      <link rel="stylesheet" type="text/css" href="styles.css" class="centerTxt">
  </head>
  <div class="center">
      <div class="loader"></div>
  </div>
  <body onload='document.forms["payment_form"].submit()'>
  <h2>Please wait. It might take a few seconds.<br>
  Please do not refresh the page or click the "Back" or "Close" button.</h2>
  <form action='${Url.DEPOSIT_REQUEST_URL}' method='post' name='payment_form' id='form-submit'>
  <input type='hidden' name='paymentTypeId' value= $paymentTypeId />
  <input type='hidden' name='txnType' value= $txnType />
  <input type='hidden' name='paymentTypeCode' value=$paymentTypeCode />
  <input type='hidden' name='amount' value=$amount />
  <input type='hidden' name='paymentAccId' value=$paymentAccId />
  <input type='hidden' name='domainName' value=$domainName />
  <input type='hidden' name='currencyCode' value=$currencyCode />
  <input type='hidden' name='subTypeId' value=$subTypeId />
  <input type='hidden' name='deviceType' value=$deviceType />
  <input type='hidden' name='playerId' value=$playerId />
  <input type='hidden' name='playerToken' value=$playerToken />
  <input type='hidden' name='userAgent' value=$userAgent />
  <input type='hidden' name='merchantCode' value='infiniti' />
  <!--input type='hidden' name='respSuccess' value='MOBILE_APP' /-->
  <!--input type='hidden' name='respError' value='MOBILE_APP' /-->
  </form>
  </body>
</html>
''';
    return fileHtmlContents;
  }

  _onPageFinished() {
    _controller
        .runJavascriptReturningResult(
          "document.getElementsByName('responseJson')[0].value",
        )
        .then(
          (responseJson) {
            if (responseJson != 'null') {
              if (widget.mapValue != null) {
                final decoded = json.decode(responseJson);
                var responseValue = json.encode(decoded);
                log("[Deposit Response]: $responseValue");
                if (Platform.isAndroid) {
                  Navigator.pop(context, jsonDecode(responseValue));
                } else {
                  Navigator.pop(context, responseValue);
                }
              } else {
                log("[Deposit Response]: $responseJson");
                if (Platform.isAndroid) {
                  Navigator.pop(context, jsonDecode(responseJson));
                } else {
                  Navigator.pop(context, responseJson);
                }
              }
            }
          },
        )
        .catchError((error) => null)
        .onError((error, stackTrace) => null);
  }
}
