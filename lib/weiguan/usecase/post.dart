import 'package:meta/meta.dart';

import '../entity/entity.dart';
import 'usecase.dart';

class PostUsecases extends BaseUsecases {
  PostUsecases(WeiguanService weiguanService) : super(weiguanService);

  Future<PostEntity> publish(
      {@required PostType type,
      String text,
      List<String> localImagePaths,
      String localVideoPath}) async {
    List<int> imageIds;
    int videoId;
    if (type == PostType.IMAGE) {
      final files =
          await weiguanService.fileUpload(localImagePaths, path: 'post');
      imageIds = files.map((v) => v.id).toList();
    } else if (type == PostType.VIDEO) {
      final files =
          await weiguanService.fileUpload([localVideoPath], path: 'post');
      videoId = files.first.id;
    }

    return weiguanService.postPublish(PostEntity(
        type: type, text: text, imageIds: imageIds, videoId: videoId));
  }
}
