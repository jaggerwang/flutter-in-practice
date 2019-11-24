import 'package:functional_data/functional_data.dart';

import '../../../entity/entity.dart';

part 'vm.g.dart';

@FunctionalData()
class HomeVM extends $HomeVM {
  final PostListType postListType;
  final List<PostEntity> followingPosts;
  final bool followingPostsAllLoaded;
  final List<PostEntity> hotPosts;
  final bool hotPostsAllLoaded;

  HomeVM({
    this.postListType,
    this.followingPosts,
    this.followingPostsAllLoaded,
    this.hotPosts,
    this.hotPostsAllLoaded,
  });
}
