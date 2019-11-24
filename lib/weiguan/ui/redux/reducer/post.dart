import 'package:redux/redux.dart';

import '../../../entity/entity.dart';
import '../../ui.dart';

final postReducer = combineReducers<PostState>([
  TypedReducer<PostState, PostDeleteAction>(_delete),
  TypedReducer<PostState, PostLikeAction>(_like),
  TypedReducer<PostState, PostUnlikeAction>(_unlike),
  TypedReducer<PostState, PostFollowingAction>(_following),
  TypedReducer<PostState, PostHotAction>(_hot),
]);

PostState _delete(PostState state, PostDeleteAction action) {
  final followingPosts = List<PostEntity>.from(state.followingPosts);
  followingPosts.removeWhere((v) => v.id == action.postId);

  final hotPosts = List<PostEntity>.from(state.hotPosts);
  hotPosts.removeWhere((v) => v.id == action.postId);

  return state.copyWith(
    followingPosts: followingPosts,
    hotPosts: hotPosts,
  );
}

PostState _like(PostState state, PostLikeAction action) {
  final followingPosts = state.followingPosts.map((post) {
    if (post.id == action.postId) {
      post = post.copyWith(liked: true);
    }
    return post;
  }).toList();

  final hotPosts = state.hotPosts.map((post) {
    if (post.id == action.postId) {
      post = post.copyWith(liked: true);
    }
    return post;
  }).toList();

  return state.copyWith(
    followingPosts: followingPosts,
    hotPosts: hotPosts,
  );
}

PostState _unlike(PostState state, PostUnlikeAction action) {
  final followingPosts = state.followingPosts.map((post) {
    if (post.id == action.postId) {
      post = post.copyWith(liked: false);
    }
    return post;
  }).toList();

  final hotPosts = state.hotPosts.map((post) {
    if (post.id == action.postId) {
      post = post.copyWith(liked: false);
    }
    return post;
  }).toList();

  return state.copyWith(
    followingPosts: followingPosts,
    hotPosts: hotPosts,
  );
}

PostState _following(PostState state, PostFollowingAction action) {
  return state.copyWith(
    followingPosts: action.append
        ? state.followingPosts + action.posts
        : action.posts + state.followingPosts,
    followingPostsAllLoaded: action.allLoaded,
  );
}

PostState _hot(PostState state, PostHotAction action) {
  return state.copyWith(
    hotPosts: action.clearAll ? action.posts : state.hotPosts + action.posts,
    hotPostsAllLoaded: action.allLoaded,
  );
}
