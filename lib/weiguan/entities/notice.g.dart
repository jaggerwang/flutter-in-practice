// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $NoticeEntity {
  String get message;
  NoticeLevel get level;
  Duration get duration;
  const $NoticeEntity();
  NoticeEntity copyWith(
          {String message, NoticeLevel level, Duration duration}) =>
      NoticeEntity(
          message: message ?? this.message,
          level: level ?? this.level,
          duration: duration ?? this.duration);
  String toString() =>
      "NoticeEntity(message: $message, level: $level, duration: $duration)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      message == other.message &&
      level == other.level &&
      duration == other.duration;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + message.hashCode;
    result = 37 * result + level.hashCode;
    result = 37 * result + duration.hashCode;
    return result;
  }
}

class NoticeEntity$ {
  static final message = Lens<NoticeEntity, String>(
      (s_) => s_.message, (s_, message) => s_.copyWith(message: message));
  static final level = Lens<NoticeEntity, NoticeLevel>(
      (s_) => s_.level, (s_, level) => s_.copyWith(level: level));
  static final duration = Lens<NoticeEntity, Duration>(
      (s_) => s_.duration, (s_, duration) => s_.copyWith(duration: duration));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeEntity _$NoticeEntityFromJson(Map<String, dynamic> json) {
  return NoticeEntity(
    message: json['message'] as String,
    level: _$enumDecodeNullable(_$NoticeLevelEnumMap, json['level']),
    duration: json['duration'] == null
        ? null
        : Duration(microseconds: json['duration'] as int),
  );
}

Map<String, dynamic> _$NoticeEntityToJson(NoticeEntity instance) =>
    <String, dynamic>{
      'message': instance.message,
      'level': _$NoticeLevelEnumMap[instance.level],
      'duration': instance.duration?.inMicroseconds,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$NoticeLevelEnumMap = {
  NoticeLevel.info: 'info',
  NoticeLevel.warning: 'warning',
  NoticeLevel.error: 'error',
  NoticeLevel.success: 'success',
};
