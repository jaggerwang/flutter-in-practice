// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $FileEntity {
  int get id;
  int get userId;
  String get region;
  String get bucket;
  String get path;
  FileMetaEntity get meta;
  String get url;
  Map<FileThumbType, String> get thumbs;
  DateTime get createdAt;
  DateTime get updatedAt;
  const $FileEntity();
  FileEntity copyWith(
          {int id,
          int userId,
          String region,
          String bucket,
          String path,
          FileMetaEntity meta,
          String url,
          Map<FileThumbType, String> thumbs,
          DateTime createdAt,
          DateTime updatedAt}) =>
      FileEntity(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          region: region ?? this.region,
          bucket: bucket ?? this.bucket,
          path: path ?? this.path,
          meta: meta ?? this.meta,
          url: url ?? this.url,
          thumbs: thumbs ?? this.thumbs,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt);
  String toString() =>
      "FileEntity(id: $id, userId: $userId, region: $region, bucket: $bucket, path: $path, meta: $meta, url: $url, thumbs: $thumbs, createdAt: $createdAt, updatedAt: $updatedAt)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      userId == other.userId &&
      region == other.region &&
      bucket == other.bucket &&
      path == other.path &&
      meta == other.meta &&
      url == other.url &&
      thumbs == other.thumbs &&
      createdAt == other.createdAt &&
      updatedAt == other.updatedAt;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + userId.hashCode;
    result = 37 * result + region.hashCode;
    result = 37 * result + bucket.hashCode;
    result = 37 * result + path.hashCode;
    result = 37 * result + meta.hashCode;
    result = 37 * result + url.hashCode;
    result = 37 * result + thumbs.hashCode;
    result = 37 * result + createdAt.hashCode;
    result = 37 * result + updatedAt.hashCode;
    return result;
  }
}

class FileEntity$ {
  static final id =
      Lens<FileEntity, int>((s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final userId = Lens<FileEntity, int>(
      (s_) => s_.userId, (s_, userId) => s_.copyWith(userId: userId));
  static final region = Lens<FileEntity, String>(
      (s_) => s_.region, (s_, region) => s_.copyWith(region: region));
  static final bucket = Lens<FileEntity, String>(
      (s_) => s_.bucket, (s_, bucket) => s_.copyWith(bucket: bucket));
  static final path = Lens<FileEntity, String>(
      (s_) => s_.path, (s_, path) => s_.copyWith(path: path));
  static final meta = Lens<FileEntity, FileMetaEntity>(
      (s_) => s_.meta, (s_, meta) => s_.copyWith(meta: meta));
  static final url = Lens<FileEntity, String>(
      (s_) => s_.url, (s_, url) => s_.copyWith(url: url));
  static final thumbs = Lens<FileEntity, Map<FileThumbType, String>>(
      (s_) => s_.thumbs, (s_, thumbs) => s_.copyWith(thumbs: thumbs));
  static final createdAt = Lens<FileEntity, DateTime>((s_) => s_.createdAt,
      (s_, createdAt) => s_.copyWith(createdAt: createdAt));
  static final updatedAt = Lens<FileEntity, DateTime>((s_) => s_.updatedAt,
      (s_, updatedAt) => s_.copyWith(updatedAt: updatedAt));
}

abstract class $FileMetaEntity {
  String get name;
  int get size;
  String get type;
  int get width;
  int get height;
  int get duration;
  const $FileMetaEntity();
  FileMetaEntity copyWith(
          {String name,
          int size,
          String type,
          int width,
          int height,
          int duration}) =>
      FileMetaEntity(
          name: name ?? this.name,
          size: size ?? this.size,
          type: type ?? this.type,
          width: width ?? this.width,
          height: height ?? this.height,
          duration: duration ?? this.duration);
  String toString() =>
      "FileMetaEntity(name: $name, size: $size, type: $type, width: $width, height: $height, duration: $duration)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      name == other.name &&
      size == other.size &&
      type == other.type &&
      width == other.width &&
      height == other.height &&
      duration == other.duration;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + name.hashCode;
    result = 37 * result + size.hashCode;
    result = 37 * result + type.hashCode;
    result = 37 * result + width.hashCode;
    result = 37 * result + height.hashCode;
    result = 37 * result + duration.hashCode;
    return result;
  }
}

class FileMetaEntity$ {
  static final name = Lens<FileMetaEntity, String>(
      (s_) => s_.name, (s_, name) => s_.copyWith(name: name));
  static final size = Lens<FileMetaEntity, int>(
      (s_) => s_.size, (s_, size) => s_.copyWith(size: size));
  static final type = Lens<FileMetaEntity, String>(
      (s_) => s_.type, (s_, type) => s_.copyWith(type: type));
  static final width = Lens<FileMetaEntity, int>(
      (s_) => s_.width, (s_, width) => s_.copyWith(width: width));
  static final height = Lens<FileMetaEntity, int>(
      (s_) => s_.height, (s_, height) => s_.copyWith(height: height));
  static final duration = Lens<FileMetaEntity, int>(
      (s_) => s_.duration, (s_, duration) => s_.copyWith(duration: duration));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileEntity _$FileEntityFromJson(Map<String, dynamic> json) {
  return FileEntity(
    id: json['id'] as int,
    userId: json['userId'] as int,
    region: json['region'] as String,
    bucket: json['bucket'] as String,
    path: json['path'] as String,
    meta: json['meta'] == null
        ? null
        : FileMetaEntity.fromJson(json['meta'] as Map<String, dynamic>),
    url: json['url'] as String,
    thumbs: (json['thumbs'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          _$enumDecodeNullable(_$FileThumbTypeEnumMap, k), e as String),
    ),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$FileEntityToJson(FileEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'region': instance.region,
      'bucket': instance.bucket,
      'path': instance.path,
      'meta': instance.meta,
      'url': instance.url,
      'thumbs': instance.thumbs
          ?.map((k, e) => MapEntry(_$FileThumbTypeEnumMap[k], e)),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
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

const _$FileThumbTypeEnumMap = {
  FileThumbType.small: 'small',
  FileThumbType.middle: 'middle',
  FileThumbType.large: 'large',
  FileThumbType.huge: 'huge',
};

FileMetaEntity _$FileMetaEntityFromJson(Map<String, dynamic> json) {
  return FileMetaEntity(
    name: json['name'] as String,
    size: json['size'] as int,
    type: json['type'] as String,
    width: json['width'] as int ?? 0,
    height: json['height'] as int ?? 0,
    duration: json['duration'] as int ?? 0,
  );
}

Map<String, dynamic> _$FileMetaEntityToJson(FileMetaEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'size': instance.size,
      'type': instance.type,
      'width': instance.width,
      'height': instance.height,
      'duration': instance.duration,
    };
