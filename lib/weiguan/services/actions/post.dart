import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../container.dart';
import '../../entities/entities.dart';
import '../../interfaces/interfaces.dart';
import '../forms/forms.dart';
import '../states/states.dart';

class PostPublishFormAction {
  final PostPublishForm form;

  PostPublishFormAction({
    @required this.form,
  });
}

class PostDeleteAction {
  final int id;

  PostDeleteAction({
    @required this.id,
  });
}

class PostLikeAction {
  final int id;

  PostLikeAction({
    @required this.id,
  });
}

class PostUnlikeAction {
  final int id;

  PostUnlikeAction({
    @required this.id,
  });
}

class PostFollowingsAction {
  final List<PostEntity> posts;
  final int beforeId;
  final int afterId;

  PostFollowingsAction({
    @required this.posts,
    this.beforeId,
    this.afterId,
  });
}

ThunkAction<AppState> postPublishAction({
  @required PostPublishForm form,
  void Function(PostEntity) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response =
          await WgContainer().wgService.post('/post/publish', form.toJson());

      if (response.code == WgResponse.codeOk) {
        final post = PostEntity.fromJson(response.data['post']);
        if (onSuccess != null) onSuccess(post);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> postDeleteAction({
  @required int id,
  void Function() onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response =
          await WgContainer().wgService.post('/post/delete', {'id': id});

      if (response.code == WgResponse.codeOk) {
        store.dispatch(PostDeleteAction(id: id));
        if (onSuccess != null) onSuccess();
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> postInfoAction({
  @required int id,
  void Function(PostEntity) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response =
          await WgContainer().wgService.get('/post/info', {'id': id});

      if (response.code == WgResponse.codeOk) {
        final post = response.data['post'] as PostEntity;
        if (onSuccess != null) onSuccess(post);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> postPublishedAction({
  @required int userId,
  int limit = 10,
  int offset = 0,
  void Function(List<PostEntity>) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response = await WgContainer().wgService.get(
        '/post/published',
        {
          'userId': userId,
          'limit': limit,
          'offset': offset,
        },
      );

      if (response.code == WgResponse.codeOk) {
        final posts = (response.data['posts'] as List<Map<String, dynamic>>)
            .map((v) => PostEntity.fromJson(v))
            .toList();
        if (onSuccess != null) onSuccess(posts);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> postLikeAction({
  @required int postId,
  void Function() onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response =
          await WgContainer().wgService.post('/post/like', {'postId': postId});

      if (response.code == WgResponse.codeOk) {
        store.dispatch(PostLikeAction(id: postId));
        if (onSuccess != null) onSuccess();
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> postUnlikeAction({
  @required int postId,
  void Function() onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response = await WgContainer()
          .wgService
          .post('/post/unlike', {'postId': postId});

      if (response.code == WgResponse.codeOk) {
        store.dispatch(PostUnlikeAction(id: postId));
        if (onSuccess != null) onSuccess();
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> postLikedAction({
  @required int userId,
  int limit = 10,
  int offset = 0,
  void Function(List<PostEntity>) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response = await WgContainer().wgService.get(
        '/post/liked',
        {
          'userId': userId,
          'limit': limit,
          'offset': offset,
        },
      );

      if (response.code == WgResponse.codeOk) {
        final posts = (response.data['posts'] as List<Map<String, dynamic>>)
            .map((v) => PostEntity.fromJson(v))
            .toList();
        if (onSuccess != null) onSuccess(posts);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> postFollowingAction({
  int limit = 10,
  int beforeId,
  int afterId,
  void Function(List<PostEntity>) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response = await WgContainer().wgService.get(
        '/post/following',
        {
          'limit': limit,
          'beforeId': beforeId,
          'afterId': afterId,
        },
      );

      if (response.code == WgResponse.codeOk) {
        final posts = (response.data['posts'] as List<Map<String, dynamic>>)
            .map((v) => PostEntity.fromJson(v))
            .toList();
        store.dispatch(PostFollowingsAction(
          posts: posts,
          beforeId: beforeId,
          afterId: afterId,
        ));
        if (onSuccess != null) onSuccess(posts);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };
