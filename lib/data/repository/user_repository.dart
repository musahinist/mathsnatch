import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../util/http/http_manager.dart';
import '../model/user.dart';
import '../service/user_service.dart';

class UserRepository {
  final UserService _userService = UserService();

  Future<User> getUser() async {
    try {
      final response = await _userService.getUser();
      return User.fromMap(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<User> updateUser({@required Map user}) async {
    try {
      final response = await _userService.updateUser(user: user);
      return User.fromMap(response.data);
    } catch (e) {
      throw e;
    }
  }

  // Future<String> changePassword({
  //   @required String oldPassword,
  //   @required String newPassword,
  // }) async {
  //   try {
  //     final response = await _userService.changePassword(
  //       oldPassword: oldPassword,
  //       newPassword: newPassword,
  //     );
  //     return response.data;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<void> logout() async {
  //   try {
  //     await clearData();
  //     await _userService.logout();
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  void setUser({@required User user}) async {
    HttpManager.user = user;
    //  HttpManager.user.photoUrl = HttpManager.user.photoUrl;
  }
}
