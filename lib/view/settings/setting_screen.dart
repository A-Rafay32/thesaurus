import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:thesaurus/view/switch.dart';
import '../../constants.dart';
import '../../model/model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isEnabled = false;
    bool isSwitched = true;
    bool light = true;
    return Scaffold(
        backgroundColor: kbackgroundColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.go("/"),
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          title: Text(
            "Settings",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    color: secondaryTextColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: const [
                //       // use text.rich()
                //       Text(
                //         "Word of the Memory",
                //         style: TextStyle(
                //           fontSize: 17,
                //           color: primaryTextColor,
                //         ),
                //       ),

                //       SwitchExample()
                //     ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      // use text.rich()
                      Text(
                        "Word of the Day",
                        style: TextStyle(
                          fontSize: 17,
                          color: primaryTextColor,
                        ),
                      ),
                      SwitchExample()
                    ]),
                const Divider(
                  thickness: 1.5,
                  color: secondaryTextColor,
                ),
                Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "History",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: secondaryTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Provider.of<Model>(context, listen: false)
                                  .deleteHistory();
                            },
                            child: const Text(
                              "Clear History",
                              style: TextStyle(
                                fontSize: 17,
                                color: primaryTextColor,
                              ),
                            ),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Provider.of<Model>(context, listen: false)
                                  .deleteStarred();
                            },
                            child: const Text(
                              "Clear Starred",
                              style: TextStyle(
                                fontSize: 17,
                                color: primaryTextColor,
                              ),
                            ),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
