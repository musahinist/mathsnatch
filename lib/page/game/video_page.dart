import 'package:deneme/bloc/menu/menu_bloc.dart';
import 'package:deneme/data/model/video.dart';
import 'package:deneme/util/pref_util.dart';
import 'package:deneme/widget/line_count_down_timer_widget.dart';
import 'package:deneme/widget/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:video_player/video_player.dart';

import '../../widget/count_down_timer_widget.dart';

class VideoPage extends StatefulWidget {
  static const String PATH = "/videoGame";
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // VideoPlayerController _controller;
  VideoPlayerController vc;
  Map args = Get.arguments;
  MenuBloc menuBloc;
  bool dialogFlag = true;
  bool feedBack;
  String defaultStream =
      'https://archive.org/download/Damas_BB_28F8B535_D_406/DaMaS.mp4';
  String stream2 = 'https://archive.org/download/cCloud_20151126/cCloud.mp4';
  String stream3 = 'https://archive.org/download/mblbhs/mblbhs.mp4';
  @override
  void initState() {
    super.initState();
    menuBloc = BlocProvider.of<MenuBloc>(context);
    Map video = PrefUtil.getGameState();
    if (PrefUtil.getGameState() != null) {
      menuBloc.add(
        GetVideoEvent(
            topicId: video["topicId"].toString(),
            cardId: video["cardId"].toString(),
            videoId: video["videoId"].toString()),
      );
    } else {
      menuBloc.add(
        GetVideoEvent(
            topicId: args["topicId"].toString(),
            cardId: args["cardId"].toString(),
            videoId: "1111111"),
      );
    }

    // _controller = VideoPlayerController.network(defaultStream)
    //   ..initialize().then((_) {
    //     _controller.play();
    //     //  _controller.setLooping(true);
    //     // Ensure the first frame is shown after the video is initialized
    //     setState(() {});
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<MenuBloc, MenuState>(
          listener: (context, state) {
            if (state is VideoStartedEvent) {
              setState(() {});
            }
          },
          child: Stack(
            children: [
              BlocBuilder<MenuBloc, MenuState>(
                cubit: menuBloc,
                // ignore: missing_return
                builder: (context, state) {
                  if (state is VideoLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is VideoLoadedState) {
                    vc = state.vc;
                    dialogFlag = true;

                    vc.addListener(() {
                      if (vc.value.position?.inSeconds ==
                              (vc.value.duration.inSeconds - 5) &&
                          dialogFlag) {
                        dialogFlag = false;
                        showModal(state.video);
                      }
                    });

                    return VideoPlayerWidget(vc: vc);
                  }
                  if (state is SolutionVideoLoadedState) {
                    vc = state.vc;
                    vc.addListener(() {
                      if (vc.value.position?.inMicroseconds ==
                          vc.value.duration?.inMicroseconds) {
                        menuBloc.add(GetVideoEvent(
                            cardId: state.wcardId,
                            topicId: state.wtopicId,
                            videoId: state.wvideoId));
                      }
                    });
                    return VideoPlayerWidget(vc: vc);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  showModal(Video video) {
    List answer = [
      {
        "answer": video.questions[0].wrongAnswer,
        "videoId": video.wrongVideoId,
        "isCorrect": false
      },
      {
        "answer": video.questions[0].correctAnswer,
        "videoId": video.correctVideoId,
        "isCorrect": true
      }
    ]..shuffle();

    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.black45,
      // isScrollControlled: true,
      context: context,
      builder: (_) {
        double width = MediaQuery.of(context).size.width;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //  mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: FittedBox(
                fit: BoxFit.none,
                child: SvgPicture.string(
                  video.questions[0].question,
                  height: 400,
                  width: 1600,
                ),
              )),
              // ElevatedButton(
              //   child: const Text('Close BottomSheet'),
              //   onPressed: () => Navigator.pop(context),
              // ),
              Column(
                children: [
                  LineCountDownTimerWidget(
                    duration: Duration(seconds: 10),
                    color: Colors.red,
                    width: width,
                    strokeWidth: 5,
                    onTimeIsUp: () {
                      menuBloc.add(
                        SolutionVideoEvent(
                            wtopicId: video.topicId,
                            wcardId: video.cardId,
                            wvideoId: video.wrongVideoId,
                            solutionLink: video.solutionVideoLink),
                      );
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    height: 80,
                    color: Colors.black,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildAnswer(video, answer[0]),
                        VerticalDivider(),
                        if (feedBack == null)
                          IconButton(
                            icon: Icon(Icons.help),
                            onPressed: () {
                              menuBloc.add(
                                SolutionVideoEvent(
                                    wtopicId: video.topicId,
                                    wcardId: video.cardId,
                                    wvideoId: video.wrongVideoId,
                                    solutionLink: video.solutionVideoLink),
                              );
                              Navigator.pop(context);
                            },
                          ),
                        if (feedBack == true) Icon(Icons.check),
                        if (feedBack == false) Icon(Icons.close),
                        VerticalDivider(),
                        buildAnswer(video, answer[1]),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  GestureDetector buildAnswer(Video video, Map answer) {
    return GestureDetector(
      child: FittedBox(
          fit: BoxFit.none,
          child: SvgPicture.string(
            answer["answer"],
            height: 400,
          )),
      onTap: () {
        feedBack = answer["isCorrect"];
        setState(() {});
        // menuBloc.add(
        //   GetVideoEvent(
        //       topicId: video.topicId,
        //       cardId: video.cardId, //Get.arguments["cardId"].toString(),
        //       videoId: answer["videoId"]),
        // );
        // Navigator.pop(context);
      },
    );
  }

  @override
  void dispose() {
    vc.dispose();
    super.dispose();
  }
}

class QuestionModal extends StatefulWidget {
  final Video video;
  final VoidCallback onAnswer;
  final VoidCallback onSolution;

  const QuestionModal({Key key, this.video, this.onAnswer, this.onSolution})
      : super(key: key);

  @override
  _QuestionModalState createState() => _QuestionModalState();
}

class _QuestionModalState extends State<QuestionModal> {
  bool feedBack;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Video video = widget.video;
    List answer = [
      {
        "answer": video.questions[0].wrongAnswer,
        "videoId": video.wrongVideoId,
        "isCorrect": false
      },
      {
        "answer": video.questions[0].correctAnswer,
        "videoId": video.correctVideoId,
        "isCorrect": true
      }
    ]..shuffle();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //  mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
              child: FittedBox(
            fit: BoxFit.none,
            child: SvgPicture.string(
              video.questions[0].question,
              height: 400,
              width: 1600,
            ),
          )),
          // ElevatedButton(
          //   child: const Text('Close BottomSheet'),
          //   onPressed: () => Navigator.pop(context),
          // ),
          Column(
            children: [
              LineCountDownTimerWidget(
                duration: Duration(seconds: 10),
                color: Colors.red,
                width: width,
                strokeWidth: 5,
                onTimeIsUp: () {
                  // menuBloc.add(
                  //   SolutionVideoEvent(
                  //       wtopicId: video.topicId,
                  //       wcardId: video.cardId,
                  //       wvideoId: video.wrongVideoId,
                  //       solutionLink: video.solutionVideoLink),
                  // );
                  Navigator.pop(context);
                },
              ),
              Container(
                height: 80,
                color: Colors.black,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildAnswer(video, answer[0]),
                    VerticalDivider(),
                    if (feedBack == null)
                      IconButton(
                        icon: Icon(Icons.help),
                        onPressed: () {
                          // menuBloc.add(
                          //   SolutionVideoEvent(
                          //       wtopicId: video.topicId,
                          //       wcardId: video.cardId,
                          //       wvideoId: video.wrongVideoId,
                          //       solutionLink: video.solutionVideoLink),
                          // );
                          Navigator.pop(context);
                        },
                      ),
                    if (feedBack == true) Icon(Icons.check),
                    if (feedBack == false) Icon(Icons.close),
                    VerticalDivider(),
                    buildAnswer(video, answer[1]),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector buildAnswer(Video video, Map answer) {
    return GestureDetector(
      child: FittedBox(
          fit: BoxFit.none,
          child: SvgPicture.string(
            answer["answer"],
            height: 400,
          )),
      onTap: () {
        feedBack = answer["isCorrect"];
        setState(() {});
        // menuBloc.add(
        //   GetVideoEvent(
        //       topicId: video.topicId,
        //       cardId: video.cardId, //Get.arguments["cardId"].toString(),
        //       videoId: answer["videoId"]),
        // );
        Navigator.pop(context);
      },
    );
  }
}
