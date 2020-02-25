// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth2.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $OAuth2State {
  String get accessToken;
  DateTime get accessTokenExpireAt;
  String get refreshToken;
  const $OAuth2State();
  OAuth2State copyWith(
          {String accessToken,
          DateTime accessTokenExpireAt,
          String refreshToken}) =>
      OAuth2State(
          accessToken: accessToken ?? this.accessToken,
          accessTokenExpireAt: accessTokenExpireAt ?? this.accessTokenExpireAt,
          refreshToken: refreshToken ?? this.refreshToken);
  String toString() =>
      "OAuth2State(accessToken: $accessToken, accessTokenExpireAt: $accessTokenExpireAt, refreshToken: $refreshToken)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      accessToken == other.accessToken &&
      accessTokenExpireAt == other.accessTokenExpireAt &&
      refreshToken == other.refreshToken;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + accessToken.hashCode;
    result = 37 * result + accessTokenExpireAt.hashCode;
    result = 37 * result + refreshToken.hashCode;
    return result;
  }
}

class OAuth2State$ {
  static final accessToken = Lens<OAuth2State, String>((s_) => s_.accessToken,
      (s_, accessToken) => s_.copyWith(accessToken: accessToken));
  static final accessTokenExpireAt = Lens<OAuth2State, DateTime>(
      (s_) => s_.accessTokenExpireAt,
      (s_, accessTokenExpireAt) =>
          s_.copyWith(accessTokenExpireAt: accessTokenExpireAt));
  static final refreshToken = Lens<OAuth2State, String>((s_) => s_.refreshToken,
      (s_, refreshToken) => s_.copyWith(refreshToken: refreshToken));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuth2State _$OAuth2StateFromJson(Map<String, dynamic> json) {
  return OAuth2State(
    accessToken: json['accessToken'] as String,
    accessTokenExpireAt: json['accessTokenExpireAt'] == null
        ? null
        : DateTime.parse(json['accessTokenExpireAt'] as String),
    refreshToken: json['refreshToken'] as String,
  );
}

Map<String, dynamic> _$OAuth2StateToJson(OAuth2State instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'accessTokenExpireAt': instance.accessTokenExpireAt?.toIso8601String(),
      'refreshToken': instance.refreshToken,
    };
