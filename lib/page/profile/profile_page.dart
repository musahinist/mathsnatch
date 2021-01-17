import 'package:deneme/config/app_constant.dart';
import 'package:deneme/data/model/svg_avatar.dart';
import 'package:deneme/data/model/user.dart';
import 'package:deneme/page/menu/avatar_picker_page.dart';
import 'package:deneme/util/http/http_manager.dart';
import 'package:deneme/util/screen_util.dart';
import 'package:deneme/widget/drop_down_picker_form_field_widget.dart';
import 'package:deneme/widget/form_input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

class ProfilePage extends StatefulWidget {
  static const String PATH = "/profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final ageController = TextEditingController();

  User user = HttpManager.user;
  String avatar = HttpManager.user.avatar.avatarSvg;
  void setAvatar(SvgAvatar avatar) {
    this.avatar = avatar.avatarSvg;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   //  title: Text("Update Your Profile"),
      // ),
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: SvgPicture.asset(
              "asset/svg/1.min.svg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.black54,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      child: Hero(
                        tag: "avatar",
                        child: SizedBox(
                          width: ScreenUtil().setWidth(300),
                          height: ScreenUtil().setWidth(300),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: SvgPicture.string(avatar),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.defaultDialog(
                          title: "Pick Avatar",
                          content: AvatarPickerPage(avatar: setAvatar),
                        );
                      },
                    ),
                    IconButton(
                      iconSize: 48,
                      color: Colors.blue,
                      icon: Icon(
                        Icons.face_retouching_natural,
                      ),
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Pick Avatar",
                          content: AvatarPickerPage(avatar: setAvatar),
                        );
                      },
                    )
                  ],
                ),
                Container(
                  width: ScreenUtil().setWidth(600),
                  height: double.maxFinite,
                  child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: TabBar(
                        tabs: [
                          Tab(text: "SignIn"),
                          Tab(text: "SignUp"),
                        ],
                      ),
                      body: TabBarView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Form(
                            child: ListView(
                              children: [
                                FormInputFieldWidget(
                                    controller: emailController,
                                    labelText: "email",
                                    iconPrefix: Icons.mail),
                                FormInputFieldWidget(
                                  controller: passwordController,
                                  labelText: "password",
                                  iconPrefix: Icons.lock,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 16),
                                  height: 66,
                                  child: RaisedButton(
                                    child: Text("SIGN IN"),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                          ),
                          Form(
                            child: ListView(
                              children: [
                                FormInputFieldWidget(
                                  controller: nameController,
                                  labelText: "name",
                                  iconPrefix: Icons.person,
                                ),
                                FormInputFieldWidget(
                                    controller: emailController,
                                    labelText: "email",
                                    iconPrefix: Icons.mail),
                                FormInputFieldWidget(
                                  controller: passwordController,
                                  labelText: "password",
                                  iconPrefix: Icons.lock,
                                ),
                                FormInputFieldWidget(
                                  controller: ageController,
                                  labelText: "age",
                                  iconPrefix: Icons.cake,
                                ),
                                DropDownPickerFormFieldWidget(
                                  iconPrefix: Icons.place,
                                  menuOptions: Constant.cityList
                                      .map((e) => e["name"])
                                      .toList(),
                                  labelText: "Choose City",
                                  selectedOption: null,
                                  onChanged: (value) {},
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 16),
                                  height: 66,
                                  child: RaisedButton(
                                    child: Text("SIGN IN"),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}

class Avatar {}
