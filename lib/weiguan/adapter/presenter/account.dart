import 'package:redux/redux.dart';

import '../../entity/entity.dart';
import '../../ui/ui.dart';
import '../../usecase/usecase.dart';

class AccountPresenter {
  Store<AppState> store;
  AccountUseCase accountUseCase;

  AccountPresenter(this.store, this.accountUseCase);

  Future<UserEntity> login(AccountLoginForm form) async {
    final user = await accountUseCase.login(
        username: form.username, mobile: form.mobile, password: form.password);

    await info();

    return user;
  }

  Future<UserEntity> register(AccountRegisterForm form) async {
    final user = await accountUseCase
        .register(UserEntity(username: form.username, password: form.password));

    await info();

    return user;
  }

  Future<UserEntity> info() async {
    final user = await accountUseCase.info();

    store.dispatch(AccountInfoAction(user: user));

    return user;
  }

  Future<UserEntity> logout() async {
    final user = await accountUseCase.logout();

    store.dispatch(ResetAction());

    return user;
  }

  Future<UserEntity> modify(AccountProfileForm form) async {
    final user = await accountUseCase.modify(
        UserEntity(
            username: form.username,
            password: form.password,
            mobile: form.mobile,
            email: form.email,
            avatarId: form.avatarId,
            intro: form.intro),
        form.code);

    await info();

    return user;
  }

  Future<UserEntity> modifyAvatar(String path) async {
    final user = await accountUseCase.modifyAvatar(path);

    await info();

    return user;
  }

  Future<String> sendMobileVerifyCode(String type, String mobile) async {
    final verifyCode = await accountUseCase.sendMobileVerifyCode(type, mobile);
    return verifyCode;
  }
}
