import 'package:clock_app/data.dart';
import 'package:clock_app/model/menu_type.dart';
import 'package:clock_app/model/menu_info.dart';
import 'package:clock_app/widget/alarm/alarmWidget.dart';
import 'package:clock_app/widget/timer/durationPickerWidget.dart';
import 'package:clock_app/widget/stopwatch/stopwatchWidget.dart';
import 'package:clock_app/widget/clock/ClockWidget.dart';
import 'package:clock_app/widget/custome_menuButton.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202F41),
      body: Row(
        children: [
          SizedBox(
            width: 4,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((menuInfo) => cutomeMenuButton(menuInfo))
                .toList(),
          ),
          SizedBox(
            width: 4,
          ),
          VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              // ignore: missing_return
              builder: (context, value, child) {
                switch (value.menuType) {
                  case MenuType.clock:
                    return ClockWidget();
                    break;
                  case MenuType.alarm:
                    return AlarmWidget();
                    break;
                  case MenuType.timer:
                    return DurationPickerWidget();
                    break;
                  case MenuType.stopwatch:
                    return StopWatchWidget();
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
