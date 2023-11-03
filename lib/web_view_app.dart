import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatelessWidget {
  final WebViewController webViewController;
  const WebViewApp({super.key, required this.webViewController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SloKing Fruit Pair Challenge',
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: WebViewWidget(controller: webViewController)),
      ),
    );
  }
}
