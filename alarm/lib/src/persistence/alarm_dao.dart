import 'package:floor/floor.dart';

import 'alarm_model.dart';

/// Data Access Object for interacting with `alarms` table.
@dao
abstract class AlarmDao {
  /// Returns a record identified by [id] in the database.
  /// When not found, returns a [null].
  @Query('SELECT * FROM `alarms` WHERE `id` = :id')
  Future<AlarmModel?> findAlarmById(int id);

  /// Returns all alarms in the database, ordered by `scheduled_for` column descending.
  ///
  /// set [pageSize] to determine the amount of records fetched in a single query.
  @Query('SELECT * FROM `alarms` ORDER BY `scheduled_for` DESC LIMIT :pageSize')
  Future<List<AlarmModel>> getAlarms(int pageSize);

  /// Inserts a new alarm record into the database.
  /// Returns the ID of the inserted record.
  @insert
  Future<int> insertAlarm(AlarmModel alarm);

  /// Updates an alarm record in the database.
  /// Returns the number of records updated by this operation.
  @update
  Future<int> updateAlarm(AlarmModel alarm);
}
