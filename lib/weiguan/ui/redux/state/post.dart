import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

import '../../../entity/entity.dart';

part 'post.g.dart';

@JsonSerializable()
@FunctionalData()
class PostState extends $PostState {
  final List<PostEntity> followingPosts;
  final bool followingPostsAllLoaded;
  final List<PostEntity> hotPosts;
  final bool hotPostsAllLoaded;

  PostState({
    this.followingPosts = const [],
    this.followingPostsAllLoaded = false,
    this.hotPosts = const [],
    this.hotPostsAllLoaded = false,
  });

  factory PostState.fromJson(Map<String, dynamic> json) =>
      _$PostStateFromJson(json);

  Map<String, dynamic> toJson() => _$PostStateToJson(this);
}
