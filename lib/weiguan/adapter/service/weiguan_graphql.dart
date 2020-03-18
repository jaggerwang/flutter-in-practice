import 'dart:convert';
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

class WeiguanGraphQLService implements WeiguanService {
  final WgConfig config;
  final Store<AppState> appStore;
  final Logger logger;
  final Dio client;

  WeiguanGraphQLService({
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
      // Graphql java not accept content type with charset
      // see more on https://github.com/graphql-java/graphql-java-spring/issues/16
      headers['content-type'] = 'application/json';
      final oAuth2State = appStore.state.oauth2;
      if (config.enableOAuth2Login && oAuth2State.accessToken != null) {
        headers['authorization'] = 'Bearer ' + oAuth2State.accessToken;
      }

      response = await client.request(
        path,
        queryParameters: method == 'GET' ? data : null,
        data: method == 'POST' ? data : null,
        options: Options(method: method, headers: headers),
      );
    } catch (e) {
      throw ServiceException('fail', '$e');
    }
    if (config.logApi) {
      logger.fine('${response.statusCode} ${response.data}');
    }

    final result = {'code': 'ok', 'message': '', 'data': response.data['data']};
    if ((response.data['errors'] ?? []).length > 0) {
      final error = (response.data['errors'] as List)[0];
      final extensions = (error['extensions'] ?? {}) as Map;
      result['code'] = extensions['code'] ?? 'fail';
      result['message'] = error['message'];
    }

    if (response.statusCode == 401 || result['code'] == 'unauthenticated') {
      throw UnauthenticatedException("未认证");
    }

    if (result['code'] != 'ok') {
      throw ServiceException(result['code'], result['message']);
    }

    return result['data'];
  }

  Future<Map<String, dynamic>> get(String query,
      {Map<String, dynamic> variables, String operationName}) {
    var data = {
      'query': query,
      'variables': variables == null ? null : jsonEncode(variables),
      'operationName': operationName
    };
    data.removeWhere((k, v) => v == null);
    return request('GET', '/graphql', data);
  }

  Future<Map<String, dynamic>> post(String query,
      {Map<String, dynamic> variables,
      String operationName,
      List<String> files}) {
    var data = {
      'query': query,
      'variables': variables,
      'operationName': operationName
    };
    data.removeWhere((k, v) => v == null);

    if ((files ?? []).length > 0) {
      data['file'] = files
          .map(
            (v) => UploadFileInfo(File(v), basename(v),
                contentType: ContentType.parse(lookupMimeType(v))),
          )
          .toList();
      return request('POST', '/graphql', FormData.from(data));
    } else {
      return request('POST', '/graphql', data);
    }
  }

  String userFields({
    bool id: true,
    bool username: true,
    bool mobile: true,
    bool email: true,
    bool avatarId: true,
    bool intro: true,
    bool createdAt: true,
    bool updatedAt: true,
    String avatar,
    String stat,
    bool following: false,
  }) {
    final fields = [];
    if (id) fields.add('id');
    if (username) fields.add('username');
    if (mobile) fields.add('mobile');
    if (email) fields.add('email');
    if (avatarId) fields.add('avatarId');
    if (intro) fields.add('intro');
    if (createdAt) fields.add('createdAt');
    if (updatedAt) fields.add('updatedAt');
    if (avatar != null) fields.add('avatar { $avatar }');
    if (stat != null) fields.add('stat { $stat }');
    if (following) fields.add('following');

    return fields.join(' ');
  }

  String postFields({
    bool id: true,
    bool userId: true,
    bool type: true,
    bool text: true,
    bool imageIds: true,
    bool videoId: true,
    bool createdAt: true,
    bool updatedAt: true,
    String user,
    String images,
    String video,
    String stat,
    bool liked: false,
  }) {
    final fields = [];
    if (id) fields.add('id');
    if (userId) fields.add('userId');
    if (type) fields.add('type');
    if (text) fields.add('text');
    if (imageIds) fields.add('imageIds');
    if (videoId) fields.add('videoId');
    if (createdAt) fields.add('createdAt');
    if (updatedAt) fields.add('updatedAt');
    if (user != null) fields.add('user { $user }');
    if (images != null) fields.add('images { $images }');
    if (video != null) fields.add('video { $video }');
    if (stat != null) fields.add('stat { $stat }');
    if (liked) fields.add('liked');

    return fields.join(' ');
  }

  String fileFields({
    bool id: true,
    bool userId: true,
    bool region: true,
    bool bucket: true,
    bool path: true,
    String meta: 'name size type',
    bool createdAt: true,
    bool updatedAt: true,
    String user,
    bool url: true,
    bool thumbs: true,
  }) {
    final fields = [];
    if (id) fields.add('id');
    if (userId) fields.add('userId');
    if (region) fields.add('region');
    if (bucket) fields.add('bucket');
    if (path) fields.add('path');
    if (meta != null) fields.add('meta { $meta }');
    if (createdAt) fields.add('createdAt');
    if (updatedAt) fields.add('updatedAt');
    if (user != null) fields.add('user { $user }');
    if (url) fields.add('url');
    if (thumbs) fields.add('thumbs');

    return fields.join(' ');
  }

  String fileMetaFields({
    bool name: true,
    bool size: true,
    bool type: true,
  }) {
    final fields = [];
    if (name) fields.add('name');
    if (size) fields.add('size');
    if (type) fields.add('type');

    return fields.join(' ');
  }

  String userStatFields({
    bool id: true,
    bool userId: true,
    bool postCount: true,
    bool likeCount: true,
    bool followingCount: true,
    bool followerCount: true,
    bool createdAt: true,
    bool updatedAt: true,
    String user,
  }) {
    final fields = [];
    if (id) fields.add('id');
    if (userId) fields.add('userId');
    if (postCount) fields.add('postCount');
    if (likeCount) fields.add('likeCount');
    if (followingCount) fields.add('followingCount');
    if (followerCount) fields.add('followerCount');
    if (createdAt) fields.add('createdAt');
    if (updatedAt) fields.add('updatedAt');
    if (user != null) fields.add('user { $user }');

    return fields.join(' ');
  }

  String postStatFields({
    bool id: true,
    bool postId: true,
    bool likeCount: true,
    bool createdAt: true,
    bool updatedAt: true,
    String post,
  }) {
    final fields = [];
    if (id) fields.add('id');
    if (postId) fields.add('postId');
    if (likeCount) fields.add('likeCount');
    if (createdAt) fields.add('createdAt');
    if (updatedAt) fields.add('updatedAt');
    if (post != null) fields.add('post { $post }');

    return fields.join(' ');
  }

  @override
  Future<UserEntity> authLogin(String username, String password) async {
    final query = '''
mutation(\$user: UserInput!) {
  authLogin(user: \$user) { ${userFields()} }
}''';
    final response = await post(query, variables: {
      'user': {'username': username, 'password': password},
    });
    return UserEntity.fromJson(response['authLogin']);
  }

  @override
  Future<UserEntity> authLogout() async {
    final query = '''
query {
  authLogout { ${userFields()} }
}''';
    final response = await get(query);
    if (response['authLogout'] == null) {
      return null;
    }
    return UserEntity.fromJson(response['authLogout']);
  }

  @override
  Future<UserEntity> authLogged() async {
    final query = '''
query {
  authLogged { ${userFields(avatar: fileFields())} }
}''';
    final response = await get(query);
    if (response['authLogged'] == null) {
      return null;
    }
    return UserEntity.fromJson(response['authLogged']);
  }

  @override
  Future<UserEntity> userRegister(UserEntity userEntity) async {
    final query = '''
mutation(\$user: UserInput!) {
  userRegister(user: \$user) { ${userFields()} }
}''';
    final response = await post(query, variables: {
      'user': userEntity.toJson()..removeWhere((k, v) => v == null),
    });
    return UserEntity.fromJson(response['userRegister']);
  }

  @override
  Future<UserEntity> userModify(UserEntity userEntity, [String code]) async {
    final query = '''
mutation(\$user: UserInput!, \$code: String) {
  userModify(user: \$user, code: \$code) { ${userFields()} }
}''';
    final response = await post(query, variables: {
      'user': userEntity.toJson()..removeWhere((k, v) => v == null),
      'code': code,
    });
    return UserEntity.fromJson(response['userModify']);
  }

  @override
  Future<UserEntity> userInfo(int id) async {
    final query = '''
query(\$id: Int!) {
  userInfo(id: \$id) { ${userFields(avatar: fileFields(), stat: userStatFields(), following: true)} }
}''';
    final response = await get(query, variables: {
      'id': id,
    });
    return UserEntity.fromJson(response['userInfo']);
  }

  @override
  Future<void> userFollow(int userId) async {
    final query = '''
mutation(\$userId: Int!) {
  userFollow(userId: \$userId)
}''';
    await post(query, variables: {
      'userId': userId,
    });
  }

  @override
  Future<void> userUnfollow(int userId) async {
    final query = '''
mutation(\$userId: Int!) {
  userUnfollow(userId: \$userId)
}''';
    await post(query, variables: {
      'userId': userId,
    });
  }

  @override
  Future<List<UserEntity>> userFollowing(
      {int userId, int limit = 10, int offset = 0}) async {
    final query = '''
query(\$userId: Int, \$limit: Int, \$offset: Int) {
  userFollowing(userId: \$userId, limit: \$limit, offset: \$offset) { ${userFields(avatar: fileFields())} }
}''';
    final response = await get(query, variables: {
      'userId': userId,
      'limit': limit,
      'offset': offset,
    });
    return (response['userFollowing'] as List<dynamic>).map((v) {
      v['following'] = true;
      return UserEntity.fromJson(v);
    }).toList();
  }

  @override
  Future<List<UserEntity>> userFollower(
      {int userId, int limit = 10, int offset = 0}) async {
    final query = '''
query(\$userId: Int, \$limit: Int, \$offset: Int) {
  userFollower(userId: \$userId, limit: \$limit, offset: \$offset) { ${userFields(avatar: fileFields(), following: true)} }
}''';
    final response = await get(query, variables: {
      'userId': userId,
      'limit': limit,
      'offset': offset,
    });
    return (response['userFollower'] as List<dynamic>)
        .map((v) => UserEntity.fromJson(v))
        .toList();
  }

  @override
  Future<String> userSendMobileVerifyCode(String type, String mobile) async {
    final query = '''
mutation(\$type: String!, \$mobile: String!) {
  userSendMobileVerifyCode(type: \$type, mobile: \$mobile)
}''';
    final response = await post(query, variables: {
      'type': type,
      'mobile': mobile,
    });
    return response['userSendMobileVerifyCode'];
  }

  @override
  Future<PostEntity> postPublish(PostEntity postEntity) async {
    final query = '''
mutation(\$post: PostInput!) {
  postPublish(post: \$post) { ${postFields()} }
}''';
    final response = await post(query, variables: {
      'post': postEntity.toJson()..removeWhere((k, v) => v == null),
    });
    return PostEntity.fromJson(response['postPublish']);
  }

  @override
  Future<void> postDelete(int id) async {
    final query = '''
mutation(\$id: Int!) {
  postDelete(id: \$id)
}''';
    await post(query, variables: {
      'id': id,
    });
  }

  @override
  Future<PostEntity> postInfo(int id) async {
    final query = '''
query(\$id: Int!) {
  postInfo(id: \$id) { ${postFields(user: userFields(avatar: fileFields()), images: fileFields(), video: fileFields(), stat: postStatFields(), liked: true)} }
}''';
    final response = await get(query, variables: {
      'id': id,
    });
    return PostEntity.fromJson(response['postInfo']);
  }

  @override
  Future<List<PostEntity>> postPublished(
      {int userId, int limit = 10, int offset = 0}) async {
    final query = '''
query(\$userId: Int, \$limit: Int, \$offset: Int) {
  postPublished(userId: \$userId, limit: \$limit, offset: \$offset) { ${postFields(user: userFields(avatar: fileFields()), images: fileFields(), video: fileFields(), stat: postStatFields(), liked: true)} }
}''';
    final response = await get(query, variables: {
      'userId': userId,
      'limit': limit,
      'offset': offset,
    });
    return (response['postPublished'] as List<dynamic>)
        .map((v) => PostEntity.fromJson(v))
        .toList();
  }

  @override
  Future<void> postLike(int postId) async {
    final query = '''
mutation(\$postId: Int!) {
  postLike(postId: \$postId)
}''';
    await post(query, variables: {
      'postId': postId,
    });
  }

  @override
  Future<void> postUnlike(int postId) async {
    final query = '''
mutation(\$postId: Int!) {
  postUnlike(postId: \$postId)
}''';
    await post(query, variables: {
      'postId': postId,
    });
  }

  @override
  Future<List<PostEntity>> postLiked(
      {int userId, int limit = 10, int offset = 0}) async {
    final query = '''
query(\$userId: Int, \$limit: Int, \$offset: Int) {
  postLiked(userId: \$userId, limit: \$limit, offset: \$offset) { ${postFields(user: userFields(avatar: fileFields()), images: fileFields(), video: fileFields(), stat: postStatFields(), liked: true)} }
}''';
    final response = await get(query, variables: {
      'userId': userId,
      'limit': limit,
      'offset': offset,
    });
    return (response['postLiked'] as List<dynamic>).map((v) {
      v['liked'] = true;
      return PostEntity.fromJson(v);
    }).toList();
  }

  @override
  Future<List<PostEntity>> postFollowing(
      {int limit = 10, int beforeId, int afterId}) async {
    final query = '''
query(\$limit: Int, \$beforeId: Int, \$afterId: Int) {
  postFollowing(limit: \$limit, beforeId: \$beforeId, afterId: \$afterId) { ${postFields(user: userFields(avatar: fileFields()), images: fileFields(), video: fileFields(), stat: postStatFields(), liked: true)} }
}''';
    final response = await get(query, variables: {
      'limit': limit,
      'beforeId': beforeId,
      'afterId': afterId,
    });
    return (response['postFollowing'] as List<dynamic>)
        .map((v) => PostEntity.fromJson(v))
        .toList();
  }

  @override
  Future<List<FileEntity>> fileUpload(List<String> files,
      {String region, String bucket, String path}) async {
    final Map<String, dynamic> data = {
      'region': region,
      'bucket': bucket,
      'path': path
    };
    data.removeWhere((k, v) => v == null);

    data['file'] = files
        .map(
          (v) => UploadFileInfo(File(v), basename(v),
              contentType: ContentType.parse(lookupMimeType(v))),
        )
        .toList();

    final response = await request('POST', '/file/upload', FormData.from(data));

    return (response['files'] as List<dynamic>)
        .map((v) => FileEntity.fromJson(v))
        .toList();
  }
}
