import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:thesaurus/constants.dart";
import 'package:thesaurus/model/model.dart';
import "package:word_generator/word_generator.dart";
import "package:awesome_notifications/awesome_notifications.dart";
import '../main.dart';

class NotificationController {
  static ReceivedAction? initialAction;
  static String word = '';

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static String setWord() {
    word = WordGenerator().randomVerb();
    return word;
  }

  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null, //'resource://drawable/res_app_icon',//
        [
          NotificationChannel(
              channelKey: 'alerts',
              channelName: 'Alerts',
              channelDescription: 'Notification tests as alerts',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple)
        ],
        debug: true);

    // Get initial notification action is optional
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    BuildContext context = MyApp.navigatorKey.currentContext!;
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      // For background actions, you must hold the execution until the end
      print(
          'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      executeLongTaskInBackground(context);
    } else {
      MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/notification-page',
          (route) =>
              (route.settings.name != '/notification-page') || route.isFirst,
          arguments: receivedAction);
    }
  }

  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: kbackgroundColor,
            title: Text('Get Notified!',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 20),
                Text(
                  'Allow Thesaurus to send you the Word of the day',
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ksecondaryColor,
                      elevation: 0.0,
                      padding: const EdgeInsets.all(17)),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ksecondaryColor,
                      elevation: 0.0,
                      padding: const EdgeInsets.all(17)),
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  ///  *********************************************
  ///     BACKGROUND TASKS TEST
  ///  *********************************************
  static void executeLongTaskInBackground(BuildContext context) {
    Provider.of<Model>(context, listen: false).onSubmitted(word);
    context.go("/response");
    Model().controller.text = word;
  }

  ///  *********************************************
  ///     NOTIFICATION C  REATION METHODS
  ///  *********************************************
  ///

  static Future<void> createNewNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1, // -1 is replaced by a random number
            channelKey: 'alerts',
            title: 'Word of the day',
            body: setWord(),
            largeIcon:
                'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            notificationLayout: NotificationLayout.BigPicture,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(
            actionType: ActionType.SilentAction,
            key: 'REDIRECT',
            label: 'Redirect',
          ),
        ]);
  }

  static Future<void> scheduleNewNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1, // -1 is replaced by a random number
            channelKey: 'alerts',
            title: "Word of the day",
            body: WordGenerator().randomVerb(),
            largeIcon:
                'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
            notificationLayout: NotificationLayout.BigPicture,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(
              actionType: ActionType.SilentAction,
              key: 'REDIRECT',
              label: 'Redirect'),
        ],
        schedule: NotificationCalendar( hour : 23, repeats: true)
        // scheduled
        //     ? Notif1icationInterval(
        //         interval: interval,
        //         timeZone:
        //             await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        //         preciseAlarm: true,
        //       )
        //     : null,
        );
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}
