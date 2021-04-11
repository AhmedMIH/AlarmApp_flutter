import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DigitalClockWidet extends StatefulWidget {
  @override
  _DigitalClockWidetState createState() => _DigitalClockWidetState();
}

class _DigitalClockWidetState extends State<DigitalClockWidet> {
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        var previousMin = DateTime.now().add(Duration(seconds: -1)).minute;
        var currentMin = DateTime.now().minute;
        if (previousMin != currentMin) {
          setState(() {
            formattedTime = DateFormat('HH:mm').format(DateTime.now());
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedTime,
      style: TextStyle(
        color: Colors.white,
        fontSize: 64,
      ),
    );
  }
}
