import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloking/generated/l10n.dart';
import 'package:sloking/widgets/wheel/fortune_wheel_item.dart';

class DailyFortuneWheel extends StatefulWidget {
  final void Function()? onAnimationStart;
  final void Function()? onAnimationEnd;
  final double width;
  final double height;

  const DailyFortuneWheel({
    super.key,
    this.onAnimationStart,
    this.onAnimationEnd,
    required this.width,
    required this.height,
  });

  @override
  State<DailyFortuneWheel> createState() => DailyFortuneWheelState();
}

class DailyFortuneWheelState extends State<DailyFortuneWheel> with TickerProviderStateMixin {
  late List<FortuneWheelItem> items;

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
    final int spinResult = Fortune.randomInt(0, items.length);
    setState(() {
      streamController.add(spinResult);
      playWinAnimation = items[spinResult].isWin;
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
    items = [
      FortuneWheelItem.win(gemsReward: 5),
      FortuneWheelItem.defeat(label: S.of(context).fortuneWheelTryAgain),
      FortuneWheelItem.win(gemsReward: 10),
      FortuneWheelItem.defeat(label: S.of(context).fortuneWheelTryAgain),
      FortuneWheelItem.win(gemsReward: 50),
      FortuneWheelItem.defeat(label: S.of(context).fortuneWheelTryAgain),
      FortuneWheelItem.win(gemsReward: 100),
      FortuneWheelItem.defeat(label: S.of(context).fortuneWheelTryAgain),
      FortuneWheelItem.win(gemsReward: 10),
      FortuneWheelItem.defeat(label: S.of(context).fortuneWheelTryAgain),
      FortuneWheelItem.win(gemsReward: 100),
      FortuneWheelItem.defeat(label: S.of(context).fortuneWheelTryAgain),
    ];

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(
        alignment: Alignment.center,
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
          Container(
            padding: EdgeInsets.only(bottom: 8.h),
            height: widget.height,
            width: widget.width,
            child: FortuneWheel(
              animateFirst: false,
              selected: streamController.stream,
              physics: NoPanPhysics(),
              indicators: const [],
              items: items,
              onAnimationStart: _onAnimationStart,
              onAnimationEnd: _onAnimationEnd,
            ),
          ),
          SizedBox(height: widget.height, width: widget.width, child: Image.asset("assets/images/wheel/wheel.png", fit: BoxFit.fill))
        ],
      ),
    );
  }
}
