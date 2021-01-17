part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class GetTopicMenuEvent extends MenuEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'GetTopicMenuEvent';
}

class GetCardMenuEvent extends MenuEvent {
  final String cardId;

  GetCardMenuEvent({this.cardId});
  @override
  List<Object> get props => [cardId];
  @override
  String toString() => 'GetCardMenuEvent';
}

class GetVideoEvent extends MenuEvent {
  final String videoId;
  final String topicId;
  final String cardId;

  GetVideoEvent({this.topicId, this.cardId, this.videoId});
  @override
  List<Object> get props => [videoId, topicId, cardId];
  @override
  String toString() => 'GetVideoEvent';
}

class VideoStartedEvent extends MenuEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'VideoStartedEvent';
}

class SolutionVideoEvent extends MenuEvent {
  final String solutionLink;
  final String wvideoId;
  final String wtopicId;
  final String wcardId;
  SolutionVideoEvent(
      {this.wvideoId, this.wtopicId, this.wcardId, this.solutionLink});
  @override
  List<Object> get props => [solutionLink, wvideoId, wtopicId, wcardId];
  @override
  String toString() => 'SolutionVideoEvent';
}

class GetAvatarsEvent extends MenuEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetAvatarsEvent';
}
