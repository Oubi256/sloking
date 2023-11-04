import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sloking/widgets/general/page_wrapper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final WebViewController webViewController;
  const WebViewPage({super.key, required this.webViewController});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () async => await SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final canGoBack = await widget.webViewController.canGoBack();
        if (canGoBack) widget.webViewController.goBack();
        return false;
      },
      child: PageWrapper(
        child: SafeArea(
            child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 6, spreadRadius: 1, color: Colors.black26)],
                ),
                child: WebViewWidget(controller: widget.webViewController))),
      ),
    );
  }
}
