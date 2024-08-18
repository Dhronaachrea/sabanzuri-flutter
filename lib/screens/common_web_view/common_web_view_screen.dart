import 'package:flutter/material.dart';
import 'package:sabanzuri/widgets/drawer_web_view.dart';

class CommonWebViewScreen extends StatefulWidget {
  final String url;

  const CommonWebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<CommonWebViewScreen> createState() => _CommonWebViewScreenState();
}

class _CommonWebViewScreenState extends State<CommonWebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return DrawerWebView(
      showAppBar: true,
      url: widget.url,
    );
  }
}
