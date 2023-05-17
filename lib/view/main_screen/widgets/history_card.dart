import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../model/model.dart';
import '../../../model/shared_prefs.dart';

class HistoryCard extends StatefulWidget {
  GestureTapCallback press;
  final String title;
  // final int itemCount;
  // final List<String> itemBuilder;

  HistoryCard({
    super.key,
    required this.size,
    required this.title,
    // required this.itemBuilder,
    // required this.itemCount,
    required this.press,
  });

  final Size size;

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  List<String>? history = [];

  @override
  void initState() {
    //get history from shared prefs when app restarts
    Model.historypref = UserPreferences.getHistoryList() ?? [];
    //reload the changes in history list due to onSubmitted calls
    Model().reloadHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            const EdgeInsets.only(top: 20, bottom: 7.0, left: 20, right: 20),
        height: widget.size.height * 0.3,
        width: widget.size.width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                  color: Colors.black.withOpacity(0.23))
            ],
            color: kprimaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets
                  // .all(13),
                  .symmetric(horizontal: 18.0, vertical: 8.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  IconButton(
                      onPressed: widget.press,
                      icon: const Icon(Icons.delete_outline_rounded,
                          color: Colors.white))
                ],
              ),
            ),
            Expanded(
                child: Consumer<Model>(
              builder: (context, value, child) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: Model.historypref?.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: widget.size.height * 0.05,
                      child: TextButton(
                        onPressed: () {
                          Provider.of<Model>(context, listen: false)
                              .onSubmitted(
                                  Model.history.reversed.toList()[index]);
                          context.go("/response");
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: widget.size.width * 0.04,
                            ),
                            Text("-",
                                style: TextStyle(
                                  fontSize: widget.size.height * 0.023,
                                  color:
                                      const Color.fromARGB(230, 255, 255, 255),
                                )),
                            SizedBox(
                              width: widget.size.width * 0.04,
                            ),
                            Text(
                              "${Model.historypref?.reversed.toList()[index]}",
                              style: TextStyle(
                                  fontSize: widget.size.height * 0.023,
                                  color:
                                      const Color.fromARGB(230, 255, 255, 255)),
                            ),
                          ],
                        ),
                      ),
                    );
                    // }
                  }),
            )),
          ],
        ));
  }
}
