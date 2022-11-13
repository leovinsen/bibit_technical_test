// Required for code generator
// ignore: unused_import
import 'dart:async';

import 'package:alarm/src/persistence/alarm_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'alarm_model.dart';
import 'date_time_converter.dart';

part 'app_database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [AlarmModel])
abstract class AppDatabase extends FloorDatabase {
  AlarmDao get alarmDao;
}
