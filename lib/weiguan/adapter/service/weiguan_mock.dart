import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

import '../../entity/entity.dart';
import '../../usecase/usecase.dart';
import '../../util/util.dart';
import '../../config.dart';

class WeiguanMockService implements WeiguanService {
  final WgConfig config;
  final Logger logger;
  final Dio client = null;
  Future<void> onReady;

  final _random = Random();

  Map<int, Map<String, dynamic>> _files;
  Map<int, Map<String, dynamic>> _userStats;
  Map<int, Map<String, dynamic>> _postStats;
  Map<int, Map<String, dynamic>> _users;
  Map<int, Map<String, dynamic>> _posts;

  final _followingUserIds = {
    1: [2, 3],
    2: [1],
  };
  final _followerUserIds = {
    1: [2],
    2: [1],
    3: [1],
  };
  final _publishedPostIds = {
    1: List.generate(11, (i) => 11 - i),
  };
  final _likedPostIds = {
    1: [11, 7, 3],
  };
  final _followingPostIds = List.generate(21, (i) => 21 - i);
  int _userId;

  WeiguanMockService({
    @required this.config,
    @required this.logger,
  }) {
    onReady = Future(() async {
      _files = await loadData('assets/weiguan/files.json');

      _userStats = await loadData('assets/weiguan/user_stats.json');
      _postStats = await loadData('assets/weiguan/post_stats.json');

      _users = await loadData('assets/weiguan/users.json');
      _users.values.forEach((user) {
        if (user['avatarId'] != null) {
          user['avatar'] = _files[user['avatarId']];
        }
        user['stat'] = _userStats[
            _userStats.keys.elementAt(_random.nextInt(_userStats.length))];
      });

      _posts = await loadData('assets/weiguan/posts.json');
      _posts.values.forEach((post) {
        post['user'] = _users[post['userId']];

        post['images'] =
            (post['imageIds'] as List).map((v) => _files[v]).toList();

        post['video'] = _files[post['videoId']];

        post['stat'] = _postStats[
            _postStats.keys.elementAt(_random.nextInt(_postStats.length))];
      });
    });
  }

  Future<Map<int, Map<String, dynamic>>> loadData(String key) async {
    final l = jsonDecode(await rootBundle.loadString(key)) as List;
    return Map.fromEntries(l.map((v) => MapEntry(v['id'], v)));
  }

  @override
  Future<UserEntity> authLogin(String username, String password) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        _userId = 1;

        return {
          'user': _users[_userId],
        };
      },
    );
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<UserEntity> authLogout() async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        final user = _users[_userId];
        _userId = null;

        return {
          'user': user,
        };
      },
    );
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<UserEntity> authLogged() async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        return {
          'user': _users[_userId],
        };
      },
    );
    final user = response['user'];
    return user == null ? null : UserEntity.fromJson(user);
  }

  @override
  Future<UserEntity> userRegister(UserEntity userEntity) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        _userId = 1;

        return {
          'user': _users[_userId],
        };
      },
    );
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<UserEntity> userModify(UserEntity userEntity, [String code]) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        _users[_userId]
          ..update('username', (v) => userEntity.username ?? v)
          ..update('mobile', (v) => userEntity.mobile ?? v)
          ..update('email', (v) => userEntity.email ?? v)
          ..update('avatarId', (v) => userEntity.avatarId ?? v)
          ..update('intro', (v) => userEntity.intro ?? v);

        if (userEntity.avatarId != null) {
          _users[_userId]['avatar'] = _files[userEntity.avatarId];
        }

        return {
          'user': _users[_userId],
        };
      },
    );
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<UserEntity> userInfo(int id) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        final user = _users[id];

        if (_userId != null) {
          final followingUserIds = _followingUserIds[_userId] ?? [];
          user['following'] = followingUserIds.contains(user['id']);
        }
        return {
          'user': user,
        };
      },
    );
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<void> userFollow(int userId) async {
    await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        _followerUserIds[_userId] ??= [];
        _followerUserIds[_userId].insert(0, userId);

        return null;
      },
    );
  }

  @override
  Future<void> userUnfollow(int userId) async {
    await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        _followerUserIds[_userId]?.removeWhere((v) => v == userId);

        return null;
      },
    );
  }

  @override
  Future<List<UserEntity>> userFollowing(
      {int userId, int limit = 10, int offset = 0}) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        userId = userId ?? _userId;
        final followingUserIds = _followingUserIds[userId] ?? [];

        final users = followingUserIds
            .skip(offset)
            .take(limit)
            .map((v) => _users[v])
            .toList();

        if (_userId != null) {
          final followingUserIds = _followingUserIds[_userId] ?? [];
          users.forEach((user) {
            user['following'] = followingUserIds.contains(user['id']);
          });
        }

        return {'users': users};
      },
    );
    return response['users'].map((v) => UserEntity.fromJson(v)).toList();
  }

  @override
  Future<List<UserEntity>> userFollower(
      {int userId, int limit = 10, int offset = 0}) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        userId = userId ?? _userId;
        final followerUserIds = _followerUserIds[userId] ?? [];

        final users = followerUserIds
            .skip(offset)
            .take(limit)
            .map((v) => _users[v])
            .toList();

        if (_userId != null) {
          final followingUserIds = _followingUserIds[_userId] ?? [];
          users.forEach((user) {
            user['following'] = followingUserIds.contains(user['id']);
          });
        }

        return {'users': users};
      },
    );
    return response['users'].map((v) => UserEntity.fromJson(v)).toList();
  }

  @override
  Future<String> userSendMobileVerifyCode(String type, String mobile) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        final verifyCode = randomString(
            6,
            String.fromCharCodes(
                List.generate(10, (i) => '0'.codeUnitAt(0) + i)));

        return {
          'verifyCode': verifyCode,
        };
      },
    );
    return response['verifyCode'];
  }

  @override
  Future<PostEntity> postPublish(PostEntity postEntity) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        _publishedPostIds[_userId] ??= [];

        final id = _publishedPostIds[_userId].length > 0
            ? _publishedPostIds[_userId].first + 1
            : 1;
        _publishedPostIds[_userId].insert(0, id);

        final post = Map<String, dynamic>.from(_posts.values
            .firstWhere((v) => v['type'] == postEntity.toJson()['type']));
        post['id'] = id;

        return {
          "post": post,
        };
      },
    );
    return PostEntity.fromJson(response['post']);
  }

  @override
  Future<void> postDelete(int postId) async {
    await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        _publishedPostIds[_userId]?.remove(postId);

        final post = Map<String, dynamic>.from(
            _posts[_posts.keys.elementAt(_random.nextInt(_posts.length))]);
        post['id'] = postId;

        return {
          'post': post,
        };
      },
    );
  }

  @override
  Future<PostEntity> postInfo(int id) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        final post = Map<String, dynamic>.from(
            _posts[_posts.keys.elementAt(_random.nextInt(_posts.length))]);
        post['id'] = id;

        if (_userId != null) {
          final likedPostIds = _likedPostIds[_userId] ?? [];
          post['liked'] = likedPostIds.contains(post['id']);
        }

        return {
          'post': post,
        };
      },
    );
    return PostEntity.fromJson(response['post']);
  }

  @override
  Future<List<PostEntity>> postPublished(
      {int userId, int limit = 10, int offset = 0}) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        userId = userId ?? _userId;
        final publishedPostIds = _publishedPostIds[_userId] ?? [];

        final posts = publishedPostIds.skip(offset).take(limit).map((v) {
          final post = Map<String, dynamic>.from(
              _posts[_posts.keys.elementAt(_random.nextInt(_posts.length))]);
          post['id'] = v;
          return post;
        }).toList();

        if (_userId != null) {
          final likedPostIds = _likedPostIds[_userId] ?? [];
          posts.forEach((post) {
            post['liked'] = likedPostIds.contains(post['id']);
          });
        }

        return {'posts': posts};
      },
    );
    return response['posts'].map((v) => PostEntity.fromJson(v)).toList();
  }

  @override
  Future<void> postLike(int postId) async {
    await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        _likedPostIds[_userId] ??= [];
        _likedPostIds[_userId].insert(0, postId);

        return null;
      },
    );
  }

  @override
  Future<void> postUnlike(int postId) async {
    await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        _likedPostIds[_userId]?.removeWhere((v) => v == postId);

        return null;
      },
    );
  }

  @override
  Future<List<PostEntity>> postLiked(
      {int userId, int limit = 10, int offset = 0}) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        userId = userId ?? _userId;
        final likedPostIds = _likedPostIds[userId] ?? [];

        final posts = likedPostIds.skip(offset).take(limit).map((v) {
          final post = Map<String, dynamic>.from(
              _posts[_posts.keys.elementAt(_random.nextInt(_posts.length))]);
          post['id'] = v;
          return post;
        }).toList();

        if (_userId != null) {
          final likedPostIds = _likedPostIds[_userId] ?? [];
          posts.forEach((post) {
            post['liked'] = likedPostIds.contains(post['id']);
          });
        }

        return {'posts': posts};
      },
    );
    return response['posts'].map((v) => PostEntity.fromJson(v)).toList();
  }

  @override
  Future<List<PostEntity>> postFollowing(
      {int limit = 10, int beforeId, int afterId}) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        List<int> followingPostIds;
        if (beforeId != null) {
          followingPostIds =
              _followingPostIds.where((v) => v < beforeId).take(limit).toList();
        } else if (afterId != null) {
          followingPostIds = _followingPostIds
              .where((v) => v > afterId)
              .toList()
              .reversed
              .take(limit)
              .toList()
              .reversed
              .toList();
        } else {
          followingPostIds = _followingPostIds.skip(3).take(limit).toList();
        }

        final posts = followingPostIds.map((v) {
          final post = Map<String, dynamic>.from(
              _posts[_posts.keys.elementAt(_random.nextInt(_posts.length))]);
          post['id'] = v;
          return post;
        }).toList();

        if (_userId != null) {
          final likedPostIds = _likedPostIds[_userId] ?? [];
          posts.forEach((post) {
            post['liked'] = likedPostIds.contains(post['id']);
          });
        }

        return {'posts': posts};
      },
    );
    return response['posts'].map((v) => PostEntity.fromJson(v)).toList();
  }

  @override
  Future<List<FileEntity>> fileUpload(List<String> files,
      {String region, String bucket, String path}) async {
    final response = await Future.delayed(
      Duration(
        milliseconds: 500 + _random.nextInt(500),
      ),
      () {
        return {
          "files": files.map((v) {
            final filesOfType = _files.values
                .where((v1) => extension(v1['meta']['name']) == extension(v))
                .toList();
            return filesOfType[_random.nextInt(filesOfType.length)];
          }).toList(),
        };
      },
    );
    return response['files'].map((v) => FileEntity.fromJson(v)).toList();
  }
}
