import 'dart:math';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloking/constants.dart';

class GemCounter extends StatefulWidget {
  final int initialNumber;
  const GemCounter({super.key, required this.initialNumber});

  @override
  State<GemCounter> createState() => GemCounterState();
}

class GemCounterState extends State<GemCounter> with SingleTickerProviderStateMixin {
  late int _initialNumber;
  late final AnimationController animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

  @override
  void initState() {
    _initialNumber = widget.initialNumber;
    super.initState();
  }

  void addGems(int toAdd) {
    animationController.forward(from: 0);
    setState(() {
      _initialNumber = _initialNumber + toAdd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92.r,
      height: 31.r,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                width: 83.r,
                height: 25.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(left: 22.r),
                child: AnimatedFlipCounter(
                  curve: Curves.easeInOutCubic,
                  duration: Duration(milliseconds: 1400),
                  value: _initialNumber,
                  textStyle: Constants.buttonTextStyle.copyWith(fontSize: 18.r),
                )),
          ),
          AnimatedBuilder(
            animation: animationController,
            child: Image.asset("assets/images/icons/gem.png"),
            builder: (context, child) {
              final sineValue = sin(10 * pi * animationController.value);
              final rotateValue = sin(20 * pi * animationController.value);
              return Transform.rotate(
                angle: rotateValue * pi / 180,
                child: Transform.translate(
                  offset: Offset(sineValue, rotateValue),
                  child: child,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
