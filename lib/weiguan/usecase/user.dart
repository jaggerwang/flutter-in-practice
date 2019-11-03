import 'package:meta/meta.dart';

import '../entity/entity.dart';
import 'usecase.dart';

class UserUseCase {
  WeiguanService weiguanService;

  UserUseCase(this.weiguanService);

  Future<UserEntity> info(int postId) {
    return weiguanService.userInfo(postId);
  }

  Future<void> follow(int followingId) {
    return weiguanService.userFollow(followingId);
  }

  Future<void> unfollow(int followingId) {
    return weiguanService.userUnfollow(followingId);
  }

  Future<List<UserEntity>> followings(
      {@required int userId, int limit = 10, int offset = 0}) {
    return weiguanService.userFollowings(
        userId: userId, limit: limit, offset: offset);
  }

  Future<List<UserEntity>> followers(
      {@required int userId, int limit = 10, int offset = 0}) {
    return weiguanService.userFollowers(
        userId: userId, limit: limit, offset: offset);
  }
}
