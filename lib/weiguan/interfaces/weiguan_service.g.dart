// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weiguan_service.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $WgResponse {
  String get code;
  String get message;
  Map<String, dynamic> get data;
  const $WgResponse();
  WgResponse copyWith(
          {String code, String message, Map<String, dynamic> data}) =>
      WgResponse(
          code: code ?? this.code,
          message: message ?? this.message,
          data: data ?? this.data);
  String toString() =>
      "WgResponse(code: $code, message: $message, data: $data)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      code == other.code &&
      message == other.message &&
      data == other.data;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + code.hashCode;
    result = 37 * result + message.hashCode;
    result = 37 * result + data.hashCode;
    return result;
  }
}

class WgResponse$ {
  static final code = Lens<WgResponse, String>(
      (s_) => s_.code, (s_, code) => s_.copyWith(code: code));
  static final message = Lens<WgResponse, String>(
      (s_) => s_.message, (s_, message) => s_.copyWith(message: message));
  static final data = Lens<WgResponse, Map<String, dynamic>>(
      (s_) => s_.data, (s_, data) => s_.copyWith(data: data));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WgResponse _$WgResponseFromJson(Map<String, dynamic> json) {
  return WgResponse(
    code: json['code'] as String,
    message: json['message'] as String,
    data: json['data'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$WgResponseToJson(WgResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
