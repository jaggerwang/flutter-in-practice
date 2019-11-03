import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

import 'entity.dart';

part 'post.g.dart';

enum PostType { text, image, video }

@JsonSerializable()
@FunctionalData()
class PostEntity extends $PostEntity {
  static final typeNames = {
    PostType.text: '文字',
    PostType.image: '图片',
    PostType.video: '视频',
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
  final bool isLiked;

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
    this.isLiked,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) =>
      _$PostEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostEntityToJson(this);
}
