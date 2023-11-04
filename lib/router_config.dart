part of 'main.dart';

GoRouter _routerConfig = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, __) => SplashPage(),
    ),
    GoRoute(
      path: '/web_view',
      builder: (_, state) => WebViewPage(webViewController: state.extra as WebViewController),
    ),
    GoRoute(
      path: '/home',
      builder: (_, __) => HomePage(),
      routes: [
        GoRoute(
          path: 'rules',
          builder: (_, __) => RulesPage(),
        ),
        GoRoute(
          path: 'daily_bonus',
          builder: (_, __) => DailyBonusPage(),
        ),
        GoRoute(
          path: 'game',
          builder: (_, __) => GamePage(),
        ),
      ],
    ),
  ],
);
