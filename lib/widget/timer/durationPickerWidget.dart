import 'package:clock_app/widget/timer/countdownWidget.dart';
import 'package:flutter/material.dart';
import 'package:duration_picker/duration_picker.dart';

class DurationPickerWidget extends StatefulWidget {
  @override
  _DurationPickerWidgetState createState() => _DurationPickerWidgetState();
}

class _DurationPickerWidgetState extends State<DurationPickerWidget> {
  Duration duration = Duration(hours: 0, minutes: 0, seconds: 0);
  bool start = false;

  @override
  Widget build(BuildContext context) {
    if (start == false) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DurationPicker(
              duration: duration,
              onChange: (val) {
                this.setState(() => duration = val);
              },
              snapToMins: 5,
            ),
            ElevatedButton(
              onPressed: () {
                if (duration == Duration(hours: 0, minutes: 0, seconds: 0)) {
                  return ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('plase choose duration'),
                    ),
                  );
                } else {
                  setState(() {
                    start = true;
                  });
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CountdownWidget(duration),
                    ),
                  );*/
                }
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 32),
                minimumSize: Size(110, 50),
              ),
              child: Text('start'),
            ),
          ],
        ),
      );
    } else {
      return CountdownWidget(duration);
    }
  }
}
