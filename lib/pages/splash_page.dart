import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sloking/constants.dart';
import 'package:sloking/widgets/general/fake_progress_bar.dart';
import 'package:sloking/widgets/general/page_wrapper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  bool isRedirectAllowed = false;
  final String targetUrl = "https://nebulaquest.site/Fj6Xtv6W";
  late final WebViewController webViewController;

  final Duration randomSplashScreenDelay = Duration(seconds: Random().nextInt(3) + 4);
  late final AnimationController _animationController = AnimationController(vsync: this, duration: Duration(seconds: randomSplashScreenDelay.inSeconds));
  late final Animation<double> _progressBarController = CurveTween(curve: Curves.easeInOut).animate(_animationController);

  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Constants.bgColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (url) {
            if (url.url != null && url.url != targetUrl) {
              isRedirectAllowed = true;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(targetUrl));

    Future.delayed(
      const Duration(milliseconds: 800),
      () {
        _animationController.forward().whenComplete(
              () => Future.delayed(
                Duration(milliseconds: 500),
                () {
                  print("future: ${isRedirectAllowed}");
                  isRedirectAllowed ? context.go("/web_view", extra: webViewController) : context.go("/home");
                },
              ),
            );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      children: [
        Positioned(width: 296.w, top: 78.h, bottom: 659.h, child: Image.asset("assets/images/splash/app_name.png")),
        Positioned(top: 173.h, width: 628.w, bottom: -20.h, child: Image.asset("assets/images/splash/king.png")),
        Positioned(
          bottom: 40.h,
          left: 40.r,
          right: 40.r,
          height: 24.h,
          child: FakeProgressBar(animation: _progressBarController),
        ),
      ],
    );
  }
}
