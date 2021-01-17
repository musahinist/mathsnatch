import 'package:deneme/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';
import 'bloc/auth/authentication_bloc.dart';
import 'bloc/auth/authentication_event.dart';
import 'bloc/simple_bloc_observer.dart';
import 'config/app_router.dart';
import 'util/log/log.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  await GetStorage.init();
  Bloc.observer = SimpleBlocObserver();
  Log.init();
  AuthenticationBloc().add(AuthenticationAppStartedEvent());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      builder: (context, child) {
        ScreenUtil()..init(context);
        return Theme(
          data: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.getTextTheme("Ranchers",
                TextTheme(bodyText1: TextStyle(color: Colors.white))),
          ),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   brightness: Brightness.dark,
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      //   textTheme: GoogleFonts.getTextTheme(
      //       "Ranchers", TextTheme(bodyText1: TextStyle(color: Colors.white))),
      // ),
      initialRoute: "/",
      getPages: AppRouter.route,
    );
  }
}
