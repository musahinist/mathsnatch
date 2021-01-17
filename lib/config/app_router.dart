import 'package:deneme/page/game/video_page.dart';
import 'package:deneme/page/home/no_connection_page.dart';
import 'package:deneme/page/menu/avatar_picker_page.dart';
import 'package:deneme/page/profile/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../bloc/menu/menu_bloc.dart';
import '../page/home/home_page.dart';
import '../page/menu/card_menu_page.dart';
import '../page/menu/main_menu_page.dart';
import '../page/menu/topic_menu_page.dart';

class AppRouter {
  static final route = [
    GetPage(
      name: HomePage.PATH,
      page: () => HomePage(),
    ),
    GetPage(
      name: NoConnectionPage.PATH,
      page: () => NoConnectionPage(),
    ),
    GetPage(
      name: ProfilePage.PATH,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: MainMenuPage.PATH,
      page: () =>
          BlocProvider(create: (context) => MenuBloc(), child: MainMenuPage()),
    ),
    GetPage(
      name: AvatarPickerPage.PATH,
      page: () => BlocProvider(
          create: (context) => MenuBloc(), child: AvatarPickerPage()),
    ),
    GetPage(
      name: TopicMenuPage.PATH,
      page: () =>
          BlocProvider(create: (context) => MenuBloc(), child: TopicMenuPage()),
    ),
    GetPage(
      name: CardMenuPage.PATH,
      page: () =>
          BlocProvider(create: (context) => MenuBloc(), child: CardMenuPage()),
    ),
    GetPage(
      name: VideoPage.PATH,
      page: () =>
          BlocProvider(create: (context) => MenuBloc(), child: VideoPage()),
    ),
  ];
}
