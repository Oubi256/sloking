import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloking/constants.dart';
import 'package:sloking/generated/l10n.dart';
import 'package:sloking/widgets/general/convex_text_button.dart';
import 'package:sloking/widgets/general/page_wrapper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      children: [
        Positioned(width: 296.w, top: 78.h, bottom: 659.h, child: Image.asset("assets/images/splash/app_name.png")),
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
              ConvexTextButton(label: S.of(context).menuRules, onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
