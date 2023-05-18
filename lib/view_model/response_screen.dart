import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesaurus/view_model/thesaurus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../model/model.dart';
import '../view/main_screen/widgets/header.dart';

class ResponseScreen extends StatelessWidget {
  ResponseScreen({super.key});
  final TextEditingController _controller = TextEditingController();
  late Future<Thesaurus> futureThesaurus;

  late int count;
  final Uri _url = Uri.parse('https://www.google.com');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    futureThesaurus = fetchThesaurus(Model.searchedWord);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: FutureBuilder<Thesaurus>(
            future: futureThesaurus,
            builder: (context, snapshot) => Container(
              child: Column(
                children: [
                  Container(
                    height: 20,
                    color: ksecondaryColor,
                  ),
                  Consumer<Model>(
                    builder: (context, value, child) => Header(size: size),
                  ),
                  if (snapshot.connectionState == ConnectionState.waiting)
                    SizedBox(
                      height: size.height,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.5,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // to resolve overflow error when you get response
                            SizedBox(
                              height: size.height * 0.5,
                            )
                          ],
                        ),
                      ),
                    ),
                  if (snapshot.data?.synonyms.isEmpty ?? false)
                    SizedBox(
                      // height: size.height * 0.3,
                      width: size.width * 0.8,
                      child: Center(
                          child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            "Looks like the word you are",
                            style: TextStyle(
                                fontSize: size.height * 0.028,
                                color: Colors.white),
                          ),
                          Text(
                            "searching is not in our  ",
                            style: TextStyle(
                                fontSize: size.height * 0.028,
                                color: Colors.white),
                          ),
                          Text(
                            "collection yet",
                            style: TextStyle(
                                fontSize: size.height * 0.028,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: size.height * 0.08,
                            width: size.width * 0.5,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: ksecondaryColor,
                                ),
                                onPressed: () {
                                  launch(
                                      "https://www.google.com/search?q=${snapshot.data?.word}&oq=hik&aqs=chrome..69i57j0i433i512l2j0i512j0i433i512l3j0i512l3.1376j0j7&sourceid=chrome&ie=UTF-8");
                                },
                                child: Text(
                                  "Search web",
                                  style:
                                      TextStyle(
                                        color: Colors.white,
                                        fontSize: size.height * 0.029),
                                )),
                          )
                        ],
                      )),
                    ),
                  if (snapshot.data?.synonyms.isNotEmpty ?? false)
                    Container(
                      margin: const EdgeInsets.only(
                          top: 20, bottom: 7.0, left: 20, right: 20),
                      // height: size.height * 0.3,
                      // width: size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                offset: const Offset(0, 10),
                                color: Colors.black.withOpacity(0.23))
                          ],
                          color: kprimaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            alignment: Alignment.bottomLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data?.word ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Consumer<Model>(
                                      builder: (context, value, child) =>
                                          IconButton(
                                              onPressed: () =>
                                                  Provider.of<Model>(context,
                                                          listen: false)
                                                      .SwitchStarred(
                                                    snapshot.data?.word ?? "",
                                                  ),
                                              icon: (Thesaurus.isStarred)
                                                  ? const Icon(
                                                      Icons.star_outlined,
                                                      size: 26,
                                                      color: Colors.white,
                                                    )
                                                  : const Icon(
                                                      Icons.star_border,
                                                      size: 26,
                                                      color: Colors.white,
                                                    )),
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(),
                          Container(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Synonyms",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      fontSize: 19, color: Colors.white70),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "${snapshot.data?.synonyms.join(", ")}\t\t\t",
                              maxLines: 4,
                              // overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          if (snapshot.data?.antonyms.isNotEmpty ?? false)
                            Container(
                              padding: const EdgeInsets.only(top: 10, left: 20),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Antonyms",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontSize: 19, color: Colors.white70),
                              ),
                            ),
                          // SizedBox(
                          //   width: size.width * 0.7,
                          //   child: Text(
                          //     "${snapshot.data?.synonyms}\t\t\t",
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .titleLarge
                          //         ?.copyWith(fontSize: 16, color: Colors.white),
                          //   ),
                          // ),

                          Container(
                            padding: const EdgeInsets.only(top: 10, left: 22.0),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "${snapshot.data?.antonyms.join(" ,  ")}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 16, color: Colors.white),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  // IconButton(
                  //     onPressed: () => Navigator.pop(context),
                  //     icon: const Icon(Icons.arrow_back_ios)),
                ],
              ),
            ),
          ),
        ));
  }
}
