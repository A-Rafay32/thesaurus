import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:thesaurus/view/main_screen/widgets/popup_button.dart';
import 'package:word_generator/word_generator.dart';

import '../../../constants.dart';
import '../../../model/model.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      elevation: 0.0,
      backgroundColor: ksecondaryColor,
      actions: [
        AspectRatio(
          aspectRatio: 0.82,
          child: IconButton(
              onPressed: () {
                String value = WordGenerator().randomVerb();
                Provider.of<Model>(context, listen: false).onSubmitted(value);
                context.go("/response");
              },
              tooltip: "Random",
              icon: SvgPicture.asset("assets/icons/random.svg",
                  // height: size.height*0.08,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn))),
        ),
        const CustomPopupMenuButton()
      ],
      title: Text(
        "Thesaurus",
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
