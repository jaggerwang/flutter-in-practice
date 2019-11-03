import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

import '../../entities/entities.dart';
import '../forms/forms.dart';

part 'post.g.dart';

@JsonSerializable()
@FunctionalData()
class PostState extends $PostState {
  final List<PostEntity> followingPosts;
  final PostPublishForm publishForm;

  PostState({
    this.followingPosts = const [],
    PostPublishForm publishForm,
  }) : this.publishForm = publishForm ?? PostPublishForm();

  factory PostState.fromJson(Map<String, dynamic> json) =>
      _$PostStateFromJson(json);

  Map<String, dynamic> toJson() => _$PostStateToJson(this);
}
