import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deneme/data/model/kard.dart';
import 'package:deneme/data/model/svg_avatar.dart';
import 'package:deneme/data/model/video.dart';
import 'package:video_player/video_player.dart';
import '../../data/model/topic.dart';
import '../../util/http/http_manager.dart';
import 'package:equatable/equatable.dart';
import '../../data/repository/menu_repository.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuRepository menuRepository = MenuRepository();
  VideoPlayerController _controller;
  MenuBloc() : super(MenuInitial());

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    if (event is GetTopicMenuEvent) {
      try {
        final List<Topic> topics = HttpManager.topics != null
            ? HttpManager.topics
            : await menuRepository.getAllTopics();
        yield TopicMenuLoadedState(topics: topics);
      } catch (e) {}
    }
    if (event is GetCardMenuEvent) {
      try {
        final List<Kard> kards =
            await menuRepository.getCardsById(topicId: event.cardId);
        yield CardMenuLoadedState(kards: kards);
      } catch (e) {}
    }
    if (event is GetVideoEvent) {
      yield VideoLoadingState();
      try {
        final Video video = await menuRepository.getVideo(
            topicId: event.topicId,
            cardId: event.cardId,
            videoId: event.videoId);
        _controller = VideoPlayerController.network(video.videoLink);
        await _controller.initialize().then((_) {
          _controller.play();
          add(VideoStartedEvent());
          //  _controller.setLooping(true);
          // Ensure the first frame is shown after the video is initialized
        });
        yield VideoLoadedState(video: video, vc: _controller);
      } catch (e) {}
      if (event is VideoStartedEvent) {
        yield VideoStartedState();
      }
    }
    if (event is SolutionVideoEvent) {
      yield VideoLoadingState();
      _controller = VideoPlayerController.network(event.solutionLink);
      await _controller.initialize().then((_) {
        _controller.play();
        add(VideoStartedEvent());
        //  _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
      });
      yield SolutionVideoLoadedState(
          vc: _controller,
          wcardId: event.wcardId,
          wtopicId: event.wtopicId,
          wvideoId: event.wvideoId);
    }
    if (event is GetAvatarsEvent) {
      List<SvgAvatar> avatars = await menuRepository.getAvatars();
      yield AvatarsLoadedState(avatars: avatars);
    }
  }
}
