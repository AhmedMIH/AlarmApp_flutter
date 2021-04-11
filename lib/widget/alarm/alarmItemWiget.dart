import 'package:clock_app/sql/alarm_helper.dart';
import 'package:clock_app/model/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmItemWidget extends StatelessWidget {
  AlarmHelper _alarmHelper;
  AlarmInfo alarm;
  Function loadAlarms;
  AlarmItemWidget(
    this.alarm,
    this._alarmHelper,
    this.loadAlarms,
  );

  @override
  Widget build(BuildContext context) {
    var alarmTime = DateFormat('hh:mm aa').format(alarm.alarmDateTime);
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.label,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      alarm.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'avenir',
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: convertStringToBool(alarm.isPending),
                  onChanged: (bool value) {
                    var updatedAlarm = alarm;
                    updatedAlarm.isPending = value.toString();
                    _alarmHelper.update(updatedAlarm.id, updatedAlarm);
                    loadAlarms();
                  },
                  activeColor: Colors.white,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  alarmTime,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(
                    Icons.delete,
                    size: 36,
                  ),
                  onPressed: () {
                    _alarmHelper.delete(alarm.id);
                    loadAlarms();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool convertStringToBool(String value) {
    if (value == 'true') {
      return true;
    } else
      return false;
  }
}
