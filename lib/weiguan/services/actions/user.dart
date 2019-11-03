import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../container.dart';
import '../../entities/entities.dart';
import '../../interfaces/interfaces.dart';
import '../states/states.dart';

ThunkAction<AppState> userInfoAction({
  @required int id,
  void Function(UserEntity) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response =
          await WgContainer().wgService.get('/user/info', {'id': id});

      if (response.code == WgResponse.codeOk) {
        final user = UserEntity.fromJson(response.data['user']);
        if (onSuccess != null) onSuccess(user);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> userFollowAction({
  @required int followingId,
  void Function() onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response = await WgContainer()
          .wgService
          .post('/user/follow', {'followingId': followingId});

      if (response.code == WgResponse.codeOk) {
        if (onSuccess != null) onSuccess();
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> userUnfollowAction({
  @required int followingId,
  void Function() onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response = await WgContainer()
          .wgService
          .post('/user/unfollow', {'followingId': followingId});

      if (response.code == WgResponse.codeOk) {
        if (onSuccess != null) onSuccess();
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> userFollowingsAction({
  @required int userId,
  int limit = 10,
  int offset = 0,
  void Function(List<UserEntity>) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response = await WgContainer().wgService.get(
        '/user/followings',
        {
          'userId': userId,
          'limit': limit,
          'offset': offset,
        },
      );

      if (response.code == WgResponse.codeOk) {
        final users = (response.data['users'] as List<Map<String, dynamic>>)
            .map((v) => UserEntity.fromJson(v))
            .toList();
        if (onSuccess != null) onSuccess(users);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> userFollowersAction({
  @required int userId,
  int limit = 10,
  int offset = 0,
  void Function(List<UserEntity>) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response = await WgContainer().wgService.get(
        '/user/followers',
        {
          'userId': userId,
          'limit': limit,
          'offset': offset,
        },
      );

      if (response.code == WgResponse.codeOk) {
        final users = (response.data['users'] as List<Map<String, dynamic>>)
            .map((v) => UserEntity.fromJson(v))
            .toList();
        if (onSuccess != null) onSuccess(users);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };
