import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimerWidget extends StatefulWidget {
  final Color color;
  final double radius;
  final Duration duration;
  final double strokeWidth;
  final VoidCallback onTimeIsUp;

  CountDownTimerWidget({
    this.duration,
    this.color,
    this.radius,
    this.strokeWidth,
    this.onTimeIsUp,
  });
  @override
  _CountDownTimerWidgetState createState() => _CountDownTimerWidgetState();
}

class _CountDownTimerWidgetState extends State<CountDownTimerWidget> {
  Timer _timer;
  int start;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (start < 1) {
            timer.cancel();
            //  widget.onTimeIsUp();
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
    start = widget.duration.inSeconds;
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
          SizedBox(
            height: widget.radius * 2,
            width: widget.radius * 2,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(start < 300
                  ? start < 60
                      ? Colors.red
                      : Colors.amber
                  : Colors.blue),
              backgroundColor: Colors.transparent,
              value: start / widget.duration.inSeconds,
              strokeWidth: widget.strokeWidth ?? 5,
            ),
          ),
          Text(
            (start / 60).floor().toString() +
                ":" +
                (start % 60).toString().padLeft(2, "0"),
            textScaleFactor: widget.radius / 18,
          )
        ],
      ),
    );
  }
}
