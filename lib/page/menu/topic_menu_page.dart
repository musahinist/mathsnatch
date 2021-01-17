import 'dart:ui';

import 'package:deneme/page/menu/card_menu_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

import '../../bloc/menu/menu_bloc.dart';
import '../../data/model/topic.dart';

class TopicMenuPage extends StatefulWidget {
  static const String PATH = "/topicMenu";

  const TopicMenuPage();

  @override
  _TopicMenuPageState createState() => _TopicMenuPageState();
}

class _TopicMenuPageState extends State<TopicMenuPage> {
  MenuBloc menuBloc;
  PageController pageCtrl =
      PageController(initialPage: 0, viewportFraction: 0.3);
  Map args = Get.arguments;
  int select = 0;
  List<Topic> topics;
  @override
  void initState() {
    menuBloc = BlocProvider.of<MenuBloc>(context)..add(GetTopicMenuEvent());
    super.initState();
  }

  @override
  void dispose() {
    menuBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            FloatingActionButton(
              heroTag: args["image"],
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(args["image"]),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 8),
            Text(
              args["name"],
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: SvgPicture.asset(
              "asset/svg/space_bg2.min.svg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.black87,
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent)),
          ),
          BlocBuilder<MenuBloc, MenuState>(
            cubit: menuBloc,
            // ignore: missing_return
            builder: (context, state) {
              if (state is TopicMenuLoadedState) {
                topics = state.topics;
                return PageView.builder(
                  controller: pageCtrl,
                  itemCount: topics.length,
                  scrollDirection: Axis.vertical,
                  // pageSnapping: false,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (i) {
                    select = i;

                    setState(() {});
                  },
                  itemBuilder: (_, i) => AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    // color: i == select
                    //     ? Colors.black.withOpacity(.5)
                    //     : Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                            height: i == select ? 130 : 90,
                            child: SvgPicture.string(topics[i].topicPic),
                          ),
                          onTap: i == select
                              ? () {
                                  Get.toNamed(CardMenuPage.PATH,
                                      arguments: topics[i].topicId);
                                }
                              : null,
                        ),
                        Text(
                          topics[i].topicName,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(topics[i].topicId),
                        Text(
                          "Zorluk: " + topics[i].difficulty.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
