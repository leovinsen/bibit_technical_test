import 'package:alarm/alarm.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'alarm_history_state.dart';

/// Cubit used for retrieving alarm history.
class AlarmHistoryCubit extends Cubit<AlarmHistoryState> {
  AlarmHistoryCubit(this._alarmRepository) : super(const AlarmHistoryInitial());

  final AlarmRepository _alarmRepository;

  Future<void> fetchAlarms() async {
    emit(const AlarmHistoryLoading());
    try {
      // fetch only alarms that has been opened
      final alarms = await _alarmRepository.getAlarms()
        ..where((al) => al.secondElapsed != null);

      emit(AlarmHistoryLoaded(alarms));
    } catch (e) {
      emit(AlarmHistoryError(e.toString()));
    }
  }
}
