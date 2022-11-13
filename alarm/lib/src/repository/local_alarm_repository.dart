import 'package:flutter/foundation.dart';
import 'package:notification/notification.dart';
import 'package:timezone/timezone.dart' as tz;

import '../persistence/persistence.dart';
import 'alarm_repository.dart';

/// an [AlarmRepository] that uses local storage (SQLite) for managing
/// alarm metadata.
class LocalAlarmRepository implements AlarmRepository {
  LocalAlarmRepository(this._alarmDao, this._notificationService);

  final AlarmDao _alarmDao;
  final NotificationService _notificationService;

  /// Returns all alarms in the database sorted from the most recently created.
  ///
  /// Returns an empty list if an exception occured.
  @override
  Future<List<AlarmModel>> getAlarms() async {
    try {
      return _alarmDao.getAlarms();
    } catch (e) {
      // Normally we should handle this properly, but skipping for simplicity.
      debugPrint(e.toString());
      return [];
    }
  }

  /// Schedules an alarm at given [time] and creates a new record through
  /// [AlarmDao.insertAlarm].
  ///
  /// Returns [true] when operation is successful or [false] when
  /// an exception occured or if the number of inserted records is equal to 0.
  @override
  Future<bool> scheduleAlarm(DateTime time) async {
    try {
      // first, insert the record
      final alarm = AlarmModel(scheduledFor: time.toLocal());
      final insertedId = await _alarmDao.insertAlarm(alarm);

      // if the insertion failed, the notification will not be scheduled.
      // so at this point, once we are sure insertion was successful,
      // we schedule the notification.
      _notificationService.scheduleNotification(
        insertedId,
        'Alarm',
        'Tap on the notification to dismiss!',
        tz.TZDateTime.from(time, tz.local),
        insertedId.toString(),
      );

      return true;
    } catch (e) {
      // Normally we should handle this properly, but skipping for simplicity.
      debugPrint(e.toString());
      return false;
    }
  }

  /// Marks an alarm as opened. Will automatically calculate seconds elapsed
  /// from time of creation to current time i.e. [DateTime.now].
  ///
  /// [alarmId] is the unique identifier of the alarm to be updated.
  ///
  /// Returns [true] when operation is successful or [false] otherwise.
  @override
  Future<bool> markOpened(int alarmId) async {
    try {
      // first, validate that the record exists
      final found = await _alarmDao.findAlarmById(alarmId);
      if (found == null) {
        // normally we should throw a custom exception, but skipping for simplicity.
        return false;
      }

      // difference between time of alarm creation and current time
      final difference = found.scheduledFor.difference(DateTime.now());

      // then, we update the record in the database
      final updateRecord = AlarmModel(
        id: found.id,
        scheduledFor: found.scheduledFor,
        secondElapsed: difference.inSeconds,
      );
      final res = await _alarmDao.updateAlarm(updateRecord);

      return res > 0;
    } catch (e) {
      // Normally we should handle this properly, but skipping for simplicity.
      debugPrint(e.toString());
      return false;
    }
  }
}
