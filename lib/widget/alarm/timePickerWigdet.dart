import 'package:clock_app/sql/alarm_helper.dart';
import 'package:clock_app/main.dart';
import 'package:clock_app/model/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class TimePickerWidget extends StatelessWidget {
  DateTime _alarmTime;
  String _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Function loadAlarms;
  TimePickerWidget(this.loadAlarms);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      onPressed: () {
        _alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
        showModalBottomSheet<dynamic>(
          isScrollControlled: true,
          useRootNavigator: true,
          context: context,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          builder: (context) => StatefulBuilder(
            builder: (context, setModalState) => Wrap(children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () async {
                          var selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (selectedTime != null) {
                            final now = DateTime.now();
                            var selectedDateTime = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                selectedTime.hour,
                                selectedTime.minute);
                            _alarmTime = selectedDateTime;
                            setModalState(() {
                              _alarmTimeString =
                                  DateFormat('HH:mm').format(selectedDateTime);
                            });
                          }
                        },
                        child: Text(
                          _alarmTimeString,
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                      FloatingActionButton.extended(
                        onPressed: () {
                          onSaveAlarm(context);
                        },
                        icon: Icon(Icons.alarm),
                        label: Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      },
      child: Column(
        children: [
          Image.asset(
            'assets/add_alarm.png',
            scale: 1.5,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Add alarm',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'avenir',
            ),
          ),
        ],
      ),
    );
  }

  void onSaveAlarm(BuildContext context) {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime == null) {
      return;
    }
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      title: 'alarm',
      isPending: 'true',
    );
    _alarmHelper.insertAlarm(alarmInfo);

    scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Navigator.pop(context);
    loadAlarms();
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    if (alarmInfo.isPending == 'true') {
      await flutterLocalNotificationsPlugin.schedule(
        0,
        'Office',
        alarmInfo.title,
        scheduledNotificationDateTime,
        platformChannelSpecifics,
      );
    }
  }
}
