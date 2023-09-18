import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "package:thesaurus/constants.dart";
import "package:thesaurus/model/model.dart";
import "package:thesaurus/routes.dart";
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
      routerConfig: router,
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
