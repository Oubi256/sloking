import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sloking/bloc/game_progress_bloc/game_progress_bloc.dart';
import 'package:sloking/constants.dart';
import 'package:sloking/generated/l10n.dart';
import 'package:sloking/widgets/gems/gem_counter.dart';
import 'package:sloking/widgets/general/convex_text_button.dart';
import 'package:sloking/widgets/general/page_wrapper.dart';
import 'package:sloking/widgets/health/health_bar.dart';
import 'package:sloking/widgets/wheel/daily_fortune_wheel.dart';

import '../game_levels.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHaveProgress = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameProgressBloc, GameProgressState>(
      listener: (_, currentState) {
        isHaveProgress = currentState.gameLevelProgress.healthCount != 0;
      },
      buildWhen: (prevState, currentState) {
        return prevState.gemCount != currentState.gemCount || isHaveProgress;
      },
      builder: (context, state) {
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
                    ),
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
                  ConvexTextButton(
                    label: S.of(context).menuContinue,
                    onPressed: isHaveProgress
                        ? () {
                            context.read<GameProgressBloc>().add(const ContinueGameProgressEvent());
                            context.go("/home/game");
                          }
                        : null,
                  ),
                  SizedBox(height: Constants.defaultPadding),
                  ConvexTextButton(
                      label: S.of(context).menuNewGame,
                      onPressed: () {
                        context.read<GameProgressBloc>().add(NewGameProgressEvent());
                        context.go("/home/game");
                      }),
                  SizedBox(height: Constants.defaultPadding),
                  ConvexTextButton(label: S.of(context).menuRules, onPressed: () => context.go("/home/rules")),
                ],
              ),
            ),
            Positioned(
              top: 227.r,
              left: 58.w,
              child: GemCounter(
                value: state.gemCount,
              ),
            ),
          ],
        );
      },
    );
  }
}
