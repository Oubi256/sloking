import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sloking/constants.dart';
import 'package:sloking/generated/l10n.dart';
import 'package:sloking/widgets/wheel/daily_fortune_wheel.dart';

import '../widgets/general/convex_text_button.dart';
import '../widgets/general/page_wrapper.dart';
import '../widgets/wheel/fortune_wheel_item.dart';

class DailyBonusPage extends StatefulWidget {
  const DailyBonusPage({super.key});

  @override
  State<DailyBonusPage> createState() => _DailyBonusPageState();
}

class _DailyBonusPageState extends State<DailyBonusPage> {
  final GlobalKey<DailyFortuneWheelState> fortuneWheelKey = GlobalKey();
  bool isWheelSpinning = false;

  void _spinWheel() => fortuneWheelKey.currentState?.spin();

  void _onWheelSpinStarted() => setState(() => isWheelSpinning = true);

  void _onWheelSpinFinished() => setState(() => isWheelSpinning = false);

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
      ],
    );
  }
}
