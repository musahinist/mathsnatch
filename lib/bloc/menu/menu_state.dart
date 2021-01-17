part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class TopicMenuLoadedState extends MenuState {
  final List<Topic> topics;

  TopicMenuLoadedState({this.topics});
  @override
  List<Object> get props => [topics];
  @override
  String toString() => 'TopicMenuLoadedState';
}

class CardMenuLoadedState extends MenuState {
  final List<Kard> kards;

  CardMenuLoadedState({this.kards});
  @override
  List<Object> get props => [kards];
  @override
  String toString() => 'CardMenuLoadedState';
}

class VideoLoadedState extends MenuState {
  final Video video;
  final VideoPlayerController vc;

  VideoLoadedState({this.vc, this.video});
  @override
  List<Object> get props => [video, vc];
  @override
  String toString() => 'VideoLoadedState';
}

class VideoLoadingState extends MenuState {
  String toString() => 'VideoLoadingState';
}

class VideoStartedState extends MenuState {
  String toString() => 'VideoStartedState';
}

class SolutionVideoLoadedState extends MenuState {
  final String wvideoId;
  final String wtopicId;
  final String wcardId;
  final VideoPlayerController vc;

  SolutionVideoLoadedState(
      {this.vc, this.wcardId, this.wtopicId, this.wvideoId});
  @override
  List<Object> get props => [vc, wcardId, wtopicId, wvideoId];
  @override
  String toString() => 'VideoLoadedState';
}

class AvatarsLoadedState extends MenuState {
  List<SvgAvatar> avatars;
  AvatarsLoadedState({this.avatars});
  @override
  List<Object> get props => [avatars];

  @override
  String toString() => 'GetAvatarsEvent';
}
