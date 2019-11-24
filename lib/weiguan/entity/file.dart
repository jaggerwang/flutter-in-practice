import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

part 'file.g.dart';

enum FileThumbType { SMALL, MIDDLE, LARGE, HUGE }

@JsonSerializable()
@FunctionalData()
class FileEntity extends $FileEntity {
  final int id;
  final int userId;
  final String region;
  final String bucket;
  final String path;
  final FileMetaEntity meta;
  final String url;
  final Map<FileThumbType, String> thumbs;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FileEntity({
    this.id,
    this.userId,
    this.region,
    this.bucket,
    this.path,
    this.meta,
    this.url,
    this.thumbs,
    this.createdAt,
    this.updatedAt,
  });

  factory FileEntity.fromJson(Map<String, dynamic> json) =>
      _$FileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FileEntityToJson(this);

  double get ratio {
    return meta.width != 0 && meta.height != 0
        ? meta.width / meta.height
        : 16 / 9;
  }
}

@JsonSerializable()
@FunctionalData()
class FileMetaEntity extends $FileMetaEntity {
  final String name;
  final int size;
  final String type;
  @JsonKey(defaultValue: 0)
  final int width;
  @JsonKey(defaultValue: 0)
  final int height;
  @JsonKey(defaultValue: 0)
  final int duration;

  const FileMetaEntity({
    this.name,
    this.size,
    this.type,
    this.width,
    this.height,
    this.duration,
  });

  factory FileMetaEntity.fromJson(Map<String, dynamic> json) =>
      _$FileMetaEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FileMetaEntityToJson(this);
}
