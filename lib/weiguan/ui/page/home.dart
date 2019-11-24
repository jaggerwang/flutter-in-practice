import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../entity/entity.dart';
import '../../container.dart';
import '../ui.dart';

class HomePage extends StatelessWidget {
  static final _bodyKey = GlobalKey<_BodyState>();

  static void refresh() {
    _bodyKey.currentState._refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(bodyKey: _bodyKey),
      body: _Body(key: _bodyKey),
      bottomNavigationBar: WgTabBar(currentIndex: 0),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<_BodyState> bodyKey;

  _AppBar({@required this.bodyKey});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PostListType>(
      converter: (store) => store.state.page.homeMode,
      distinct: true,
      builder: (context, vm) => AppBar(
        title: Text('首页'),
        actions: [
          Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: Theme.of(context).primaryColor),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<PostListType>(
                value: vm,
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Colors.white),
                iconEnabledColor: Colors.white,
                onChanged: (value) => bodyKey.currentState._switchMode(value),
                items: [
                  DropdownMenuItem<PostListType>(
                    value: PostListType.FOLLOWING,
                    child: Text('关注'),
                  ),
                  DropdownMenuItem<PostListType>(
                    value: PostListType.HOT,
                    child: Text('热门'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _Body extends StatefulWidget {
  _Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  HomeVM _vm;

  void _switchMode(PostListType mode) {
    WgContainer()
        .basePresenter
        .dispatchAction(PageStateAction(homePostListType: mode));

    if (mode == PostListType.FOLLOWING) {
      _loadFollowingPosts(refresh: true);
    } else {
      _loadHotPosts(refresh: true);
    }
  }

  Future<void> _loadFollowingPosts({
    bool refresh = false,
  }) async {
    if (!refresh && _vm.followingPostsAllLoaded) {
      return;
    }

    WgContainer().basePresenter.doWithLoading(() async {
      await WgContainer().postPresenter.following(
          limit: 10,
          afterId: refresh && _vm.followingPosts.isNotEmpty
              ? _vm.followingPosts.first.id
              : null,
          beforeId: !refresh && _vm.followingPosts.isNotEmpty
              ? _vm.followingPosts.last.id
              : null);
    });
  }

  Future<void> _loadHotPosts({
    bool refresh = false,
  }) async {
    if (!refresh && _vm.hotPostsAllLoaded) {
      return;
    }

    WgContainer().basePresenter.doWithLoading(() async {
      await WgContainer()
          .postPresenter
          .hot(limit: 10, offset: refresh ? 0 : _vm.hotPosts.length);
    });
  }

  Future<void> _refresh() async {
    if (_vm.postListType == PostListType.FOLLOWING) {
      await _loadFollowingPosts(refresh: true);
    } else {
      await _loadHotPosts(refresh: true);
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.extentAfter < 500) {
        if (_vm.postListType == PostListType.FOLLOWING) {
          _loadFollowingPosts();
        } else {
          _loadHotPosts();
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeVM>(
      onInitialBuild: (vm) {
        if (_vm.postListType == PostListType.FOLLOWING) {
          _loadFollowingPosts(refresh: true);
        } else {
          _loadHotPosts(refresh: true);
        }
      },
      converter: (store) {
        _vm = HomeVM(
          postListType: store.state.page.homeMode,
          followingPosts: store.state.post.followingPosts,
          followingPostsAllLoaded: store.state.post.followingPostsAllLoaded,
          hotPosts: store.state.post.hotPosts,
          hotPostsAllLoaded: store.state.post.hotPostsAllLoaded,
        );
        return _vm;
      },
      distinct: true,
      builder: (context, vm) {
        if (vm.postListType == PostListType.FOLLOWING) {
          if (vm.followingPosts.length == 0) {
            return Center(
              child: Text(
                '关注动态为空，可从右上角选择浏览热门。',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Theme.of(context).hintColor),
              ),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: vm.followingPosts.length,
                itemBuilder: (context, index) => PostTile(
                  key: ValueKey(vm.followingPosts[index].id),
                  post: vm.followingPosts[index],
                ),
              ),
            ),
          );
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: vm.hotPosts.length,
                itemBuilder: (context, index) => PostTile(
                  key: ValueKey(vm.hotPosts[index].id),
                  post: vm.hotPosts[index],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
