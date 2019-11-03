import 'package:redux/redux.dart';

import '../../entities/entities.dart';
import '../states/states.dart';
import '../actions/actions.dart';

final postReducer = combineReducers<PostState>([
  TypedReducer<PostState, PostPublishFormAction>(_publishForm),
  TypedReducer<PostState, PostDeleteAction>(_delete),
  TypedReducer<PostState, PostLikeAction>(_like),
  TypedReducer<PostState, PostUnlikeAction>(_unlike),
  TypedReducer<PostState, PostFollowingsAction>(_followings),
]);

PostState _publishForm(PostState state, PostPublishFormAction action) {
  return state.copyWith(
    publishForm: action.form,
  );
}

PostState _delete(PostState state, PostDeleteAction action) {
  final followingPosts = List<PostEntity>.from(state.followingPosts);
  followingPosts.removeWhere((v) => v.id == action.id);

  return state.copyWith(
    followingPosts: followingPosts,
  );
}

PostState _like(PostState state, PostLikeAction action) {
  final followingPosts = state.followingPosts.map((post) {
    if (post.id == action.id) {
      post = post.copyWith(isLiked: true);
    }
    return post;
  }).toList();

  return state.copyWith(
    followingPosts: followingPosts,
  );
}

PostState _unlike(PostState state, PostUnlikeAction action) {
  final followingPosts = state.followingPosts.map((post) {
    if (post.id == action.id) {
      post = post.copyWith(isLiked: false);
    }
    return post;
  }).toList();

  return state.copyWith(
    followingPosts: followingPosts,
  );
}

PostState _followings(PostState state, PostFollowingsAction action) {
  return state.copyWith(
    followingPosts: action.afterId != null
        ? action.posts + state.followingPosts
        : state.followingPosts + action.posts,
  );
}
