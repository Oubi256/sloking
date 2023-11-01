import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sloking/constants.dart';
import 'package:sloking/generated/l10n.dart';
import 'package:sloking/widgets/gems/gem_counter.dart';
import 'package:sloking/widgets/wheel/daily_fortune_wheel.dart';

import '../widgets/general/convex_text_button.dart';
import '../widgets/general/page_wrapper.dart';

class DailyBonusPage extends StatefulWidget {
  const DailyBonusPage({super.key});

  @override
  State<DailyBonusPage> createState() => _DailyBonusPageState();
}

class _DailyBonusPageState extends State<DailyBonusPage> with SingleTickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));

  final GlobalKey<DailyFortuneWheelState> fortuneWheelKey = GlobalKey();
  bool isWheelSpinning = false;
  int wheelReward = 0;

  void _spinWheel() => fortuneWheelKey.currentState?.spin();

  void _onWheelSpinStarted() => setState(() => isWheelSpinning = true);

  void _onWheelSpinFinished() => setState(() => isWheelSpinning = false);

  void _onWin(int reward) {
    setState(() {
      wheelReward = reward;
    });
    animationController.forward(from: 0);
    gemCounterKey.currentState?.addGems(wheelReward);
  }

  void _onDefeat() {
    setState(() {
      wheelReward = 0;
    });
    animationController.forward(from: 0);
  }

  final GlobalKey<GemCounterState> gemCounterKey = GlobalKey<GemCounterState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      children: [
        Positioned(
          bottom: 235.h,
          child: DailyFortuneWheel(
            width: 360.r,
            height: 360.r,
            onAnimationStart: _onWheelSpinStarted,
            onAnimationEnd: _onWheelSpinFinished,
            onWin: _onWin,
            onDefeat: _onDefeat,
            key: fortuneWheelKey,
          ),
        ),
        Positioned(
          bottom: 64.h,
          left: 75.w,
          right: 75.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConvexTextButton(label: S.of(context).fortuneWheelSpin, onPressed: isWheelSpinning ? null : _spinWheel),
              SizedBox(height: Constants.defaultPadding),
              ConvexTextButton(label: S.of(context).backToMenu, onPressed: () => context.go("/home")),
            ],
          ),
        ),
        Positioned(bottom: 597.h, child: GemCounter(key: gemCounterKey, initialNumber: 10)), // TODO: init from BloC/Hive
        Positioned(top: 83.h, child: Text(S.of(context).dailyBonus.toUpperCase(), style: Constants.headerTextStyle)),
        Positioned(
          top: 128.h,
          bottom: 640.h,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              return Opacity(
                opacity: animationController.value,
                child: Transform.translate(
                  offset: Offset(0, 0),
                  child: child,
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: wheelReward > 0
                  ? [
                      Text(
                        S.of(context).fortuneWheelWin,
                        style: Constants.headerTextStyle.copyWith(color: Constants.wheelWinTextColor),
                      ),
                      Text(
                        S.of(context).fortuneWheelWinReward(wheelReward),
                        style: Constants.buttonTextStyle.copyWith(color: Constants.wheelWinTextColor),
                      )
                    ]
                  : [
                      Text(
                        S.of(context).fortuneWheelDefeat,
                        style: Constants.buttonTextStyle.copyWith(color: Constants.wheelWinTextColor),
                      ),
                    ],
            ),
          ),
        ),
      ],
    );
  }
}
