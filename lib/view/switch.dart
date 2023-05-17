import 'package:flutter/material.dart';
import 'package:thesaurus/constants.dart';
import 'package:thesaurus/view_model/notifications.dart';

void main() => runApp(const SwitchApp());

class SwitchApp extends StatelessWidget {
  const SwitchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Switch Sample')),
        body: const Center(
          child: SwitchExample(),
        ),
      ),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: ksecondaryColor,
      onChanged: (bool value) {
        // NotificationController.scheduleNewNotification();
        (light != value)
              ? NotificationController.createNewNotification()
              : NotificationController.displayNotificationRationale();

        setState(() {
          
          light = value;
        });
      },
    );
  }
}
