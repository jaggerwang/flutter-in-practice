// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $UserEntity {
  int get id;
  String get username;
  String get password;
  String get mobile;
  String get email;
  int get avatarId;
  String get intro;
  DateTime get createdAt;
  DateTime get updatedAt;
  FileEntity get avatar;
  UserStatEntity get stat;
  bool get isFollowing;
  const $UserEntity();
  UserEntity copyWith(
          {int id,
          String username,
          String password,
          String mobile,
          String email,
          int avatarId,
          String intro,
          DateTime createdAt,
          DateTime updatedAt,
          FileEntity avatar,
          UserStatEntity stat,
          bool isFollowing}) =>
      UserEntity(
          id: id ?? this.id,
          username: username ?? this.username,
          password: password ?? this.password,
          mobile: mobile ?? this.mobile,
          email: email ?? this.email,
          avatarId: avatarId ?? this.avatarId,
          intro: intro ?? this.intro,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          avatar: avatar ?? this.avatar,
          stat: stat ?? this.stat,
          isFollowing: isFollowing ?? this.isFollowing);
  String toString() =>
      "UserEntity(id: $id, username: $username, password: $password, mobile: $mobile, email: $email, avatarId: $avatarId, intro: $intro, createdAt: $createdAt, updatedAt: $updatedAt, avatar: $avatar, stat: $stat, isFollowing: $isFollowing)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      username == other.username &&
      password == other.password &&
      mobile == other.mobile &&
      email == other.email &&
      avatarId == other.avatarId &&
      intro == other.intro &&
      createdAt == other.createdAt &&
      updatedAt == other.updatedAt &&
      avatar == other.avatar &&
      stat == other.stat &&
      isFollowing == other.isFollowing;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + username.hashCode;
    result = 37 * result + password.hashCode;
    result = 37 * result + mobile.hashCode;
    result = 37 * result + email.hashCode;
    result = 37 * result + avatarId.hashCode;
    result = 37 * result + intro.hashCode;
    result = 37 * result + createdAt.hashCode;
    result = 37 * result + updatedAt.hashCode;
    result = 37 * result + avatar.hashCode;
    result = 37 * result + stat.hashCode;
    result = 37 * result + isFollowing.hashCode;
    return result;
  }
}

class UserEntity$ {
  static final id =
      Lens<UserEntity, int>((s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final username = Lens<UserEntity, String>(
      (s_) => s_.username, (s_, username) => s_.copyWith(username: username));
  static final password = Lens<UserEntity, String>(
      (s_) => s_.password, (s_, password) => s_.copyWith(password: password));
  static final mobile = Lens<UserEntity, String>(
      (s_) => s_.mobile, (s_, mobile) => s_.copyWith(mobile: mobile));
  static final email = Lens<UserEntity, String>(
      (s_) => s_.email, (s_, email) => s_.copyWith(email: email));
  static final avatarId = Lens<UserEntity, int>(
      (s_) => s_.avatarId, (s_, avatarId) => s_.copyWith(avatarId: avatarId));
  static final intro = Lens<UserEntity, String>(
      (s_) => s_.intro, (s_, intro) => s_.copyWith(intro: intro));
  static final createdAt = Lens<UserEntity, DateTime>((s_) => s_.createdAt,
      (s_, createdAt) => s_.copyWith(createdAt: createdAt));
  static final updatedAt = Lens<UserEntity, DateTime>((s_) => s_.updatedAt,
      (s_, updatedAt) => s_.copyWith(updatedAt: updatedAt));
  static final avatar = Lens<UserEntity, FileEntity>(
      (s_) => s_.avatar, (s_, avatar) => s_.copyWith(avatar: avatar));
  static final stat = Lens<UserEntity, UserStatEntity>(
      (s_) => s_.stat, (s_, stat) => s_.copyWith(stat: stat));
  static final isFollowing = Lens<UserEntity, bool>((s_) => s_.isFollowing,
      (s_, isFollowing) => s_.copyWith(isFollowing: isFollowing));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return UserEntity(
    id: json['id'] as int,
    username: json['username'] as String,
    password: json['password'] as String,
    mobile: json['mobile'] as String,
    email: json['email'] as String,
    avatarId: json['avatarId'] as int,
    intro: json['intro'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    avatar: json['avatar'] == null
        ? null
        : FileEntity.fromJson(json['avatar'] as Map<String, dynamic>),
    stat: json['stat'] == null
        ? null
        : UserStatEntity.fromJson(json['stat'] as Map<String, dynamic>),
    isFollowing: json['isFollowing'] as bool ?? false,
  );
}

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'mobile': instance.mobile,
      'email': instance.email,
      'avatarId': instance.avatarId,
      'intro': instance.intro,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'avatar': instance.avatar,
      'stat': instance.stat,
      'isFollowing': instance.isFollowing,
    };
