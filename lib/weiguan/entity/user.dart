import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

import 'entity.dart';

part 'user.g.dart';

@JsonSerializable()
@FunctionalData()
class UserEntity extends $UserEntity {
  final int id;
  final String username;
  final String password;
  final String mobile;
  final String email;
  final int avatarId;
  final String intro;
  final DateTime createdAt;
  final DateTime updatedAt;
  final FileEntity avatar;
  final UserStatEntity stat;
  @JsonKey(defaultValue: false)
  final bool following;

  const UserEntity({
    this.id,
    this.username,
    this.password,
    this.mobile,
    this.email,
    this.avatarId,
    this.intro,
    this.createdAt,
    this.updatedAt,
    this.avatar,
    this.stat,
    this.following,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
