import 'dart:ui';

import 'package:deneme/bloc/menu/menu_bloc.dart';
import 'package:deneme/data/model/kard.dart';
import 'package:deneme/page/game/video_page.dart';
import 'package:deneme/util/http/http_manager.dart';
import 'package:deneme/widget/line_count_down_timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

class CardMenuPage extends StatefulWidget {
  static const String PATH = "/cardMenu";

  const CardMenuPage();

  @override
  _CardMenuPageState createState() => _CardMenuPageState();
}

class _CardMenuPageState extends State<CardMenuPage> {
  MenuBloc menuBloc;
  PageController pageCtrl =
      PageController(initialPage: 0, viewportFraction: 0.3);

  int select = 0;
  String topicId = Get.arguments;
  @override
  void initState() {
    menuBloc = BlocProvider.of<MenuBloc>(context)
      ..add(GetCardMenuEvent(cardId: Get.arguments.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 16.0),
      //   child: Row(
      //     children: [
      //       FloatingActionButton(
      //         heroTag: Get.arguments["image"],
      //         backgroundColor: Colors.transparent,
      //         child: SvgPicture.asset(
      //           Get.arguments["image"],
      //         ),
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       SizedBox(width: 8),
      //       Text(
      //         Get.arguments["name"],
      //         style: TextStyle(fontSize: 16, color: Colors.white),
      //       )
      //     ],
      //   ),
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.darken),
              image: AssetImage("asset/image/space1.jpg"),
              fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Container(
            color: Colors.black12,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
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
                    if (state is CardMenuLoadedState) {
                      List<Kard> kards = state.kards;
                      return PageView.builder(
                        controller: pageCtrl,
                        itemCount: kards.length,
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
                                  child: SvgPicture.string(
                                      HttpManager.cards[i].cardPic
                                      //  color: i == select ? null : Colors.grey,
                                      ),
                                ),
                                onTap: i == select
                                    ? () {
                                        Get.toNamed(VideoPage.PATH, arguments: {
                                          "topicId": topicId,
                                          "cardId": kards[i].cardId
                                        });
                                      }
                                    : null,
                              ),
                              Text(
                                kards[i].cardName,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              // Text(
                              //   "Zorluk: " + topics[i].difficulty.toString(),
                              //   style: TextStyle(
                              //       fontSize: 16, color: Colors.white),
                              // )
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
          ),
        ),
      ),
    );
  }
}
