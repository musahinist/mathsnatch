import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController vc;

  const VideoPlayerWidget({Key key, this.vc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      //  overflow: Overflow.visible,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: vc.value.size?.width ?? 0,
              height: vc.value.size?.height ?? 0,
              child: AspectRatio(
                aspectRatio: vc.value.aspectRatio, //16 / 9,
                child: VideoPlayer(vc),
              ),
            ),
          ),
        ),
        VideoProgressIndicator(
          vc,
          allowScrubbing: true,
          padding: EdgeInsets.all(8),
        ),
        _PlayPauseOverlay(controller: vc),
      ],
    );
  }
}

class _PlayPauseOverlay extends StatefulWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  __PlayPauseOverlayState createState() => __PlayPauseOverlayState();
}

class __PlayPauseOverlayState extends State<_PlayPauseOverlay> {
  bool togglePlay = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 150),
          reverseDuration: Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              togglePlay ? widget.controller.play() : widget.controller.pause();
              togglePlay = !togglePlay;
              //play on tap
            });
          },
        ),
      ],
    );
  }
}
