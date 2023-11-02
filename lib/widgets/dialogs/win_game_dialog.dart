import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sloking/game_levels.dart';

import '../../bloc/game_progress_bloc/game_progress_bloc.dart';
import '../../constants.dart';
import '../../generated/l10n.dart';
import '../gems/gem_counter.dart';
import '../general/convex_text_button.dart';
import '../health/health_bar.dart';

class WinGameDialog extends StatelessWidget {
  final int gemCount;
  final int healthCount;
  const WinGameDialog({super.key, required this.gemCount, required this.healthCount});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(opacity: 0.5, child: OverflowBox(
            maxWidth: 720.r,
            maxHeight: 720.r,
            child: Image.asset("assets/images/effect_union.png", fit: BoxFit.fill),
          ),),
          Container(
            width: 307.r,
            height: 390.r,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Color(0xFFFFC700), blurRadius: 35)],

                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 3, color: Color(0xFFFFC700)),
                gradient: LinearGradient(colors: [Color(0xFFFF3968), Color(0xFFD20032)], begin: Alignment.topCenter, end: Alignment.bottomCenter,)
            ),
            child: Padding(
              padding:  EdgeInsets.all(Constants.defaultPadding),
              child: Column(
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).dialogWinHeader, style: Constants.headerTextStyle,),
                        GemCounter(value: gemCount,),
                        HealthBar(value: healthCount),
                      ],
                    ),
                  ),
                  SizedBox(height: Constants.defaultPadding,),
                  Flexible(
                    child: Column(
                      children: [
                        ConvexTextButton(
                            label: S.of(context).dialogButtonNextLevel,
                            onPressed: () {
                              context.read<GameProgressBloc>().add( NewGameProgressEvent(nextLevel: true));
                              context.pushReplacement("/home/game");
                            }),
                        SizedBox(height: Constants.defaultPadding,),
                        ConvexTextButton(
                            label: S.of(context).backToMenu,
                            onPressed: () {
                              context.pop(); // close modal
                              context.pop(); // TODO: need fix double pop to home
                              context.pop(); // TODO: need fix double pop to home
                              context.read<GameProgressBloc>().add( NewGameProgressEvent(tryAgain: true));
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
