// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $PostState {
  List<PostEntity> get followingPosts;
  PostPublishForm get publishForm;
  const $PostState();
  PostState copyWith(
          {List<PostEntity> followingPosts, PostPublishForm publishForm}) =>
      PostState(
          followingPosts: followingPosts ?? this.followingPosts,
          publishForm: publishForm ?? this.publishForm);
  String toString() =>
      "PostState(followingPosts: $followingPosts, publishForm: $publishForm)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      followingPosts == other.followingPosts &&
      publishForm == other.publishForm;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + followingPosts.hashCode;
    result = 37 * result + publishForm.hashCode;
    return result;
  }
}

class PostState$ {
  static final followingPosts = Lens<PostState, List<PostEntity>>(
      (s_) => s_.followingPosts,
      (s_, followingPosts) => s_.copyWith(followingPosts: followingPosts));
  static final publishForm = Lens<PostState, PostPublishForm>(
      (s_) => s_.publishForm,
      (s_, publishForm) => s_.copyWith(publishForm: publishForm));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostState _$PostStateFromJson(Map<String, dynamic> json) {
  return PostState(
    followingPosts: (json['followingPosts'] as List)
        ?.map((e) =>
            e == null ? null : PostEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    publishForm: json['publishForm'] == null
        ? null
        : PostPublishForm.fromJson(json['publishForm'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostStateToJson(PostState instance) => <String, dynamic>{
      'followingPosts': instance.followingPosts,
      'publishForm': instance.publishForm,
    };
