// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vm.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $HomeVM {
  PostListType get postListType;
  List<PostEntity> get followingPosts;
  bool get followingPostsAllLoaded;
  List<PostEntity> get hotPosts;
  bool get hotPostsAllLoaded;
  const $HomeVM();
  HomeVM copyWith(
          {PostListType postListType,
          List<PostEntity> followingPosts,
          bool followingPostsAllLoaded,
          List<PostEntity> hotPosts,
          bool hotPostsAllLoaded}) =>
      HomeVM(
          postListType: postListType ?? this.postListType,
          followingPosts: followingPosts ?? this.followingPosts,
          followingPostsAllLoaded:
              followingPostsAllLoaded ?? this.followingPostsAllLoaded,
          hotPosts: hotPosts ?? this.hotPosts,
          hotPostsAllLoaded: hotPostsAllLoaded ?? this.hotPostsAllLoaded);
  String toString() =>
      "HomeVM(postListType: $postListType, followingPosts: $followingPosts, followingPostsAllLoaded: $followingPostsAllLoaded, hotPosts: $hotPosts, hotPostsAllLoaded: $hotPostsAllLoaded)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      postListType == other.postListType &&
      followingPosts == other.followingPosts &&
      followingPostsAllLoaded == other.followingPostsAllLoaded &&
      hotPosts == other.hotPosts &&
      hotPostsAllLoaded == other.hotPostsAllLoaded;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + postListType.hashCode;
    result = 37 * result + followingPosts.hashCode;
    result = 37 * result + followingPostsAllLoaded.hashCode;
    result = 37 * result + hotPosts.hashCode;
    result = 37 * result + hotPostsAllLoaded.hashCode;
    return result;
  }
}

class HomeVM$ {
  static final postListType = Lens<HomeVM, PostListType>(
      (s_) => s_.postListType,
      (s_, postListType) => s_.copyWith(postListType: postListType));
  static final followingPosts = Lens<HomeVM, List<PostEntity>>(
      (s_) => s_.followingPosts,
      (s_, followingPosts) => s_.copyWith(followingPosts: followingPosts));
  static final followingPostsAllLoaded = Lens<HomeVM, bool>(
      (s_) => s_.followingPostsAllLoaded,
      (s_, followingPostsAllLoaded) =>
          s_.copyWith(followingPostsAllLoaded: followingPostsAllLoaded));
  static final hotPosts = Lens<HomeVM, List<PostEntity>>(
      (s_) => s_.hotPosts, (s_, hotPosts) => s_.copyWith(hotPosts: hotPosts));
  static final hotPostsAllLoaded = Lens<HomeVM, bool>(
      (s_) => s_.hotPostsAllLoaded,
      (s_, hotPostsAllLoaded) =>
          s_.copyWith(hotPostsAllLoaded: hotPostsAllLoaded));
}
