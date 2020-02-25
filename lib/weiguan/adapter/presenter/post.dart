import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../../entity/entity.dart';
import '../../ui/ui.dart';
import '../../usecase/usecase.dart';
import '../../config.dart';
import 'base.dart';

class PostPresenter extends BasePresenter {
  WeiguanService weiguanService;
  PostUsecases postUsecases;

  PostPresenter({
    @required WgConfig config,
    @required Store<AppState> appStore,
    @required this.weiguanService,
    @required this.postUsecases,
  }) : super(config: config, appStore: appStore);

  Future<PostEntity> publish(PostPublishForm form) async {
    final post = await postUsecases.publish(
        type: form.type,
        text: form.text,
        localImagePaths: form.images,
        localVideoPath: form.video);
    return post;
  }

  Future<void> delete(int postId) async {
    await weiguanService.postDelete(postId);

    dispatchAction(PostDeleteAction(postId: postId));
  }

  Future<PostEntity> info(int postId) async {
    final post = await weiguanService.postInfo(postId);
    return post;
  }

  Future<List<PostEntity>> published(
      {int userId, int limit = 10, int offset = 0}) async {
    final posts = await weiguanService.postPublished(
        userId: userId, limit: limit, offset: offset);
    return posts;
  }

  Future<void> like(int postId) async {
    await weiguanService.postLike(postId);

    dispatchAction(PostLikeAction(postId: postId));
  }

  Future<void> unlike(int postId) async {
    await weiguanService.postUnlike(postId);

    dispatchAction(PostUnlikeAction(postId: postId));
  }

  Future<List<PostEntity>> liked(
      {int userId, int limit = 10, int offset = 0}) async {
    final posts = await weiguanService.postLiked(
        userId: userId, limit: limit, offset: offset);
    return posts;
  }

  Future<List<PostEntity>> following(
      {int limit = 10, int beforeId, int afterId}) async {
    final posts = await weiguanService.postFollowing(
        limit: limit, beforeId: beforeId, afterId: afterId);

    dispatchAction(PostFollowingAction(
      posts: posts,
      append: afterId == null,
      allLoaded: posts.length < limit,
    ));

    return posts;
  }

  Future<List<PostEntity>> hot({int limit = 10, int offset = 0}) async {
    final posts =
        await weiguanService.postPublished(limit: limit, offset: offset);

    dispatchAction(PostHotAction(
      posts: posts,
      clearAll: offset == 0,
      allLoaded: posts.length < limit,
    ));

    return posts;
  }
}
