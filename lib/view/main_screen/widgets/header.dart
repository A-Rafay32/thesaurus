import 'package:flutter/material.dart';
import 'package:thesaurus/view/main_screen/main_screen.dart';

import '../../../constants.dart';
import 'custom_text_field.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.2,
      width: size.width,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 10),
                color: Colors.black.withOpacity(0.23))
          ],
          color: ksecondaryColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )),
      child: Column(children: [
        CustomTextField(),
        Expanded(child: Container())
      ]),
    );
  }
}
