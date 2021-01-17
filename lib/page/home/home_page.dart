import 'package:deneme/page/home/no_connection_page.dart';

import '../menu/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../bloc/auth/authentication_bloc.dart';
import '../../bloc/auth/authentication_state.dart';

class HomePage extends StatelessWidget {
  static const String PATH = "/";
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: AuthenticationBloc(),
      listener: (_, state) {
        if (state is AuthenticationSuccesState) {
          Get.offAllNamed(MainMenuPage.PATH);
        }
        if (state is NoConnectionState) {
          Get.toNamed(NoConnectionPage.PATH);
        }
      },
      child: Container(
        // color: Colors.purple[900],
        child: Stack(
          children: [
            Center(
              child: CircularProgressIndicator(),
            )
            // FlareActor("asset/animation/Cosmos.flr",
            //     alignment: Alignment.center,
            //     fit: BoxFit.contain,
            //     animation: "Untitled"),
            // SizedBox(
            //   height: 150,
            //   child: FlareActor("asset/animation/Meteor.flr",
            //       alignment: Alignment.topRight,
            //       fit: BoxFit.contain,
            //       animation: "Idle"),
            // ),
          ],
        ),
      ),
    );
  }
}
