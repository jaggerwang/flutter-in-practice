import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../../entity/entity.dart';
import '../../ui/ui.dart';
import '../../usecase/usecase.dart';

class PostPresenter {
  Store<AppState> store;
  PostUseCase postUseCase;

  PostPresenter(this.store, this.postUseCase);

  void savePublishForm(PostPublishForm form) {
    store.dispatch(PostPublishFormAction(form: form));
  }

  Future<PostEntity> publish(PostPublishForm form) async {
    final post = await postUseCase.publish(
        type: form.type,
        text: form.text,
        localImagePaths: form.images,
        localVideoPath: form.video);
    return post;
  }

  Future<void> delete(int postId) async {
    await postUseCase.delete(postId);

    store.dispatch(PostDeleteAction(postId: postId));
  }

  Future<PostEntity> info(int postId) async {
    final post = await postUseCase.info(postId);
    return post;
  }

  Future<List<PostEntity>> published(
      {@required int userId, int limit = 10, int offset = 0}) async {
    final posts = await postUseCase.published(
        userId: userId, limit: limit, offset: offset);
    return posts;
  }

  Future<void> like(int postId) async {
    await postUseCase.like(postId);

    store.dispatch(PostLikeAction(postId: postId));
  }

  Future<void> unlike(int postId) async {
    await postUseCase.unlike(postId);

    store.dispatch(PostUnlikeAction(postId: postId));
  }

  Future<List<PostEntity>> liked(
      {@required int userId, int limit = 10, int offset = 0}) async {
    final posts =
        await postUseCase.liked(userId: userId, limit: limit, offset: offset);
    return posts;
  }

  Future<List<PostEntity>> following(
      {int limit = 10, int beforeId, int afterId}) async {
    final posts = await postUseCase.following(
        limit: limit, beforeId: beforeId, afterId: afterId);

    store.dispatch(PostFollowingsAction(
      posts: posts,
      beforeId: beforeId,
      afterId: afterId,
    ));

    return posts;
  }
}
