import 'package:meta/meta.dart';

import '../../../entity/entity.dart';

abstract class WeiguanService {
  Future<UserEntity> accountRegister(UserEntity userEntity, [String code]);

  Future<UserEntity> accountLogin(
      {String username, String mobile, @required String password});

  Future<UserEntity> accountInfo();

  Future<UserEntity> accountLogout();

  Future<UserEntity> accountModify(UserEntity userEntity, [String code]);

  Future<String> accountSendMobileVerifyCode(String type, String mobile);

  Future<PostEntity> postPublish(PostEntity postEntity);

  Future<void> postDelete(int postId);

  Future<PostEntity> postInfo(int postId);

  Future<List<PostEntity>> postPublished(
      {@required int userId, int limit = 10, int offset = 0});

  Future<void> postLike(int postId);

  Future<void> postUnlike(int postId);

  Future<List<PostEntity>> postLiked(
      {@required int userId, int limit = 10, int offset = 0});

  Future<List<PostEntity>> postFollowing(
      {int limit = 10, int beforeId, int afterId});

  Future<List<FileEntity>> storageUpload(
      {String region,
      String bucket,
      String path,
      @required List<String> files});

  Future<UserEntity> userInfo(int postId);

  Future<void> userFollow(int followingId);

  Future<void> userUnfollow(int followingId);

  Future<List<UserEntity>> userFollowings(
      {@required int userId, int limit = 10, int offset = 0});

  Future<List<UserEntity>> userFollowers(
      {@required int userId, int limit = 10, int offset = 0});
}
