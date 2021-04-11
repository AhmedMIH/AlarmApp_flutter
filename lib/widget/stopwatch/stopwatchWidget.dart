import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchWidget extends StatefulWidget {
  @override
  _StopWatchWidgetState createState() => _StopWatchWidgetState();
}

class _StopWatchWidgetState extends State<StopWatchWidget> {
  Stopwatch _stopwatch;
  Timer _timer;
  bool reset = true;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formatTime(_stopwatch.elapsedMilliseconds),
            style: TextStyle(fontSize: 64, color: Colors.white),
          ),
          SizedBox(
            height: 32,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: 32),
              minimumSize: Size(110, 50),
            ),
            onPressed: () {
              setState(() {
                reset = false;
              });
              handleStartStop();
            },
            child: Text(_stopwatch.isRunning ? 'Stop' : 'Start'),
          ),
          SizedBox(
            height: 24,
          ),
          Visibility(
            visible: reset == false,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 32),
                  minimumSize: Size(110, 50),
                ),
                onPressed: () {
                  setState(() {
                    _stopwatch.stop();
                    reset = true;
                    handleStartStop();
                  });
                },
                child: Text('Reset')),
          )
        ],
      ),
    );
  }

  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  void handleStartStop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else if (!_stopwatch.isRunning && reset == true) {
      _stopwatch.reset();
    } else {
      _stopwatch.start();
    }
    setState(() {}); // re-render the page
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
