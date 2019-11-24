import 'package:meta/meta.dart';

import '../../../entity/entity.dart';
import '../../ui.dart';

class PostDeleteAction extends BaseAction {
  final int postId;

  PostDeleteAction({
    @required this.postId,
  });
}

class PostLikeAction extends BaseAction {
  final int postId;

  PostLikeAction({
    @required this.postId,
  });
}

class PostUnlikeAction extends BaseAction {
  final int postId;

  PostUnlikeAction({
    @required this.postId,
  });
}

class PostFollowingAction extends BaseAction {
  final List<PostEntity> posts;
  final bool append;
  final bool allLoaded;

  PostFollowingAction({
    @required this.posts,
    this.append = true,
    this.allLoaded = false,
  });
}

class PostHotAction extends BaseAction {
  final List<PostEntity> posts;
  final bool clearAll;
  final bool allLoaded;

  PostHotAction({
    @required this.posts,
    this.clearAll = false,
    this.allLoaded = false,
  });
}
