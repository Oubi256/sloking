part of 'main.dart';

GoRouter _routerConfig = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, __) => SplashPage(),
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
          path: 'delay_bonus',
          builder: (_, __) => DelayBonusPage(),
        ),
        GoRoute(
          path: 'game',
          builder: (_, __) => GamePage(),
        ),
      ],
    ),
  ],
);
