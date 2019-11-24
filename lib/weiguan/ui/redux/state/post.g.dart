// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $PostState {
  List<PostEntity> get followingPosts;
  bool get followingPostsAllLoaded;
  List<PostEntity> get hotPosts;
  bool get hotPostsAllLoaded;
  const $PostState();
  PostState copyWith(
          {List<PostEntity> followingPosts,
          bool followingPostsAllLoaded,
          List<PostEntity> hotPosts,
          bool hotPostsAllLoaded}) =>
      PostState(
          followingPosts: followingPosts ?? this.followingPosts,
          followingPostsAllLoaded:
              followingPostsAllLoaded ?? this.followingPostsAllLoaded,
          hotPosts: hotPosts ?? this.hotPosts,
          hotPostsAllLoaded: hotPostsAllLoaded ?? this.hotPostsAllLoaded);
  String toString() =>
      "PostState(followingPosts: $followingPosts, followingPostsAllLoaded: $followingPostsAllLoaded, hotPosts: $hotPosts, hotPostsAllLoaded: $hotPostsAllLoaded)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      followingPosts == other.followingPosts &&
      followingPostsAllLoaded == other.followingPostsAllLoaded &&
      hotPosts == other.hotPosts &&
      hotPostsAllLoaded == other.hotPostsAllLoaded;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + followingPosts.hashCode;
    result = 37 * result + followingPostsAllLoaded.hashCode;
    result = 37 * result + hotPosts.hashCode;
    result = 37 * result + hotPostsAllLoaded.hashCode;
    return result;
  }
}

class PostState$ {
  static final followingPosts = Lens<PostState, List<PostEntity>>(
      (s_) => s_.followingPosts,
      (s_, followingPosts) => s_.copyWith(followingPosts: followingPosts));
  static final followingPostsAllLoaded = Lens<PostState, bool>(
      (s_) => s_.followingPostsAllLoaded,
      (s_, followingPostsAllLoaded) =>
          s_.copyWith(followingPostsAllLoaded: followingPostsAllLoaded));
  static final hotPosts = Lens<PostState, List<PostEntity>>(
      (s_) => s_.hotPosts, (s_, hotPosts) => s_.copyWith(hotPosts: hotPosts));
  static final hotPostsAllLoaded = Lens<PostState, bool>(
      (s_) => s_.hotPostsAllLoaded,
      (s_, hotPostsAllLoaded) =>
          s_.copyWith(hotPostsAllLoaded: hotPostsAllLoaded));
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
    followingPostsAllLoaded: json['followingPostsAllLoaded'] as bool,
    hotPosts: (json['hotPosts'] as List)
        ?.map((e) =>
            e == null ? null : PostEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    hotPostsAllLoaded: json['hotPostsAllLoaded'] as bool,
  );
}

Map<String, dynamic> _$PostStateToJson(PostState instance) => <String, dynamic>{
      'followingPosts': instance.followingPosts,
      'followingPostsAllLoaded': instance.followingPostsAllLoaded,
      'hotPosts': instance.hotPosts,
      'hotPostsAllLoaded': instance.hotPostsAllLoaded,
    };
