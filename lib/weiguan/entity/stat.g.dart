// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $UserStatEntity {
  int get id;
  int get userId;
  int get postCount;
  int get likeCount;
  int get followingCount;
  int get followerCount;
  DateTime get createdAt;
  DateTime get updatedAt;
  const $UserStatEntity();
  UserStatEntity copyWith(
          {int id,
          int userId,
          int postCount,
          int likeCount,
          int followingCount,
          int followerCount,
          DateTime createdAt,
          DateTime updatedAt}) =>
      UserStatEntity(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          postCount: postCount ?? this.postCount,
          likeCount: likeCount ?? this.likeCount,
          followingCount: followingCount ?? this.followingCount,
          followerCount: followerCount ?? this.followerCount,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt);
  String toString() =>
      "UserStatEntity(id: $id, userId: $userId, postCount: $postCount, likeCount: $likeCount, followingCount: $followingCount, followerCount: $followerCount, createdAt: $createdAt, updatedAt: $updatedAt)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      userId == other.userId &&
      postCount == other.postCount &&
      likeCount == other.likeCount &&
      followingCount == other.followingCount &&
      followerCount == other.followerCount &&
      createdAt == other.createdAt &&
      updatedAt == other.updatedAt;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + userId.hashCode;
    result = 37 * result + postCount.hashCode;
    result = 37 * result + likeCount.hashCode;
    result = 37 * result + followingCount.hashCode;
    result = 37 * result + followerCount.hashCode;
    result = 37 * result + createdAt.hashCode;
    result = 37 * result + updatedAt.hashCode;
    return result;
  }
}

class UserStatEntity$ {
  static final id =
      Lens<UserStatEntity, int>((s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final userId = Lens<UserStatEntity, int>(
      (s_) => s_.userId, (s_, userId) => s_.copyWith(userId: userId));
  static final postCount = Lens<UserStatEntity, int>((s_) => s_.postCount,
      (s_, postCount) => s_.copyWith(postCount: postCount));
  static final likeCount = Lens<UserStatEntity, int>((s_) => s_.likeCount,
      (s_, likeCount) => s_.copyWith(likeCount: likeCount));
  static final followingCount = Lens<UserStatEntity, int>(
      (s_) => s_.followingCount,
      (s_, followingCount) => s_.copyWith(followingCount: followingCount));
  static final followerCount = Lens<UserStatEntity, int>(
      (s_) => s_.followerCount,
      (s_, followerCount) => s_.copyWith(followerCount: followerCount));
  static final createdAt = Lens<UserStatEntity, DateTime>((s_) => s_.createdAt,
      (s_, createdAt) => s_.copyWith(createdAt: createdAt));
  static final updatedAt = Lens<UserStatEntity, DateTime>((s_) => s_.updatedAt,
      (s_, updatedAt) => s_.copyWith(updatedAt: updatedAt));
}

abstract class $PostStatEntity {
  int get id;
  int get postId;
  int get likeCount;
  DateTime get createdAt;
  DateTime get updatedAt;
  const $PostStatEntity();
  PostStatEntity copyWith(
          {int id,
          int postId,
          int likeCount,
          DateTime createdAt,
          DateTime updatedAt}) =>
      PostStatEntity(
          id: id ?? this.id,
          postId: postId ?? this.postId,
          likeCount: likeCount ?? this.likeCount,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt);
  String toString() =>
      "PostStatEntity(id: $id, postId: $postId, likeCount: $likeCount, createdAt: $createdAt, updatedAt: $updatedAt)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      postId == other.postId &&
      likeCount == other.likeCount &&
      createdAt == other.createdAt &&
      updatedAt == other.updatedAt;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + postId.hashCode;
    result = 37 * result + likeCount.hashCode;
    result = 37 * result + createdAt.hashCode;
    result = 37 * result + updatedAt.hashCode;
    return result;
  }
}

class PostStatEntity$ {
  static final id =
      Lens<PostStatEntity, int>((s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final postId = Lens<PostStatEntity, int>(
      (s_) => s_.postId, (s_, postId) => s_.copyWith(postId: postId));
  static final likeCount = Lens<PostStatEntity, int>((s_) => s_.likeCount,
      (s_, likeCount) => s_.copyWith(likeCount: likeCount));
  static final createdAt = Lens<PostStatEntity, DateTime>((s_) => s_.createdAt,
      (s_, createdAt) => s_.copyWith(createdAt: createdAt));
  static final updatedAt = Lens<PostStatEntity, DateTime>((s_) => s_.updatedAt,
      (s_, updatedAt) => s_.copyWith(updatedAt: updatedAt));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatEntity _$UserStatEntityFromJson(Map<String, dynamic> json) {
  return UserStatEntity(
    id: json['id'] as int,
    userId: json['userId'] as int,
    postCount: json['postCount'] as int,
    likeCount: json['likeCount'] as int,
    followingCount: json['followingCount'] as int,
    followerCount: json['followerCount'] as int,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$UserStatEntityToJson(UserStatEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'postCount': instance.postCount,
      'likeCount': instance.likeCount,
      'followingCount': instance.followingCount,
      'followerCount': instance.followerCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

PostStatEntity _$PostStatEntityFromJson(Map<String, dynamic> json) {
  return PostStatEntity(
    id: json['id'] as int,
    postId: json['postId'] as int,
    likeCount: json['likeCount'] as int,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$PostStatEntityToJson(PostStatEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'likeCount': instance.likeCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
