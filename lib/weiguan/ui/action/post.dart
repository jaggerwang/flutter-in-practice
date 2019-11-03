import 'package:meta/meta.dart';

import '../../entity/entity.dart';
import '../ui.dart';

class PostPublishFormAction {
  final PostPublishForm form;

  PostPublishFormAction({
    @required this.form,
  });
}

class PostDeleteAction {
  final int postId;

  PostDeleteAction({
    @required this.postId,
  });
}

class PostLikeAction {
  final int postId;

  PostLikeAction({
    @required this.postId,
  });
}

class PostUnlikeAction {
  final int postId;

  PostUnlikeAction({
    @required this.postId,
  });
}

class PostFollowingsAction {
  final List<PostEntity> posts;
  final int beforeId;
  final int afterId;

  PostFollowingsAction({
    @required this.posts,
    this.beforeId,
    this.afterId,
  });
}
