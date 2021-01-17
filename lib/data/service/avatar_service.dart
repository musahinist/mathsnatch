import 'package:dio/dio.dart';

import 'abstract_service.dart';

class AvatarService extends AbstractService {
  final String path;
  final String tag;

  AvatarService({
    this.path = "avatars",
    this.tag = "AvatarService",
  }) : super(path, tag);

  Future<Response> getAvatars() async {
    try {
      final response = await get();
      return response;
    } catch (e) {
      throw e;
    }
  }
}
