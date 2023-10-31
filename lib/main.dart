import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sloking/pages/delay_bonus_page.dart';
import 'package:sloking/pages/game_page.dart';
import 'package:sloking/pages/home_page.dart';
import 'package:sloking/pages/rules_page.dart';
import 'package:sloking/pages/splash_page.dart';

import 'generated/l10n.dart';

part 'router_config.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 832),
      builder: (_, __) => MaterialApp.router(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        routerConfig: _routerConfig,
        showPerformanceOverlay: true,
      ),
    );
  }
}
