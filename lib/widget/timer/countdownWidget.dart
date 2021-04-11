import 'package:clock_app/constants.dart';
import 'package:flutter/material.dart';
import 'customCountdownPainter.dart';

class CountdownWidget extends StatefulWidget {
  Duration duration;
  CountdownWidget(this.duration);
  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      controller = AnimationController(
        vsync: this,
        duration: widget.duration,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: CustomCountdownPainter(
                                    animation: controller,
                                    backgroundColor: Colors.white,
                                    color: Colors.red),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Count Down Timer",
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              AnimatedBuilder(
                                  animation: controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Text(
                                      timerString,
                                      style: TextStyle(
                                          fontSize: 112.0, color: Colors.white),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return FloatingActionButton.extended(
                      onPressed: () {
                        if (controller.isAnimating)
                          controller.stop();
                        else {
                          controller.reverse(
                              from: controller.value == 0.0
                                  ? 1.0
                                  : controller.value);
                        }
                        setState(() {});
                      },
                      icon: Icon(controller.isAnimating
                          ? Icons.pause
                          : Icons.play_arrow),
                      label: Text(controller.isAnimating ? "Pause" : "Play"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}
