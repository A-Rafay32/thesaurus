import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import "package:provider/provider.dart";
import "package:thesaurus/constants.dart";
import 'package:thesaurus/view/main_screen/widgets/custom_text_field.dart';
import 'package:thesaurus/view/main_screen/widgets/popup_button.dart';

import '../../model/model.dart';

class StarredScreen extends StatelessWidget {
  const StarredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: const [CustomPopupMenuButton()],
        leading: IconButton(
            onPressed: () => context.go("/"),
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text("Starred ",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              CustomTextField(),
              Expanded(
                  child: Consumer<Model>(
                builder: (context, value, child) => ListView.builder(
                    itemCount: Model.starredpref?.length as int,
                    itemBuilder: (context, index) => ListCard(
                        press: () => Provider.of<Model>(context, listen: false)
                            .deleteStarredWord(
                                Model.starredpref?[index] ?? " "),
                        text: Model.starredpref?[index] ?? " ")),
              ))
            ],
          )),
    );
  }
}

class ListCard extends StatelessWidget {
  final String text;
  GestureTapCallback press;

  ListCard({super.key, required this.press, required this.text});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: kprimaryColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: TextStyle(
                  color: Colors.white, fontSize: size.height * 0.026)),
          IconButton(
              iconSize: size.height * 0.033,
              onPressed: press,
              icon: const Icon(Icons.delete_outline_rounded,
                  color: Colors.white)),
        ],
      ),
    );
  }
}
