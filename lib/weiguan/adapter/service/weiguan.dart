import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:mime/mime.dart';

import '../../entity/entity.dart';
import '../../usecase/usecase.dart';
import '../../config.dart';

class WeiguanServiceImpl implements WeiguanService {
  final WgConfig config;
  final Logger logger;
  final Dio client;

  WeiguanServiceImpl({
    @required this.config,
    @required this.logger,
    @required this.client,
  });

  Future request(String method, String path, {dynamic data}) async {
    if (config.isLogApi) {
      logger.fine('request: $method $path $data');
    }
    Response response;
    try {
      response = await client.request(
        path,
        queryParameters: data,
        data: data,
        options: Options(method: method),
      );
    } catch (e) {
      throw ServiceRequestFail('request error: $e');
    }
    if (config.isLogApi) {
      logger.fine('response: ${response.statusCode} ${response.data}');
    }

    if (response.statusCode != HttpStatus.ok) {
      throw ServiceRequestFail('response error: ${response.statusMessage}');
    }

    if (response.data['code'] == 'duplicate') {
      throw ServiceResponseDuplicate(response.data['message']);
    } else if (response.data['code'] != 'ok') {
      throw ServiceResponseFail(response.data['message']);
    }

    return response.data['data'];
  }

  Future get(String path, [Map<String, dynamic> data]) {
    data?.removeWhere((k, v) => v == null);
    return request('GET', path, data: data);
  }

  Future post(String path, Map<String, dynamic> data) {
    data?.removeWhere((k, v) => v == null);
    return request('POST', path, data: data);
  }

  Future postForm(String path, Map<String, dynamic> data) {
    data?.removeWhere((k, v) => v == null);
    return request('POST', path, data: FormData.from(data));
  }

  @override
  Future<UserEntity> accountRegister(UserEntity userEntity,
      [String code]) async {
    final data = userEntity.toJson();
    data['code'] = code;
    final response = await post('/account/register', data);
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<UserEntity> accountLogin(
      {String username, String mobile, @required String password}) async {
    assert(username != null || mobile != null);

    final response = await post('/account/login',
        {'username': username, 'mobile': mobile, 'password': password});
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<UserEntity> accountInfo() async {
    final response = await get('/account/info');
    final user = response['user'];
    return user == null ? user : UserEntity.fromJson(user);
  }

  @override
  Future<UserEntity> accountLogout() async {
    final response = await get('/account/logout');
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<UserEntity> accountModify(UserEntity userEntity, [String code]) async {
    final data = userEntity.toJson();
    data['code'] = code;
    final response = await post('/account/modify', data);
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<String> accountSendMobileVerifyCode(String type, String mobile) async {
    final response = await post(
        '/account/send/mobile/verify/code', {'type': type, 'mobile': mobile});
    return response['verifyCode'];
  }

  @override
  Future<PostEntity> postPublish(PostEntity postEntity) async {
    final response = await post('/post/publish', postEntity.toJson());
    return PostEntity.fromJson(response['post']);
  }

  @override
  Future<void> postDelete(int postId) async {
    await post('/post/delete', {'postId': postId});
  }

  @override
  Future<PostEntity> postInfo(int postId) async {
    final response = await get('/post/info', {'postId': postId});
    return PostEntity.fromJson(response['post']);
  }

  @override
  Future<List<PostEntity>> postPublished(
      {@required int userId, int limit = 10, int offset = 0}) async {
    final response = await get(
      '/post/published',
      {
        'userId': userId,
        'limit': limit,
        'offset': offset,
      },
    );
    return (response['posts'] as List<dynamic>)
        .map((v) => PostEntity.fromJson(v))
        .toList();
  }

  @override
  Future<void> postLike(int postId) async {
    await post('/post/like', {'postId': postId});
  }

  @override
  Future<void> postUnlike(int postId) async {
    await post('/post/unlike', {'postId': postId});
  }

  @override
  Future<List<PostEntity>> postLiked(
      {@required int userId, int limit = 10, int offset = 0}) async {
    final response = await get(
      '/post/liked',
      {
        'userId': userId,
        'limit': limit,
        'offset': offset,
      },
    );
    return (response['posts'] as List<dynamic>)
        .map((v) => PostEntity.fromJson(v))
        .toList();
  }

  @override
  Future<List<PostEntity>> postFollowing(
      {int limit = 10, int beforeId, int afterId}) async {
    final response = await get(
      '/post/following',
      {
        'limit': limit,
        'beforeId': beforeId,
        'afterId': afterId,
      },
    );
    return (response['posts'] as List<dynamic>)
        .map((v) => PostEntity.fromJson(v))
        .toList();
  }

  @override
  Future<List<FileEntity>> storageUpload(
      {String region,
      String bucket,
      String path,
      @required List<String> files}) async {
    final Map<String, dynamic> data = {
      'region': region,
      'bucket': bucket,
      'path': path
    };

    data['files'] = files
        .map(
          (v) => UploadFileInfo(File(v), basename(v),
              contentType: ContentType.parse(lookupMimeType(v))),
        )
        .toList();
    final response = await postForm('/storage/upload', data);
    return (response['files'] as List<dynamic>)
        .map((v) => FileEntity.fromJson(v))
        .toList();
  }

  @override
  Future<UserEntity> userInfo(int userId) async {
    final response = await get('/user/info', {'userId': userId});
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<void> userFollow(int followingId) async {
    await post('/user/follow', {'followingId': followingId});
  }

  @override
  Future<void> userUnfollow(int followingId) async {
    await post('/user/unfollow', {'followingId': followingId});
  }

  @override
  Future<List<UserEntity>> userFollowings(
      {@required int userId, int limit = 10, int offset = 0}) async {
    final response = await get(
      '/user/followings',
      {
        'userId': userId,
        'limit': limit,
        'offset': offset,
      },
    );
    return (response['users'] as List<dynamic>)
        .map((v) => UserEntity.fromJson(v))
        .toList();
  }

  @override
  Future<List<UserEntity>> userFollowers(
      {@required int userId, int limit = 10, int offset = 0}) async {
    final response = await get(
      '/user/followers',
      {
        'userId': userId,
        'limit': limit,
        'offset': offset,
      },
    );
    return (response['users'] as List<dynamic>)
        .map((v) => UserEntity.fromJson(v))
        .toList();
  }
}
