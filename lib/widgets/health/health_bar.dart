import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthBar extends StatefulWidget {
  final int value;

  const HealthBar({super.key, required this.value});

  @override
  State<HealthBar> createState() => _HealthBarState();
}

class _HealthBarState extends State<HealthBar> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43.r,
      width: 116.r,
      child: AnimatedSwitcher(
        reverseDuration: Duration.zero,
        switchInCurve: Curves.bounceOut,
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns: Tween<double>(begin: 0.02, end: 0).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(begin: Offset(-0.2, 0), end: Offset(0, 0)).animate(animation),
              child: child,
            ),
          );
        },
        child: Row(
          key: ValueKey<int>(widget.value),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(widget.value > 0 ? "assets/images/icons/heart.png" : "assets/images/icons/heart_gray.png", fit: BoxFit.contain, height: 26.r,),
            Image.asset(widget.value > 1 ? "assets/images/icons/heart.png" : "assets/images/icons/heart_gray.png", fit: BoxFit.contain, height: 26.r,),
            Image.asset(widget.value > 2 ? "assets/images/icons/heart.png" : "assets/images/icons/heart_gray.png", fit: BoxFit.contain, height: 26.r,),
          ],
        ),
      )
    );
  }
}
