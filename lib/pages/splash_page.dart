import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sloking/bloc/game_progress_bloc/game_progress_bloc.dart';
import 'package:sloking/widgets/general/page_wrapper.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameProgressBloc, GameProgressState>(
      listener: (context, state) {
        Future.delayed(Duration(seconds: 2), () => context.go("/home"));
        //context.go("/home");
      },
      child: PageWrapper(
        children: [
          Positioned(width: 296.w, top: 78.h, bottom: 659.h, child: Image.asset("assets/images/splash/app_name.png")),
          Positioned(top: 173.h, width: 628.w, bottom: -80.h, child: Image.asset("assets/images/splash/king.png")),
        ],
      ),
    );
  }
}
