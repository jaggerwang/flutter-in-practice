import 'package:meta/meta.dart';

import '../entity/entity.dart';
import 'usecase.dart';

class AccountUseCase {
  WeiguanService weiguanService;

  AccountUseCase(this.weiguanService);

  Future<UserEntity> login(
      {String username, String mobile, @required String password}) {
    return weiguanService.accountLogin(
        username: username, mobile: mobile, password: password);
  }

  Future<UserEntity> register(UserEntity userEntity, [String code]) {
    return weiguanService.accountRegister(userEntity, code);
  }

  Future<UserEntity> info() {
    return weiguanService.accountInfo();
  }

  Future<UserEntity> logout() {
    return weiguanService.accountLogout();
  }

  Future<UserEntity> modify(UserEntity userEntity, [String code]) {
    return weiguanService.accountModify(userEntity, code);
  }

  Future<UserEntity> modifyAvatar(String localPath) async {
    final files =
        await weiguanService.storageUpload(path: 'avatar', files: [localPath]);

    return weiguanService.accountModify(UserEntity(avatarId: files.first.id));
  }

  Future<String> sendMobileVerifyCode(String type, String mobile) {
    return weiguanService.accountSendMobileVerifyCode(type, mobile);
  }
}
