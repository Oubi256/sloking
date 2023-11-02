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

class DefeatGameDialog extends StatelessWidget {
  final int gemCount;
  const DefeatGameDialog({super.key, required this.gemCount});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 307.r,
            height: 390.r,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Color(0xFFD30034), blurRadius: 35)],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 3, color: Color(0xFFFFC700)),
                gradient: LinearGradient(colors: [Color(0xFF212121), Color(0xFFD20032)], begin: Alignment.topCenter, end: Alignment.bottomCenter,)
            ),
            child: Padding(
              padding:  EdgeInsets.all(Constants.defaultPadding),
              child: Column(
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          child: Text(S.of(context).dialogDefeatHeader, style: Constants.headerTextStyle,),
                        ),
                        GemCounter(value: gemCount,),
                        HealthBar(value: 0),
                      ],
                    ),
                  ),
                  SizedBox(height: Constants.defaultPadding,),
                  Flexible(
                    child: Column(
                      children: [
                        ConvexTextButton(
                            label: S.of(context).dialogButtonTryAgain,
                            onPressed: () {
                              context.read<GameProgressBloc>().add(const NewGameProgressEvent());
                              context.pushReplacement("/home/game");
                            }),
                        SizedBox(height: Constants.defaultPadding,),
                        ConvexTextButton(
                            label: S.of(context).backToMenu,
                            onPressed: () {
                              print("canPop1: ${GoRouter.of(context).canPop()}");
                              context.pop(); // close modal
                              print("canPop2: ${GoRouter.of(context).canPop()}");
                              context.pop(); // to home
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
