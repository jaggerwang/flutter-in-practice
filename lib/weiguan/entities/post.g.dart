// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $PostEntity {
  int get id;
  int get userId;
  PostType get type;
  String get text;
  List<int> get imageIds;
  int get videoId;
  DateTime get createdAt;
  DateTime get updatedAt;
  UserEntity get user;
  List<FileEntity> get images;
  FileEntity get video;
  PostStatEntity get stat;
  bool get isLiked;
  const $PostEntity();
  PostEntity copyWith(
          {int id,
          int userId,
          PostType type,
          String text,
          List<int> imageIds,
          int videoId,
          DateTime createdAt,
          DateTime updatedAt,
          UserEntity user,
          List<FileEntity> images,
          FileEntity video,
          PostStatEntity stat,
          bool isLiked}) =>
      PostEntity(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          type: type ?? this.type,
          text: text ?? this.text,
          imageIds: imageIds ?? this.imageIds,
          videoId: videoId ?? this.videoId,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          user: user ?? this.user,
          images: images ?? this.images,
          video: video ?? this.video,
          stat: stat ?? this.stat,
          isLiked: isLiked ?? this.isLiked);
  String toString() =>
      "PostEntity(id: $id, userId: $userId, type: $type, text: $text, imageIds: $imageIds, videoId: $videoId, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, images: $images, video: $video, stat: $stat, isLiked: $isLiked)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      userId == other.userId &&
      type == other.type &&
      text == other.text &&
      imageIds == other.imageIds &&
      videoId == other.videoId &&
      createdAt == other.createdAt &&
      updatedAt == other.updatedAt &&
      user == other.user &&
      images == other.images &&
      video == other.video &&
      stat == other.stat &&
      isLiked == other.isLiked;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + userId.hashCode;
    result = 37 * result + type.hashCode;
    result = 37 * result + text.hashCode;
    result = 37 * result + imageIds.hashCode;
    result = 37 * result + videoId.hashCode;
    result = 37 * result + createdAt.hashCode;
    result = 37 * result + updatedAt.hashCode;
    result = 37 * result + user.hashCode;
    result = 37 * result + images.hashCode;
    result = 37 * result + video.hashCode;
    result = 37 * result + stat.hashCode;
    result = 37 * result + isLiked.hashCode;
    return result;
  }
}

class PostEntity$ {
  static final id =
      Lens<PostEntity, int>((s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final userId = Lens<PostEntity, int>(
      (s_) => s_.userId, (s_, userId) => s_.copyWith(userId: userId));
  static final type = Lens<PostEntity, PostType>(
      (s_) => s_.type, (s_, type) => s_.copyWith(type: type));
  static final text = Lens<PostEntity, String>(
      (s_) => s_.text, (s_, text) => s_.copyWith(text: text));
  static final imageIds = Lens<PostEntity, List<int>>(
      (s_) => s_.imageIds, (s_, imageIds) => s_.copyWith(imageIds: imageIds));
  static final videoId = Lens<PostEntity, int>(
      (s_) => s_.videoId, (s_, videoId) => s_.copyWith(videoId: videoId));
  static final createdAt = Lens<PostEntity, DateTime>((s_) => s_.createdAt,
      (s_, createdAt) => s_.copyWith(createdAt: createdAt));
  static final updatedAt = Lens<PostEntity, DateTime>((s_) => s_.updatedAt,
      (s_, updatedAt) => s_.copyWith(updatedAt: updatedAt));
  static final user = Lens<PostEntity, UserEntity>(
      (s_) => s_.user, (s_, user) => s_.copyWith(user: user));
  static final images = Lens<PostEntity, List<FileEntity>>(
      (s_) => s_.images, (s_, images) => s_.copyWith(images: images));
  static final video = Lens<PostEntity, FileEntity>(
      (s_) => s_.video, (s_, video) => s_.copyWith(video: video));
  static final stat = Lens<PostEntity, PostStatEntity>(
      (s_) => s_.stat, (s_, stat) => s_.copyWith(stat: stat));
  static final isLiked = Lens<PostEntity, bool>(
      (s_) => s_.isLiked, (s_, isLiked) => s_.copyWith(isLiked: isLiked));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostEntity _$PostEntityFromJson(Map<String, dynamic> json) {
  return PostEntity(
    id: json['id'] as int,
    userId: json['userId'] as int,
    type: _$enumDecodeNullable(_$PostTypeEnumMap, json['type']),
    text: json['text'] as String,
    imageIds: (json['imageIds'] as List)?.map((e) => e as int)?.toList(),
    videoId: json['videoId'] as int,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    user: json['user'] == null
        ? null
        : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    images: (json['images'] as List)
        ?.map((e) =>
            e == null ? null : FileEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    video: json['video'] == null
        ? null
        : FileEntity.fromJson(json['video'] as Map<String, dynamic>),
    stat: json['stat'] == null
        ? null
        : PostStatEntity.fromJson(json['stat'] as Map<String, dynamic>),
    isLiked: json['isLiked'] as bool ?? false,
  );
}

Map<String, dynamic> _$PostEntityToJson(PostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$PostTypeEnumMap[instance.type],
      'text': instance.text,
      'imageIds': instance.imageIds,
      'videoId': instance.videoId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'user': instance.user,
      'images': instance.images,
      'video': instance.video,
      'stat': instance.stat,
      'isLiked': instance.isLiked,
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

const _$PostTypeEnumMap = {
  PostType.text: 'text',
  PostType.image: 'image',
  PostType.video: 'video',
};
