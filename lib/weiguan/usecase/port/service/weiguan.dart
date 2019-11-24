import '../../../entity/entity.dart';

abstract class WeiguanService {
  Future<UserEntity> userRegister(UserEntity userEntity);

  Future<UserEntity> userLogin(String username, String password);

  Future<UserEntity> userLogged();

  Future<UserEntity> userLogout();

  Future<UserEntity> userModify(UserEntity userEntity, [String code]);

  Future<UserEntity> userInfo(int id);

  Future<void> userFollow(int userId);

  Future<void> userUnfollow(int userId);

  Future<List<UserEntity>> userFollowing(
      {int userId, int limit = 10, int offset = 0});

  Future<List<UserEntity>> userFollower(
      {int userId, int limit = 10, int offset = 0});

  Future<String> userSendMobileVerifyCode(String type, String mobile);

  Future<PostEntity> postPublish(PostEntity postEntity);

  Future<void> postDelete(int id);

  Future<PostEntity> postInfo(int id);

  Future<List<PostEntity>> postPublished(
      {int userId, int limit = 10, int offset = 0});

  Future<void> postLike(int postId);

  Future<void> postUnlike(int postId);

  Future<List<PostEntity>> postLiked(
      {int userId, int limit = 10, int offset = 0});

  Future<List<PostEntity>> postFollowing(
      {int limit = 10, int beforeId, int afterId});

  Future<List<FileEntity>> fileUpload(List<String> files,
      {String region, String bucket, String path});
}
