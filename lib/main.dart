import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sloking/bloc/game_progress_bloc/game_progress_bloc.dart';
import 'package:sloking/pages/daily_bonus_page.dart';
import 'package:sloking/pages/game_page.dart';
import 'package:sloking/pages/home_page.dart';
import 'package:sloking/pages/rules_page.dart';
import 'package:sloking/pages/splash_page.dart';
import 'package:sloking/generated/l10n.dart';
import 'package:sloking/pages/web_view_page.dart';
import 'package:sloking/repositories/hive_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'router_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await ScreenUtil.ensureScreenSize();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => HiveRepository.init(),
          lazy: true,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GameProgressBloc(hiveRepository: context.read<HiveRepository>())),
        ],
        child: ScreenUtilInit(
          designSize: const Size(412, 832),
          builder: (_, __) => MaterialApp.router(
            title: "SloKing Fruit Pair Challenge",
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            routerConfig: _routerConfig,
            showPerformanceOverlay: false,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
