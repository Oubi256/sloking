import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  final List<Widget> children;
  final Alignment childrenAlignment;
  final bool enableSafeArea;
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;
  PageWrapper({
    super.key,
    Widget? child,
    List<Widget>? children,
    this.childrenAlignment = Alignment.center,
    this.enableSafeArea = true,
    this.left = true,
    this.top = true,
    this.right = true,
    this.bottom = true,
  })  : child = child ?? const SizedBox(),
        children = children ?? [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bgColor,
      body: Stack(
        alignment: childrenAlignment,
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              "assets/images/backgrounds/mask.png",
              fit: BoxFit.contain,
              repeat: ImageRepeat.repeatX,
              height: 567.h,
              alignment: Alignment.topCenter,
            ),
          ),
          SafeArea(
            left: enableSafeArea && left,
            top: enableSafeArea && top,
            right: enableSafeArea && right,
            bottom: enableSafeArea && bottom,
            child: child,
          ),
          ...children
        ],
      ),
    );
  }
}
