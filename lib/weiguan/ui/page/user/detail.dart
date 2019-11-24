import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../entity/entity.dart';
import '../../../util/util.dart';
import '../../../container.dart';
import '../../ui.dart';

class UserDetailPage extends StatelessWidget {
  final int userId;

  UserDetailPage({
    @required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Body(userId: userId),
    );
  }
}

class _Body extends StatefulWidget {
  final int userId;

  _Body({@required this.userId});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  static final tabs = [
    Tab(text: '动态'),
    Tab(text: '喜欢'),
    Tab(text: '关注'),
  ];

  TabController _tabController;
  Map<Tab, bool> _tabTapped = {};
  Map<String, bool> _loadeds = {};
  UserEntity _user;
  List<PostEntity> _publishedPosts = [];
  List<PostEntity> _likedPosts = [];
  List<UserEntity> _followingUsers = [];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: tabs.length);
    _tabController.addListener(() {
      final tab = tabs[_tabController.index];
      if (_tabTapped[tab] ?? false) {
        return;
      }
      _tabTapped[tab] = true;

      if (tab.text == '动态') {
        _loadPublishedPosts();
      } else if (tab.text == '喜欢') {
        _loadLikedPosts();
      } else if (tab.text == '关注') {
        _loadFollowingUsers();
      }
    });

    _loadUser();
    _tabTapped[tabs[0]] = true;
    _loadPublishedPosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadUser() async {
    WgContainer().basePresenter.doWithLoading(() async {
      final user = await WgContainer().userPresenter.info(widget.userId);

      setState(() {
        _user = user;
      });
    });
  }

  void _loadPublishedPosts() async {
    if (_loadeds['publishedPosts'] ?? false) {
      return;
    }

    WgContainer().basePresenter.doWithLoading(() async {
      final posts = await WgContainer().postPresenter.published(
          userId: widget.userId, limit: 10, offset: _publishedPosts.length);

      setState(() {
        _loadeds['publishedPosts'] = posts.length < 10;
        _publishedPosts.addAll(posts);
      });
    });
  }

  void _loadLikedPosts() async {
    if (_loadeds['likedPosts'] ?? false) {
      return;
    }

    WgContainer().basePresenter.doWithLoading(() async {
      final posts = await WgContainer()
          .postPresenter
          .liked(userId: widget.userId, limit: 10, offset: _likedPosts.length);

      setState(() {
        _loadeds['likedPosts'] = posts.length < 10;
        _likedPosts.addAll(posts);
      });
    });
  }

  void _loadFollowingUsers() async {
    if (_loadeds['followingUsers'] ?? false) {
      return;
    }

    WgContainer().basePresenter.doWithLoading(() async {
      final users = await WgContainer().userPresenter.following(
          userId: widget.userId, limit: 20, offset: _followingUsers.length);

      setState(() {
        _loadeds['followingUsers'] = users.length < 20;
        _followingUsers.addAll(users);
      });
    });
  }

  void _followUser() async {
    WgContainer().basePresenter.doWithLoading(() async {
      await WgContainer().userPresenter.follow(widget.userId);

      setState(() {
        _user = _user.copyWith(following: true);
      });
    });
  }

  void _unfollowUser() async {
    WgContainer().basePresenter.doWithLoading(() async {
      await WgContainer().userPresenter.unfollow(widget.userId);

      setState(() {
        _user = _user.copyWith(following: false);
      });
    });
  }

  Widget _buildSilverAppBar(BuildContext context, bool innerBoxIsScrolled) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      child: SliverAppBar(
        actions: [
          FlatButton(
            onPressed: () {
              if (_user.following) {
                _unfollowUser();
              } else {
                _followUser();
              }
            },
            child: Text(
              _user.following ? '取消关注' : '关注',
              style: Theme.of(context).primaryTextTheme.subhead,
            ),
          ),
        ],
        expandedHeight: MediaQuery.of(context).size.width * 3 / 4,
        forceElevated: innerBoxIsScrolled,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            image: _user.avatar == null
                ? null
                : DecorationImage(
                    image: CachedNetworkImageProvider(
                        _user.avatar.thumbs[FileThumbType.LARGE]),
                    fit: BoxFit.cover,
                  ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _user.username,
                  style: Theme.of(context).primaryTextTheme.title,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  _user.intro,
                  maxLines: 3,
                  style: Theme.of(context).primaryTextTheme.subhead,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      formatNumber(_user.stat?.postCount ?? 0),
                      style: Theme.of(context).primaryTextTheme.body2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: WgContainer().theme.paddingSizeSmall,
                      ),
                      child: Text(
                        '动态',
                        style: Theme.of(context).primaryTextTheme.caption,
                      ),
                    ),
                    Text(
                      formatNumber(_user.stat?.likeCount ?? 0),
                      style: Theme.of(context).primaryTextTheme.body2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: WgContainer().theme.paddingSizeSmall,
                      ),
                      child: Text(
                        '喜欢',
                        style: Theme.of(context).primaryTextTheme.caption,
                      ),
                    ),
                    Text(
                      formatNumber(_user.stat?.followingCount ?? 0),
                      style: Theme.of(context).primaryTextTheme.body2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: WgContainer().theme.paddingSizeSmall,
                      ),
                      child: Text(
                        '关注',
                        style: Theme.of(context).primaryTextTheme.caption,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottom: TabBar(controller: _tabController, tabs: tabs),
      ),
    );
  }

  Widget _buildPublishedPosts(BuildContext context, Tab tab) {
    return CustomScrollView(
      key: PageStorageKey<String>(tab.text),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => PostTile(
              key: ValueKey(_publishedPosts[index].id),
              post: _publishedPosts[index],
              onLike: () => setState(() {
                _publishedPosts[index] =
                    _publishedPosts[index].copyWith(liked: true);
              }),
              onUnlike: () => setState(() {
                _publishedPosts[index] =
                    _publishedPosts[index].copyWith(liked: false);
              }),
              onDelete: () => setState(() {
                _publishedPosts.removeAt(index);
              }),
            ),
            childCount: _publishedPosts.length,
          ),
        ),
      ],
    );
  }

  Widget _buildLikedPosts(BuildContext context, Tab tab) {
    return CustomScrollView(
      key: PageStorageKey<String>(tab.text),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => PostTile(
              key: ValueKey(_likedPosts[index].id),
              post: _likedPosts[index],
              onLike: () => setState(() {
                _likedPosts[index] = _likedPosts[index].copyWith(liked: true);
              }),
              onUnlike: () => setState(() {
                _likedPosts[index] = _likedPosts[index].copyWith(liked: false);
              }),
              onDelete: () => setState(() {
                _likedPosts.removeAt(index);
              }),
            ),
            childCount: _likedPosts.length,
          ),
        ),
      ],
    );
  }

  Widget _buildFollowingUsers(BuildContext context, Tab tab) {
    return CustomScrollView(
      key: PageStorageKey<String>(tab.text),
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => UserTile(
              key: ValueKey(_followingUsers[index].id),
              user: _followingUsers[index],
              onFollow: () => setState(() {
                _followingUsers[index] =
                    _followingUsers[index].copyWith(following: true);
              }),
              onUnfollow: () => setState(() {
                _followingUsers[index] =
                    _followingUsers[index].copyWith(following: false);
              }),
            ),
            childCount: _followingUsers.length,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: tabs
          .map((tab) => SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (context) {
                    if (tab.text == '动态') {
                      return _buildPublishedPosts(context, tab);
                    } else if (tab.text == '喜欢') {
                      return _buildLikedPosts(context, tab);
                    } else if (tab.text == '关注') {
                      return _buildFollowingUsers(context, tab);
                    } else {
                      return null;
                    }
                  },
                ),
              ))
          .toList(),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 2) {
      if (notification is ScrollEndNotification) {
        if (notification.metrics.extentAfter < 500) {
          final tab = tabs[_tabController.index];
          if (tab.text == '动态') {
            _loadPublishedPosts();
          } else if (tab.text == '喜欢') {
            _loadLikedPosts();
          } else if (tab.text == '关注') {
            _loadFollowingUsers();
          }
        }
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) return Container();

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildSilverAppBar(context, innerBoxIsScrolled),
        ],
        body: _buildTabBarView(context),
      ),
    );
  }
}
