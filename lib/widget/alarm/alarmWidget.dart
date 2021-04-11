import 'package:clock_app/constants.dart';
import 'package:clock_app/model/alarm_info.dart';
import 'package:clock_app/widget/alarm/alarmItemWiget.dart';
import 'package:clock_app/widget/alarm/timePickerWigdet.dart';
import 'package:flutter/material.dart';

import '../../sql/alarm_helper.dart';

class AlarmWidget extends StatefulWidget {
  @override
  _AlarmWidgetState createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends State<AlarmWidget> {
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>> _alarms;
  List<AlarmInfo> _currentAlarms;

  @override
  void initState() {
    _alarmHelper.initializeDatabase().then((value) {
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarm',
            style: TextStyle(
              fontSize: 32,
              fontFamily: 'anvenir',
              fontWeight: FontWeight.w700,
              color: primaryTextColor,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<AlarmInfo>>(
                future: _alarms,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _currentAlarms = snapshot.data;
                    return ListView(
                      children: _currentAlarms.map((alarm) {
                        //   print(alarm.isPending);
                        return Container(
                          child:
                              AlarmItemWidget(alarm, _alarmHelper, loadAlarms),
                        );
                      }).followedBy([
                        Container(
                          decoration: BoxDecoration(
                            color: clockBG,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          child: TimePickerWidget(loadAlarms),
                        )
                      ]).toList(),
                    );
                  } else {
                    return Container();
                  }
                }),
          )
        ],
      ),
    );
  }
}
