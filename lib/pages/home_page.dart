import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sloking/constants.dart';
import 'package:sloking/generated/l10n.dart';
import 'package:sloking/widgets/general/convex_text_button.dart';
import 'package:sloking/widgets/general/page_wrapper.dart';
import 'package:sloking/widgets/wheel/daily_fortune_wheel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      children: [
        Positioned(width: 296.w, top: 78.h, bottom: 659.h, child: Image.asset("assets/images/splash/app_name.png")),
        Positioned(
          height: 360.r,
          width: 360.r,
          bottom: 170.h,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.5,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(0, -1.2),
                        child: Transform.scale(
                          scale: 0.8,
                          child: Opacity(
                            opacity: 0.5,
                            child: Image.asset(
                              "assets/images/effect_fake_small_union.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Transform.scale(
                          scale: 0.60,
                          child: DailyFortuneWheel(
                            width: 360.r,
                            height: 360.r,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 34.r,
                  width: 240.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(7)),
                  child: Text(
                    S.of(context).dailyBonus,
                    style: Constants.buttonTextStyle,
                  ),
                ),
              ),
              Positioned(
                bottom: 150.r,
                top: 50.r,
                left: 50.r,
                right: 50.r,
                child: GestureDetector(
                  onTap: () => context.go("/home/daily_bonus"),
                )
              )
            ],
          ),
        ),
        Positioned(
          bottom: 64.h,
          left: 75.w,
          right: 75.w,
          top: 542.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConvexTextButton(label: S.of(context).menuContinue, onPressed: () {}),
              SizedBox(height: Constants.defaultPadding),
              ConvexTextButton(label: S.of(context).menuNewGame, onPressed: () {}),
              SizedBox(height: Constants.defaultPadding),
              ConvexTextButton(label: S.of(context).menuRules, onPressed: () => context.go("/home/rules")),
            ],
          ),
        ),
      ],
    );
  }
}
