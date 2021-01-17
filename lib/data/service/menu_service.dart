import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../model/user.dart';
import 'abstract_service.dart';

class MenuService extends AbstractService {
  final String path;
  final String tag;

  MenuService({
    this.path = "",
    this.tag = "TopicService",
  }) : super(path, tag);
  Future<Response> getAllTopics() async {
    try {
      final response = await get(
        innerPath: 'topics',
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> getTopic({@required String topicId}) async {
    try {
      final response = await get(
        innerPath: 'topics',
        queryParameters: {'topicId': topicId},
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> getCardsById({@required String topicId}) async {
    try {
      final response = await get(
        innerPath: 'cards',
        queryParameters: {'topicId': topicId},
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> getVideoById({
    @required String topicId,
    @required String cardId,
    @required String videoId,
  }) async {
    try {
      final response = await get(
        innerPath: 'videos',
        queryParameters: {
          'topicId': topicId,
          'cardId': cardId,
          'videoId': videoId
        },
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
