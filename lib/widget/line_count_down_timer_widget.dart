import 'dart:async';

import 'package:flutter/material.dart';

class LineCountDownTimerWidget extends StatefulWidget {
  final Color color;

  final Duration duration;
  final double strokeWidth;
  final VoidCallback onTimeIsUp;
  final double width;

  LineCountDownTimerWidget({
    this.duration,
    this.color,
    this.strokeWidth,
    this.onTimeIsUp,
    this.width,
  });
  @override
  _LineCountDownTimerWidgetState createState() =>
      _LineCountDownTimerWidgetState();
}

class _LineCountDownTimerWidgetState extends State<LineCountDownTimerWidget> {
  Timer _timer;
  int start;

  void startTimer() {
    const oneSec = const Duration(milliseconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (start < 1) {
            timer.cancel();
            widget.onTimeIsUp();
          } else {
            start = start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    startTimer();
    start = widget.duration.inMilliseconds;
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: widget.strokeWidth,
            color: widget.color,
            width: (start / widget.duration.inMilliseconds) * widget.width,
          ),
          // Text(
          //   (start / 60).floor().toString() +
          //       ":" +
          //       (start % 60).toString().padLeft(2, "0"),
          //   textScaleFactor: widget.radius / 18,
          // )
        ],
      ),
    );
  }
}
