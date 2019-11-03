import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../container.dart';
import '../../../utils/utils.dart';
import '../../../entities/entities.dart';
import '../../../services/services.dart';
import '../../components/components.dart';

class UserDetailPage extends StatelessWidget {
  static final tabs = [
    Tab(text: '动态'),
    Tab(text: '喜欢'),
    Tab(text: '关注'),
  ];

  final int userId;

  UserDetailPage({
    @required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: _Body(
          tabs: tabs,
          userId: userId,
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final List<Tab> tabs;
  final int userId;

  _Body({
    @required this.tabs,
    @required this.userId,
  });

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  Store<AppState> _store;
  Map<String, bool> _loadings = {};
  Map<String, bool> _loadeds = {};
  UserEntity _user;
  List<PostEntity> _publishedPosts = [];
  List<PostEntity> _likedPosts = [];
  List<UserEntity> _followingUsers = [];

  void _loadUser() {
    setState(() {
      _loadings['user'] = true;
    });
    _store.dispatch(userInfoAction(
      id: widget.userId,
      onSuccess: (user) {
        setState(() {
          _loadings['user'] = false;
          _user = user;
        });
      },
      onFailure: (notice) {
        setState(() {
          _loadings['user'] = false;
        });
        showSnackBar(context, notice);
      },
    ));
  }

  void _loadPublishedPosts() {
    if (_loadeds['publishedPosts'] ?? false) {
      return;
    }

    setState(() {
      _loadings['publishedPosts'] = true;
    });
    _store.dispatch(postPublishedAction(
      userId: widget.userId,
      limit: 10,
      offset: _publishedPosts.length,
      onSuccess: (posts) {
        setState(() {
          _loadings['publishedPosts'] = false;
          _loadeds['publishedPosts'] = posts.length < 10;
          _publishedPosts.addAll(posts);
        });
      },
      onFailure: (notice) {
        setState(() {
          _loadings['publishedPosts'] = false;
        });
        showSnackBar(context, notice);
      },
    ));
  }

  void _loadLikedPosts() {
    if (_loadeds['likedPosts'] ?? false) {
      return;
    }

    setState(() {
      _loadings['likedPosts'] = true;
    });
    _store.dispatch(postLikedAction(
      userId: widget.userId,
      limit: 10,
      offset: _likedPosts.length,
      onSuccess: (posts) {
        setState(() {
          _loadings['likedPosts'] = false;
          _loadeds['likedPosts'] = posts.length < 10;
          _likedPosts.addAll(posts);
        });
      },
      onFailure: (notice) {
        setState(() {
          _loadings['likedPosts'] = false;
        });
        showSnackBar(context, notice);
      },
    ));
  }

  void _loadFollowingUsers() {
    if (_loadeds['followingUsers'] ?? false) {
      return;
    }

    setState(() {
      _loadings['followingUsers'] = true;
    });
    _store.dispatch(userFollowingsAction(
      userId: widget.userId,
      limit: 20,
      offset: _followingUsers.length,
      onSuccess: (users) {
        setState(() {
          _loadings['followingUsers'] = false;
          _loadeds['followingUsers'] = users.length < 20;
          _followingUsers.addAll(users);
        });
      },
      onFailure: (notice) {
        setState(() {
          _loadings['followingUsers'] = false;
        });
        showSnackBar(context, notice);
      },
    ));
  }

  void _followUser() {
    setState(() {
      _loadings['followUser'] = true;
    });
    _store.dispatch(userFollowAction(
        followingId: widget.userId,
        onSuccess: () {
          setState(() {
            _loadings['followUser'] = false;
            _user = _user.copyWith(isFollowing: true);
          });
        },
        onFailure: (notice) {
          setState(() {
            _loadings['followUser'] = false;
          });
          showSnackBar(context, notice);
        }));
  }

  void _unfollowUser() {
    setState(() {
      _loadings['unfollowUser'] = true;
    });
    _store.dispatch(userUnfollowAction(
      followingId: widget.userId,
      onSuccess: () {
        setState(() {
          _loadings['unfollowUser'] = false;
          _user = _user.copyWith(isFollowing: false);
        });
      },
      onFailure: (notice) {
        setState(() {
          _loadings['unfollowUser'] = false;
        });
        showSnackBar(context, notice);
      },
    ));
  }

  Widget _buildSilverAppBar(BuildContext context, bool innerBoxIsScrolled) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      child: SliverAppBar(
        actions: [
          FlatButton(
            onPressed: () {
              if (_user.isFollowing) {
                _unfollowUser();
              } else {
                _followUser();
              }
            },
            child: Text(
              _user.isFollowing ? '取消关注' : '关注',
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
                        _user.avatar.thumbs[FileThumbType.large]),
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
        bottom: TabBar(tabs: widget.tabs),
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
                    _publishedPosts[index].copyWith(isLiked: true);
              }),
              onUnlike: () => setState(() {
                _publishedPosts[index] =
                    _publishedPosts[index].copyWith(isLiked: false);
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
                _likedPosts[index] = _likedPosts[index].copyWith(isLiked: true);
              }),
              onUnlike: () => setState(() {
                _likedPosts[index] =
                    _likedPosts[index].copyWith(isLiked: false);
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
                    _followingUsers[index].copyWith(isFollowing: true);
              }),
              onUnfollow: () => setState(() {
                _followingUsers[index] =
                    _followingUsers[index].copyWith(isFollowing: false);
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
      children: widget.tabs
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
          final index = DefaultTabController.of(context).index;
          if (index == 0) {
            _loadPublishedPosts();
          } else if (index == 1) {
            _loadLikedPosts();
          } else if (index == 2) {
            _loadFollowingUsers();
          }
        }
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Null>(
      onInit: (store) {
        _store = store;
      },
      converter: (store) => null,
      distinct: true,
      onInitialBuild: (vm) {
        _loadUser();
        _loadPublishedPosts();
        _loadLikedPosts();
        _loadFollowingUsers();
      },
      builder: (context, vm) => Stack(
        children: [
          if (_user != null)
            NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  _buildSilverAppBar(context, innerBoxIsScrolled),
                ],
                body: _buildTabBarView(context),
              ),
            ),
          Visibility(
            visible: _loadings.values.any((v) => v),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
