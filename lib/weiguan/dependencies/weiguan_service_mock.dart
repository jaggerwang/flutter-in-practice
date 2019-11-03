import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import 'package:dio/dio.dart';

import '../config.dart';
import '../utils/utils.dart';
import '../interfaces/interfaces.dart';

class WgServiceMock implements IWgService {
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

  WgServiceMock({
    @required this.config,
    @required this.logger,
  }) {
    onReady = Future(() async {
      _files = await _loadData('assets/weiguan/files.json');

      _userStats = await _loadData('assets/weiguan/user_stats.json');
      _postStats = await _loadData('assets/weiguan/post_stats.json');

      _users = await _loadData('assets/weiguan/users.json');
      _users.values.forEach((user) {
        if (user['avatarId'] != null) {
          user['avatar'] = _files[user['avatarId']];
        }
        user['stat'] = _userStats[
            _userStats.keys.elementAt(_random.nextInt(_userStats.length))];
      });

      _posts = await _loadData('assets/weiguan/posts.json');
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

  Future<Map<int, Map<String, dynamic>>> _loadData(String key) async {
    final l = jsonDecode(await rootBundle.loadString(key)) as List;
    return Map.fromEntries(l.map((v) => MapEntry(v['id'], v)));
  }

  Future<WgResponse> _request(
    String method,
    String path, {
    dynamic data,
  }) async {
    if (config.isLogApi) {
      logger.fine('request: $method $path $data');
    }
    Map<String, dynamic> response;
    try {
      response = await _api(path)(method, data);
    } catch (e) {
      return WgResponse(
        code: WgResponse.codeError,
        message: 'request error: $e',
      );
    }
    if (config.isLogApi) {
      logger.fine('response: 200 $response');
    }

    return WgResponse(
      code: response['code'],
      message: response['message'],
      data: response['data'],
    );
  }

  Future<WgResponse> get(String path, [Map<String, dynamic> data]) async {
    data?.removeWhere((k, v) => v == null);
    return _request('GET', path, data: data);
  }

  Future<WgResponse> post(String path, Map<String, dynamic> data) async {
    data?.removeWhere((k, v) => v == null);
    return _request('POST', path, data: data);
  }

  Future<WgResponse> postForm(String path, Map<String, dynamic> data) async {
    data?.removeWhere((k, v) => v == null);
    return _request('POST', path, data: FormData.from(data));
  }

  Future<Map<String, dynamic>> Function(String, dynamic) _api(String path) {
    switch (path) {
      case '/account/register':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                _userId = 1;

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'user': _users[_userId],
                  },
                };
              },
            );
      case '/account/login':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                _userId = 1;

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'user': _users[_userId],
                  },
                };
              },
            );
      case '/account/logout':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                final user = _users[_userId];
                _userId = null;

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'user': user,
                  },
                };
              },
            );
      case '/account/info':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'user': _users[_userId],
                  },
                };
              },
            );
      case '/account/modify':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                _users[_userId]
                  ..update('username', (v) => data['username'] ?? v)
                  ..update('mobile', (v) => data['mobile'] ?? v)
                  ..update('email', (v) => data['email'] ?? v)
                  ..update('avatarId', (v) => data['avatarId'] ?? v)
                  ..update('intro', (v) => data['intro'] ?? v);

                if (data['avatarId'] != null) {
                  _users[_userId]['avatar'] = _files[data['avatarId']];
                }

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'user': _users[_userId],
                  },
                };
              },
            );
      case '/account/send/mobile/verify/code':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                final verifyCode = randomString(
                    6,
                    String.fromCharCodes(
                        List.generate(10, (i) => '0'.codeUnitAt(0) + i)));

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'verifyCode': verifyCode,
                  },
                };
              },
            );
      case '/user/info':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                final user = _users[data['id']];

                if (_userId != null) {
                  final followingUserIds = _followingUserIds[_userId] ?? [];
                  user['isFollowing'] = followingUserIds.contains(user['id']);
                }
                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'user': user,
                  },
                };
              },
            );
      case '/user/follow':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                _followerUserIds[_userId] ??= [];
                _followerUserIds[_userId].insert(0, data['followingId']);

                return {
                  'code': 'ok',
                  'message': '',
                  'data': null,
                };
              },
            );
      case '/user/unfollow':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                _followerUserIds[_userId]
                    ?.removeWhere((v) => v == data['followingId']);

                return {
                  'code': 'ok',
                  'message': '',
                  'data': null,
                };
              },
            );
      case '/user/followings':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                final followingUserIds =
                    _followingUserIds[data['userId']] ?? [];

                final users = followingUserIds
                    .skip(data['offset'])
                    .take(data['limit'])
                    .map((v) => _users[v])
                    .toList();

                if (_userId != null) {
                  final followingUserIds = _followingUserIds[_userId] ?? [];
                  users.forEach((user) {
                    user['isFollowing'] = followingUserIds.contains(user['id']);
                  });
                }

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'users': users,
                    'total': followingUserIds.length,
                  },
                };
              },
            );
      case '/user/followers':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                final followerUserIds = _followerUserIds[data['userId']] ?? [];

                final users = followerUserIds
                    .skip(data['offset'])
                    .take(data['limit'])
                    .map((v) => _users[v])
                    .toList();

                if (_userId != null) {
                  final followingUserIds = _followingUserIds[_userId] ?? [];
                  users.forEach((user) {
                    user['isFollowing'] = followingUserIds.contains(user['id']);
                  });
                }

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'users': users,
                    'total': followerUserIds.length,
                  },
                };
              },
            );
      case '/post/publish':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                _publishedPostIds[_userId] ??= [];

                final id = _publishedPostIds[_userId].length > 0
                    ? _publishedPostIds[_userId].first + 1
                    : 1;
                _publishedPostIds[_userId].insert(0, id);

                final post = Map<String, dynamic>.from(
                    _posts.values.firstWhere((v) => v['type'] == data['type']));
                post['id'] = id;

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    "post": post,
                  },
                };
              },
            );
      case '/post/delete':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                _publishedPostIds[_userId]?.remove(data['id']);

                final post = Map<String, dynamic>.from(_posts[
                    _posts.keys.elementAt(_random.nextInt(_posts.length))]);
                post['id'] = data['id'];

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'post': post,
                  },
                };
              },
            );
      case '/post/info':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                final post = Map<String, dynamic>.from(_posts[
                    _posts.keys.elementAt(_random.nextInt(_posts.length))]);
                post['id'] = data['id'];

                if (_userId != null) {
                  final likedPostIds = _likedPostIds[_userId] ?? [];
                  post['isLiked'] = likedPostIds.contains(post['id']);
                }

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'post': post,
                  },
                };
              },
            );
      case '/post/published':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                final publishedPostIds = _publishedPostIds[_userId] ?? [];

                final posts = publishedPostIds
                    .skip(data['offset'])
                    .take(data['limit'])
                    .map((v) {
                  final post = Map<String, dynamic>.from(_posts[
                      _posts.keys.elementAt(_random.nextInt(_posts.length))]);
                  post['id'] = v;
                  return post;
                }).toList();

                if (_userId != null) {
                  final likedPostIds = _likedPostIds[_userId] ?? [];
                  posts.forEach((post) {
                    post['isLiked'] = likedPostIds.contains(post['id']);
                  });
                }

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'posts': posts,
                    'total': publishedPostIds.length,
                  },
                };
              },
            );
      case '/post/like':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                _likedPostIds[_userId] ??= [];
                _likedPostIds[_userId].insert(0, data['postId']);

                return {
                  'code': 'ok',
                  'message': '',
                  'data': null,
                };
              },
            );
      case '/post/unlike':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                _likedPostIds[_userId]?.removeWhere((v) => v == data['postId']);

                return {
                  'code': 'ok',
                  'message': '',
                  'data': null,
                };
              },
            );
      case '/post/liked':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                final likedPostIds = _likedPostIds[data['userId']] ?? [];

                final posts = likedPostIds
                    .skip(data['offset'])
                    .take(data['limit'])
                    .map((v) {
                  final post = Map<String, dynamic>.from(_posts[
                      _posts.keys.elementAt(_random.nextInt(_posts.length))]);
                  post['id'] = v;
                  return post;
                }).toList();

                if (_userId != null) {
                  final likedPostIds = _likedPostIds[_userId] ?? [];
                  posts.forEach((post) {
                    post['isLiked'] = likedPostIds.contains(post['id']);
                  });
                }

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'posts': posts,
                    'total': likedPostIds.length,
                  },
                };
              },
            );
      case '/post/following':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                List<int> followingPostIds;
                if (data['beforeId'] != null) {
                  followingPostIds = _followingPostIds
                      .where((v) => v < data['beforeId'])
                      .take(data['limit'])
                      .toList();
                } else if (data['afterId'] != null) {
                  followingPostIds = _followingPostIds
                      .where((v) => v > data['afterId'])
                      .toList()
                      .reversed
                      .take(data['limit'])
                      .toList()
                      .reversed
                      .toList();
                } else {
                  followingPostIds =
                      _followingPostIds.skip(3).take(data['limit']).toList();
                }

                final posts = followingPostIds.map((v) {
                  final post = Map<String, dynamic>.from(_posts[
                      _posts.keys.elementAt(_random.nextInt(_posts.length))]);
                  post['id'] = v;
                  return post;
                }).toList();

                if (_userId != null) {
                  final likedPostIds = _likedPostIds[_userId] ?? [];
                  posts.forEach((post) {
                    post['isLiked'] = likedPostIds.contains(post['id']);
                  });
                }

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    'posts': posts,
                    'total': _followingPostIds.length,
                  },
                };
              },
            );
      case '/storage/upload':
        return (String method, dynamic data) => Future.delayed(
              Duration(
                milliseconds: 500 + _random.nextInt(500),
              ),
              () {
                final files = (data['files'] as List<UploadFileInfo>).map((v) {
                  final filesOfType = _files.values
                      .where((v1) =>
                          (v1['meta']['type'] as String).split('/')[0] ==
                          v.contentType.mimeType.split('/')[0])
                      .toList();
                  return filesOfType[_random.nextInt(filesOfType.length)];
                }).toList();

                return {
                  'code': 'ok',
                  'message': '',
                  'data': {
                    "files": files,
                  },
                };
              },
            );
      default:
        return null;
    }
  }
}
