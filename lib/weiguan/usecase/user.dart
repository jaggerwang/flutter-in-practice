import '../entity/entity.dart';
import 'usecase.dart';

class UserUsecases extends BaseUsecases {
  UserUsecases(WeiguanService weiguanService) : super(weiguanService);

  Future<UserEntity> modifyAvatar(String localPath) async {
    final files = await weiguanService.fileUpload([localPath], path: 'avatar');

    return weiguanService.userModify(UserEntity(avatarId: files.first.id));
  }
}
