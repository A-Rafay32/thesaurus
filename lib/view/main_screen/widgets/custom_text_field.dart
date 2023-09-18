import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:thesaurus/model/model.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
  });
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 25,
            bottom: 20,
          ),
          height: size.height * 0.09,
          width: size.width * 0.9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Center(
            child: TextSelectionTheme(
                data: Theme.of(context).textSelectionTheme.copyWith(
                      cursorColor: Colors.black,
                      selectionColor: Colors.black.withOpacity(0.25),
                      selectionHandleColor: Colors.black,
                    ),
                child: TextField(
                  onSubmitted: (value) {
                    Provider.of<Model>(context, listen: false)
                        .onSubmitted(value);
                    context.go("/");    
                    context.go("/response");
                  },
                  controller:
                      Provider.of<Model>(context, listen: false).controller,
                  style: TextStyle(
                      fontSize: size.height * 0.032, color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    suffixIcon: IconButton(
                        onPressed: () {
                          
                        },
                        icon: Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                          size: size.height * 0.045,
                        )),
                    hintText: "Search",
                    hintStyle: TextStyle(
                        fontSize: size.height * 0.03, color: Colors.black),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
