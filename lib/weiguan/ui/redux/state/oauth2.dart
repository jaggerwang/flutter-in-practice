import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

part 'oauth2.g.dart';

@JsonSerializable()
@FunctionalData()
class OAuth2State extends $OAuth2State {
  final String accessToken;
  final DateTime accessTokenExpireAt;
  final String refreshToken;

  OAuth2State({
    this.accessToken,
    this.accessTokenExpireAt,
    this.refreshToken,
  });

  factory OAuth2State.fromJson(Map<String, dynamic> json) =>
      _$OAuth2StateFromJson(json);

  Map<String, dynamic> toJson() => _$OAuth2StateToJson(this);
}
