import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:mime/mime.dart';
import 'package:redux/redux.dart';

import '../../entity/entity.dart';
import '../../ui/ui.dart';
import '../../usecase/usecase.dart';
import '../../config.dart';

class WeiguanRestService implements WeiguanService {
  final WgConfig config;
  final Store<AppState> appStore;
  final Logger logger;
  final Dio client;

  WeiguanRestService({
    @required this.config,
    @required this.appStore,
    @required this.logger,
    @required this.client,
  });

  Future<Map<String, dynamic>> request(String method, String path,
      [Map<String, dynamic> data]) async {
    if (config.logApi) {
      logger.fine('$method $path $data');
    }
    Response response;
    try {
      final Map<String, dynamic> headers = {};
      final oAuth2State = appStore.state.oauth2;
      if (config.enableOAuth2Login && oAuth2State.accessToken != null) {
        headers['authorization'] = 'Bearer ' + oAuth2State.accessToken;
      }

      response = await client.request(
        path,
        queryParameters: method == 'GET' ? data : null,
        data: method == 'POST' ? data : null,
        options: Options(method: method),
      );
    } catch (e) {
      throw ServiceException('fail', '$e');
    }
    if (config.logApi) {
      logger.fine('${response.statusCode} ${response.data}');
    }

    var result = response.data;
    if (response.statusCode == 401 || result['code'] == 'unauthenticated') {
      throw UnauthenticatedException("未认证");
    }

    if (result['code'] != 'ok') {
      throw ServiceException(result['code'], result['message']);
    }

    return result['data'];
  }

  Future<Map<String, dynamic>> get(String path, [Map<String, dynamic> data]) {
    data?.removeWhere((k, v) => v == null);
    return request('GET', path, data);
  }

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> data,
      [List<String> files]) {
    data?.removeWhere((k, v) => v == null);

    if ((files ?? []).length > 0) {
      data['file'] = files
          .map(
            (v) => UploadFileInfo(File(v), basename(v),
                contentType: ContentType.parse(lookupMimeType(v))),
          )
          .toList();
      return request('POST', path, FormData.from(data));
    } else {
      return request('POST', path, data);
    }
  }

  @override
  Future<UserEntity> userRegister(UserEntity userEntity) async {
    final response = await post('/user/register', userEntity.toJson());
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<UserEntity> userLogin(String username, String password) async {
    final response =
        await post('/user/login', {'username': username, 'password': password});
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<UserEntity> userLogged() async {
    final response = await get('/user/logged');
    return response['user'] == null
        ? response['user']
        : UserEntity.fromJson(response['user']);
  }

  @override
  Future<UserEntity> userLogout() async {
    final response = await get('/user/logout');
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<UserEntity> userModify(UserEntity userEntity, [String code]) async {
    final response = await post('/user/modify', {
      'user': userEntity.toJson(),
      'code': code,
    });
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<UserEntity> userInfo(int id) async {
    final response = await get('/user/info', {'id': id});
    return UserEntity.fromJson(response['user']);
  }

  @override
  Future<void> userFollow(int userId) async {
    await post('/user/follow', {'userId': userId});
  }

  @override
  Future<void> userUnfollow(int userId) async {
    await post('/user/unfollow', {'userId': userId});
  }

  @override
  Future<List<UserEntity>> userFollowing(
      {int userId, int limit = 10, int offset = 0}) async {
    final response = await get(
      '/user/following',
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
  Future<List<UserEntity>> userFollower(
      {int userId, int limit = 10, int offset = 0}) async {
    final response = await get(
      '/user/follower',
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
  Future<String> userSendMobileVerifyCode(String type, String mobile) async {
    final response = await post(
        '/user/sendMobileVerifyCode', {'type': type, 'mobile': mobile});
    return response['verifyCode'];
  }

  @override
  Future<PostEntity> postPublish(PostEntity postEntity) async {
    final response = await post('/post/publish', postEntity.toJson());
    return PostEntity.fromJson(response['post']);
  }

  @override
  Future<void> postDelete(int id) async {
    await post('/post/delete', {'id': id});
  }

  @override
  Future<PostEntity> postInfo(int id) async {
    final response = await get('/post/info', {'id': id});
    return PostEntity.fromJson(response['post']);
  }

  @override
  Future<List<PostEntity>> postPublished(
      {int userId, int limit = 10, int offset = 0}) async {
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
      {int userId, int limit = 10, int offset = 0}) async {
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
  Future<List<FileEntity>> fileUpload(List<String> files,
      {String region, String bucket, String path}) async {
    final response = await post('/file/upload',
        {'region': region, 'bucket': bucket, 'path': path}, files);
    return (response['files'] as List<dynamic>)
        .map((v) => FileEntity.fromJson(v))
        .toList();
  }
}
