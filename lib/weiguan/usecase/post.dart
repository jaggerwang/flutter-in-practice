import 'package:meta/meta.dart';

import '../entity/entity.dart';
import 'usecase.dart';

class PostUseCase {
  WeiguanService weiguanService;

  PostUseCase(this.weiguanService);

  Future<PostEntity> publish(
      {@required PostType type,
      String text,
      List<String> localImagePaths,
      String localVideoPath}) async {
    List<int> imageIds;
    int videoId;
    if (type == PostType.image) {
      final files = await weiguanService.storageUpload(
          path: 'post', files: localImagePaths);
      imageIds = files.map((v) => v.id).toList();
    } else if (type == PostType.video) {
      final files = await weiguanService
          .storageUpload(path: 'post', files: [localVideoPath]);
      videoId = files.first.id;
    }

    return weiguanService.postPublish(PostEntity(
        type: type, text: text, imageIds: imageIds, videoId: videoId));
  }

  Future<void> delete(int postId) {
    return weiguanService.postDelete(postId);
  }

  Future<PostEntity> info(int postId) {
    return weiguanService.postInfo(postId);
  }

  Future<List<PostEntity>> published(
      {@required int userId, int limit = 10, int offset = 0}) {
    return weiguanService.postPublished(
        userId: userId, limit: limit, offset: offset);
  }

  Future<void> like(int postId) {
    return weiguanService.postLike(postId);
  }

  Future<void> unlike(int postId) {
    return weiguanService.postUnlike(postId);
  }

  Future<List<PostEntity>> liked(
      {@required int userId, int limit = 10, int offset = 0}) {
    return weiguanService.postLiked(
        userId: userId, limit: limit, offset: offset);
  }

  Future<List<PostEntity>> following(
      {int limit = 10, int beforeId, int afterId}) {
    return weiguanService.postFollowing(
        limit: limit, beforeId: beforeId, afterId: afterId);
  }
}
