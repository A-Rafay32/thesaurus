import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thesaurus/main.dart';
import 'package:thesaurus/view/main_screen/main_screen.dart';
import 'package:thesaurus/view/settings/history.dart';
import 'package:thesaurus/view/settings/setting_screen.dart';
import 'package:thesaurus/view/settings/starred.dart';
import 'package:thesaurus/view/response_screen.dart';

final GoRouter router = GoRouter(
  //since there is no navigator key parameter in MaterialApp.router
  navigatorKey: MyApp.navigatorKey,
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
      routes: <GoRoute>[
        GoRoute(
          path: 'response',
          builder: (BuildContext context, GoRouterState state) {
            return ResponseScreen();
          },
        ),
        GoRoute(
          path: 'history',
          builder: (BuildContext context, GoRouterState state) {
            return const HistoryScreen();
          },
        ),
        GoRoute(
          path: 'starred',
          builder: (BuildContext context, GoRouterState state) {
            return const StarredScreen();
          },
        ),
        GoRoute(
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen();
          },
        ),
      ],
    ),
  ],
);
