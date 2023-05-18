import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:thesaurus/constants.dart";
import "package:thesaurus/view/main_screen/main_screen.dart";
import "package:thesaurus/model/model.dart";
import "package:thesaurus/view/settings/history.dart";
import "package:thesaurus/view/settings/setting_screen.dart";
import "package:thesaurus/view/settings/starred.dart";
import "package:thesaurus/view_model/response_screen.dart";
import "dart:async";
import "package:thesaurus/view_model/notifications.dart";

import "model/shared_prefs.dart";

Future<void> main() async {
  // Always initialize Awesome Notifications
  //for system chrome
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController.initializeLocalNotifications();
  await UserPreferences.init();
  SystemChrome.setPreferredOrientations(
      //list of orientations here
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
  runApp(
    ChangeNotifierProvider(create: (context) => Model(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
          useMaterial3: true,
          iconButtonTheme: const IconButtonThemeData(
              style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(Colors.white),
          )),
          scaffoldBackgroundColor: kbackgroundColor,
          appBarTheme: const AppBarTheme(backgroundColor: ksecondaryColor),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: ksecondaryColor)),
      debugShowCheckedModeBanner: false,
    );
  }
}

final GoRouter _router = GoRouter(
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
            return const History();
          },
        ),
        GoRoute(
          path: 'starred',
          builder: (BuildContext context, GoRouterState state) {
            return const Starred();
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
