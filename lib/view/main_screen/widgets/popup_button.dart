import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';

import '../../../constants.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(
          size: 32,
          Icons.expand_more_sharp,
          color: Colors.white,
        ),
        color: kprimaryColor,
        itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: PopUpButton(
                    press: () => context.go("/settings"), title: "Settings"),
              ),
              PopupMenuItem(
                  child: PopUpButton(
                press: () => context.go("/history"),
                title: "History",
              )),
              PopupMenuItem(
                  child: PopUpButton(
                      press: () => context.go("/starred"), title: "Starred")),
            ]);
  }
}

class PopUpButton extends StatelessWidget {
  PopUpButton({
    super.key,
    required this.press,
    required this.title,
  });

  final String title;
  GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: Colors.transparent),
        onPressed: press,
        child: Text(title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white)),
      ),
    );
  }
}
