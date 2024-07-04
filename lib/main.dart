import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_app/const.dart';
import 'package:mood_app/date_picker_screen.dart';
import 'package:mood_app/home_screen.dart';
import 'package:mood_app/stats_screen.dart';

void main() {
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 500),
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/datepicker',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const DatePickerScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/stats',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 500),
          key: state.pageKey,
          child: const StatsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Nunito',
          colorScheme: ColorScheme.fromSeed(seedColor: mandarin)),
      routerConfig: _router,
    );
  }
}
