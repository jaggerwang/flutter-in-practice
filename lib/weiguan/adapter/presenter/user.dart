import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../../entity/entity.dart';
import '../../ui/ui.dart';
import '../../usecase/usecase.dart';
import 'base.dart';

class UserPresenter extends BasePresenter {
  WeiguanService weiguanService;
  UserUsecases userUsecases;

  UserPresenter({
    @required Store<AppState> appStore,
    @required this.weiguanService,
    @required this.userUsecases,
  }) : super(appStore: appStore);

  Future<UserEntity> login(UserLoginForm form) async {
    final user = await weiguanService.userLogin(form.username, form.password);

    await logged();

    return user;
  }

  Future<UserEntity> register(UserRegisterForm form) async {
    final user = await weiguanService.userRegister(
        UserEntity(username: form.username, password: form.password));

    await logged();

    return user;
  }

  Future<UserEntity> logged() async {
    final user = await weiguanService.userLogged();

    dispatchAction(UserLoggedAction(user: user));

    return user;
  }

  Future<UserEntity> logout() async {
    final user = await weiguanService.userLogout();

    dispatchAction(ResetAction());

    return user;
  }

  Future<UserEntity> modify(UserProfileForm form) async {
    final user = await weiguanService.userModify(
        UserEntity(
            username: form.username,
            password: form.password,
            mobile: form.mobile,
            email: form.email,
            avatarId: form.avatarId,
            intro: form.intro),
        form.code);

    await logged();

    return user;
  }

  Future<UserEntity> modifyAvatar(String path) async {
    final user = await userUsecases.modifyAvatar(path);

    await logged();

    return user;
  }

  Future<String> sendMobileVerifyCode(String type, String mobile) async {
    final verifyCode =
        await weiguanService.userSendMobileVerifyCode(type, mobile);
    return verifyCode;
  }

  Future<UserEntity> info(int userId) async {
    final user = await weiguanService.userInfo(userId);
    return user;
  }

  Future<void> follow(int userId) async {
    await weiguanService.userFollow(userId);
  }

  Future<void> unfollow(int userId) async {
    await weiguanService.userUnfollow(userId);
  }

  Future<List<UserEntity>> following(
      {int userId, int limit = 10, int offset = 0}) async {
    final users = await weiguanService.userFollowing(
        userId: userId, limit: limit, offset: offset);
    return users;
  }

  Future<List<UserEntity>> follower(
      {int userId, int limit = 10, int offset = 0}) async {
    final users = await weiguanService.userFollower(
        userId: userId, limit: limit, offset: offset);
    return users;
  }
}
