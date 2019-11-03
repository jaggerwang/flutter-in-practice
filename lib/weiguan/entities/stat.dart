import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

part 'stat.g.dart';

@JsonSerializable()
@FunctionalData()
class UserStatEntity extends $UserStatEntity {
  final int id;
  final int userId;
  final int postCount;
  final int likeCount;
  final int followingCount;
  final int followerCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserStatEntity({
    this.id,
    this.userId,
    this.postCount,
    this.likeCount,
    this.followingCount,
    this.followerCount,
    this.createdAt,
    this.updatedAt,
  });

  factory UserStatEntity.fromJson(Map<String, dynamic> json) =>
      _$UserStatEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserStatEntityToJson(this);
}

@JsonSerializable()
@FunctionalData()
class PostStatEntity extends $PostStatEntity {
  final int id;
  final int postId;
  final int likeCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PostStatEntity({
    this.id,
    this.postId,
    this.likeCount,
    this.createdAt,
    this.updatedAt,
  });

  factory PostStatEntity.fromJson(Map<String, dynamic> json) =>
      _$PostStatEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostStatEntityToJson(this);
}
