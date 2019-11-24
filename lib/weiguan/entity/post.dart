import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

import 'entity.dart';

part 'post.g.dart';

enum PostType { TEXT, IMAGE, VIDEO }

enum PostListType { FOLLOWING, HOT }

@JsonSerializable()
@FunctionalData()
class PostEntity extends $PostEntity {
  static final typeNames = {
    PostType.TEXT: '文字',
    PostType.IMAGE: '图片',
    PostType.VIDEO: '视频',
  };

  final int id;
  final int userId;
  final PostType type;
  final String text;
  final List<int> imageIds;
  final int videoId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserEntity user;
  final List<FileEntity> images;
  final FileEntity video;
  final PostStatEntity stat;
  @JsonKey(defaultValue: false)
  final bool liked;

  const PostEntity({
    this.id,
    this.userId,
    this.type,
    this.text,
    this.imageIds,
    this.videoId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.images,
    this.video,
    this.stat,
    this.liked,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) =>
      _$PostEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostEntityToJson(this);
}
