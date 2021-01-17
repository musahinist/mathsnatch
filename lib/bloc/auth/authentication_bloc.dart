import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

import '../../data/model/user.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  static final AuthenticationBloc _singleton = AuthenticationBloc._internal();

  AuthenticationBloc._internal() : super(AuthenticationInitialState());

  factory AuthenticationBloc() => _singleton;

  // final RouteRepository _routeRepository = RouteRepository();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final UserRepository _userRepository = UserRepository();
  StreamSubscription _subscription;

  @override
  Future<void> close() async {
    await _singleton.close();
    _subscription.cancel();
    return super.close();
  }

  @override
  AuthenticationState get initialState => AuthenticationInitialState();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationAppStartedEvent) {
      _subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        // Got a new connectivity status!
        if (result == ConnectivityResult.none) {
          Get.defaultDialog(
              barrierDismissible: false,
              title: "No Internet Connection",
              content: WillPopScope(
                onWillPop: () async {
                  return await SystemChannels.platform
                      .invokeMethod("SystemNavigator.pop" ?? false);
                },
                child: Text("No Connection"),
              ));

          // add(NoConnectionEvent());
        } else {
          Get.back();
          final hasToken = await _authenticationRepository.hasToken();
          if (hasToken) {
            add(AuthenticationAuthenticateEvent());
          } else {
            add(AuthenticationCreateGuestEvent());
          }
        }
      });
    }
    if (event is AuthenticationAuthenticateEvent) {
      try {
        //  await _authenticationRepository.saveAuthData();
        final User user = await _userRepository.getUser();
        _userRepository.setUser(user: user);
        // await Future.delayed(Duration(seconds: 10));
        yield AuthenticationSuccesState();
        // _routeRepository.determineTheWay();
      } catch (e) {
        await _authenticationRepository.clearAuthData();
        // _routeRepository.jumpToLogin();
        // throw e;
      }
    }
    if (event is AuthenticationCreateGuestEvent) {
      try {
        await _authenticationRepository.createGuest();
        add(AuthenticationAuthenticateEvent());
      } catch (e) {}
    }
    if (event is AuthenticationLoggedOutEvent) {
      // await _userRepository.logout();
      await _authenticationRepository.clearAuthData();
      // _routeRepository.jumpToLogin();
    }
    if (event is NoConnectionEvent) {
      yield NoConnectionState();
    }
  }
}
