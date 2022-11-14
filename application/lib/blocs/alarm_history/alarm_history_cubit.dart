import 'package:alarm/alarm.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'alarm_history_state.dart';

/// Cubit used for retrieving alarm history.
class AlarmHistoryCubit extends Cubit<AlarmHistoryState> {
  AlarmHistoryCubit(this._alarmRepository) : super(const AlarmHistoryInitial());

  final AlarmRepository _alarmRepository;

  /// Retrieves all alarm metadata history.
  /// Only alarms that have been opened will be accounted for.
  Future<void> fetchAlarms() async {
    emit(const AlarmHistoryLoading());
    try {
      final alarms = await _alarmRepository.getAlarms();

      emit(AlarmHistoryLoaded(alarms));
    } catch (e) {
      emit(AlarmHistoryError(e.toString()));
    }
  }

  /// Clears all alarm metadata history.
  Future<void> clearHistory() async {
    emit(const AlarmHistoryLoading());

    try {
      await _alarmRepository.clearAlarms();

      fetchAlarms();
    } catch (e) {
      emit(AlarmHistoryError(e.toString()));
    }
  }
}
