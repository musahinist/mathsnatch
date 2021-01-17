import 'package:deneme/bloc/menu/menu_bloc.dart';
import 'package:deneme/page/menu/avatar_picker_page.dart';
import 'package:deneme/page/profile/profile_page.dart';
import 'package:deneme/widget/form_input_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

import '../../data/model/user.dart';
import '../../util/http/http_manager.dart';
import 'topic_menu_page.dart';

class MainMenuPage extends StatefulWidget {
  static const String PATH = "/mainMenu";
  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  User user = HttpManager.user;
  MenuBloc menuBloc;
  PageController pageCtrl =
      PageController(initialPage: 2, viewportFraction: 0.3);
  int select = 2;

  List<Map> subjects = [
    // {"image": "asset/svg/3594077.svg", "name": "Adventure"},
    {"image": "asset/svg/3594093.svg", "name": "Arena"},
    //  {"image": "asset/svg/3594080.svg", "name": "Arena"},
    {"image": "asset/svg/3594089.svg", "name": "Adventure"},
    //  {"image": "asset/svg/3594097.svg", "name": "Adventure"}
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    menuBloc = BlocProvider.of<MenuBloc>(context);
  }

  setUserUpdate() {
    Map userPatch = {
      "email": user.email,
      // "password":"",
      "age": user.age,
      "location": user.location,
      "avatar": user.avatar.sId
    };
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: SvgPicture.asset(
              "asset/svg/space_bg.min.svg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.black87,
          ),
          PageView.builder(
            controller: pageCtrl,
            itemCount: subjects.length,
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
                      height: i == select ? 150 : 100,
                      child: Hero(
                        tag: subjects[i]["image"],
                        child: SvgPicture.asset(
                          subjects[i]["image"],

                          //  color: i == select ? null : Colors.grey,
                        ),
                      ),
                    ),
                    onTap: i == select
                        ? () {
                            Get.toNamed(
                              TopicMenuPage.PATH,
                              arguments: subjects[i],
                            );
                          }
                        : null,
                  ),
                  i == select
                      ? Text(
                          subjects[i]["name"],
                          style: TextStyle(fontSize: 36, color: Colors.white),
                        )
                      : SizedBox(
                          height: 40,
                        )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // SizedBox(
                //     width: 48,
                //     child: SvgPicture.asset("asset/svg/dart.min.svg")),
                // SizedBox(
                //     width: 48,
                //     child: SvgPicture.asset("asset/svg/clock.min.svg")),
                // SizedBox(
                //     height: 48,
                //     width: 48,
                //     child: SvgPicture.asset("asset/svg/poop.min.svg")),
                GestureDetector(
                  child: Hero(
                    tag: "avatar",
                    child: SizedBox(
                      width: 48,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: SvgPicture.string(user.avatar.avatarSvg),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(ProfilePage.PATH);
                    // Get.defaultDialog(
                    //   title: "Pick Avatar",
                    //   content: AvatarPickerPage(),
                    // );
                  },
                ),
                //  Text(user.name),
                Spacer(),
                //  Spacer(),
                SizedBox(
                    height: 48,
                    width: 48,
                    child: SvgPicture.asset("asset/svg/key0.svg")),
                Text("${user.level}",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(
                    width: 48,
                    child: SvgPicture.asset("asset/svg/ruby.min.svg")),
                Text("${user.gems}",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(
                    width: 48,
                    child: SvgPicture.asset("asset/svg/coin.min.svg")),
                Text("${user.coins}",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(
                    width: 48,
                    child: SvgPicture.asset("asset/svg/health_tube.min.svg")),
                Text("${100 - user.wrongAnswers} %",
                    style: TextStyle(fontSize: 20, color: Colors.white))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
