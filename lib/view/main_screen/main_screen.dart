import "package:flutter/material.dart";
import "package:thesaurus/constants.dart";
import 'package:thesaurus/view/main_screen/widgets/custom_app_bar.dart';
import 'package:thesaurus/view/main_screen/widgets/header.dart';
import 'package:thesaurus/view/main_screen/widgets/history_card.dart';
import 'package:thesaurus/view/main_screen/widgets/starred_card.dart';
import '../../model/model.dart';
import '../../view_model/notifications.dart';
import "package:provider/provider.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kbackgroundColor,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50), child: CustomAppBar()),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Header(size: size),
            Expanded(
              child: ListView(children: [
                HistoryCard(
                  press: () =>
                      Provider.of<Model>(context, listen: false).deleteHistory(),
                  title: "History",
                  size: size,
                ),
                StarredCard(
                  press: () =>
                      Provider.of<Model>(context, listen: false).deleteStarred(),
                  size: size,
                  title: "Starred",
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
