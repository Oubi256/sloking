import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloking/widgets/wheel/fortune_wheel_item.dart';

class DailyFortuneWheel extends StatefulWidget {
  final List<FortuneWheelItem> items;
  final void Function()? onAnimationStart;
  final void Function()? onAnimationEnd;
  const DailyFortuneWheel({
    super.key,
    required this.items,
    this.onAnimationStart,
    this.onAnimationEnd,
  });

  @override
  State<DailyFortuneWheel> createState() => DailyFortuneWheelState();
}

class DailyFortuneWheelState extends State<DailyFortuneWheel> with TickerProviderStateMixin {
  bool playWinAnimation = true;
  late final StreamController<int> streamController = StreamController<int>();
  late final AnimationController animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));

  late final Animation<double> unionRotateAnimation = Tween<double>(begin: 1, end: 45).chain(CurveTween(curve: Curves.easeInQuint)).animate(animationController);

  final Tween<double> firstOpacityHalfTween = Tween(begin: 0, end: 1);
  final Tween<double> secondOpacityHalfTween = Tween(begin: 1, end: 1);
  final Tween<double> thirdOpacityHalfTween = Tween(begin: 1, end: 0);

  late final Animation<double> opacityAnimation = TweenSequence<double>([
    TweenSequenceItem(tween: firstOpacityHalfTween, weight: 0.05),
    TweenSequenceItem(tween: secondOpacityHalfTween, weight: 0.4),
    TweenSequenceItem(tween: thirdOpacityHalfTween, weight: 0.3),
  ]).animate(animationController);

  void spin() async {
    final int spinResult = Fortune.randomInt(0, widget.items.length);
    setState(() {
      streamController.add(spinResult);
      playWinAnimation = widget.items[spinResult].isWin;
    });
  }

  void _onAnimationEnd() {
    animationController.forward(from: 0);
    widget.onAnimationEnd?.call();
  }

  void _onAnimationStart() {
    widget.onAnimationStart?.call();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        playWinAnimation
            ? AnimatedBuilder(
                animation: animationController,
                builder: (_, __) {
                  return Opacity(
                    opacity: opacityAnimation.value,
                    child: Stack(
                      children: [
                        Transform.rotate(
                          angle: -pi / unionRotateAnimation.value,
                          child: Opacity(
                            opacity: 0.5,
                            child: OverflowBox(
                              maxWidth: 720.r,
                              maxHeight: 720.r,
                              child: Image.asset("assets/images/effect_union.png", fit: BoxFit.fill),
                            ),
                          ),
                        ),
                        OverflowBox(
                          maxWidth: 550.r,
                          maxHeight: 550.r,
                          child: Image.asset("assets/images/wheel/effect_win_wheel_ellipse.png", fit: BoxFit.fill),
                        ),
                      ],
                    ),
                  );
                },
              )
            : AnimatedBuilder(
                animation: animationController,
                builder: (_, __) {
                  return Opacity(
                    opacity: opacityAnimation.value,
                    child: OverflowBox(
                      maxWidth: 550.r,
                      maxHeight: 550.r,
                      child: Image.asset("assets/images/wheel/effect_defeat_wheel_ellipse.png", fit: BoxFit.fill),
                    ),
                  );
                },
              ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10), // png shadow fix
          child: FortuneWheel(
            animateFirst: false,
            selected: streamController.stream,
            physics: NoPanPhysics(),
            indicators: const [],
            items: widget.items,
            onAnimationStart: _onAnimationStart,
            onAnimationEnd: _onAnimationEnd,
          ),
        ),
        Image.asset("assets/images/wheel/wheel.png", fit: BoxFit.fill)
      ],
    );
  }
}
