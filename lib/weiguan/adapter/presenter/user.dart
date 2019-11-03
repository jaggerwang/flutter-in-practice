import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../../entity/entity.dart';
import '../../ui/ui.dart';
import '../../usecase/usecase.dart';

class UserPresenter {
  Store<AppState> store;
  UserUseCase userUseCase;

  UserPresenter(this.store, this.userUseCase);

  Future<UserEntity> info(int userId) async {
    final user = await userUseCase.info(userId);
    return user;
  }

  Future<void> follow(int userId) async {
    await userUseCase.follow(userId);
  }

  Future<void> unfollow(int userId) async {
    await userUseCase.unfollow(userId);
  }

  Future<List<UserEntity>> followings(
      {@required int userId, int limit = 10, int offset = 0}) async {
    final users = await userUseCase.followings(
        userId: userId, limit: limit, offset: offset);
    return users;
  }

  Future<List<UserEntity>> followers(
      {@required int userId, int limit = 10, int offset = 0}) async {
    final users = await userUseCase.followers(
        userId: userId, limit: limit, offset: offset);
    return users;
  }
}
