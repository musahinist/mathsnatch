import 'package:deneme/data/model/video.dart';
import 'package:deneme/data/service/avatar_service.dart';
import 'package:deneme/data/model/svg_avatar.dart';
import 'package:deneme/util/pref_util.dart';
import '../model/kard.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../util/http/http_manager.dart';
import '../model/topic.dart';
import '../service/menu_service.dart';

class MenuRepository {
  final MenuService menuService = MenuService();
  final AvatarService _avatarService = AvatarService();
  Future<List<Topic>> getAllTopics() async {
    try {
      final response = await menuService.getAllTopics();
      final List<Topic> topics =
          response.data.map<Topic>((t) => Topic.fromMap(t)).toList();
      setTopics(topics: topics);
      return topics;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Kard>> getCardsById({String topicId}) async {
    try {
      final response = await menuService.getCardsById(topicId: topicId);
      final List<Kard> cards =
          response.data.map<Kard>((t) => Kard.fromMap(t)).toList();
      setCards(cards: cards);
      return cards;
    } catch (e) {
      throw e;
    }
  }

  Future<Video> getVideo(
      {String topicId, String cardId, String videoId}) async {
    try {
      final response = await menuService.getVideoById(
          topicId: topicId, cardId: cardId, videoId: videoId);
      final Video video = Video.fromMap(response.data);
      saveGameState(video.topicId, video.cardId, video.videoId);
      return video;
    } catch (e) {
      throw e;
    }
  }

  Future<List<SvgAvatar>> getAvatars() async {
    try {
      final response = await _avatarService.getAvatars();
      List<SvgAvatar> avatars =
          response.data.map<SvgAvatar>((e) => SvgAvatar.fromMap(e)).toList();
      return avatars;
    } catch (e) {
      throw e;
    }
  }

  void setTopics({@required List<Topic> topics}) async {
    HttpManager.topics = topics;
  }

  void setCards({@required List<Kard> cards}) async {
    HttpManager.cards = cards;
  }

  Future<void> saveGameState(topicId, cardId, videoId) {
    PrefUtil.saveGameState(topicId: topicId, cardId: cardId, videoId: videoId);
  }
}
