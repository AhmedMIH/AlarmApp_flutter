import 'package:clock_app/constants.dart';
import 'package:clock_app/model/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

class AlarmHelper {
  static Database _database;
  static AlarmHelper _alarmHelper;

  AlarmHelper._createInstance();

  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + 'alarm.db';

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        create table $tableAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnColorIndex integer)
        ''');
      },
    );

    return database;
  }

  Future<void> insertAlarm(AlarmInfo alarmInfo) async {
    try {
      var db = await this.database;
      await db.insert(tableAlarm, alarmInfo.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(int id, AlarmInfo alarmInfo) async {
    var db = await this.database;
    return await db.update(tableAlarm, alarmInfo.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }
}
