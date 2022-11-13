import 'package:floor/floor.dart';

/// SQLite does not support [DateTime] type natively.
///
/// So instead it will be stored as INT type in SQLite,
/// but serialized and deserialized into [DateTime] when
/// used in our Dart code.
class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}
