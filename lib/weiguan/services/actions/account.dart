import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../container.dart';
import '../../entities/entities.dart';
import '../../interfaces/interfaces.dart';
import '../forms/forms.dart';
import '../states/states.dart';
import 'common.dart';

class AccountInfoAction {
  final UserEntity user;

  AccountInfoAction({
    @required this.user,
  });
}

ThunkAction<AppState> accountLoginAction({
  @required AccountLoginForm form,
  void Function(UserEntity) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response =
          await WgContainer().wgService.post('/account/login', form.toJson());

      if (response.code == WgResponse.codeOk) {
        final user = UserEntity.fromJson(response.data['user']);
        store.dispatch(AccountInfoAction(user: user));
        if (onSuccess != null) onSuccess(user);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> accountRegisterAction({
  @required AccountRegisterForm form,
  void Function(UserEntity) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response = await WgContainer()
          .wgService
          .post('/account/register', form.toJson());

      if (response.code == WgResponse.codeOk) {
        final user = UserEntity.fromJson(response.data['user']);
        if (onSuccess != null) onSuccess(user);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> accountInfoAction({
  void Function(UserEntity) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response = await WgContainer().wgService.get('/account/info');

      if (response.code == WgResponse.codeOk) {
        UserEntity user;
        if (response.data['user'] != null) {
          user = UserEntity.fromJson(response.data['user']);
          store.dispatch(AccountInfoAction(user: user));
        }
        if (onSuccess != null) onSuccess(user);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> accountLogoutAction({
  void Function(UserEntity) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response = await WgContainer().wgService.get('/account/logout');

      if (response.code == WgResponse.codeOk) {
        final user = UserEntity.fromJson(response.data['user']);
        store.dispatch(ResetAction());
        if (onSuccess != null) onSuccess(user);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> accountModifyAction({
  @required AccountProfileForm form,
  void Function(UserEntity) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response =
          await WgContainer().wgService.post('/account/modify', form.toJson());

      if (response.code == WgResponse.codeOk) {
        final user = UserEntity.fromJson(response.data['user']);
        store.dispatch(accountInfoAction());
        if (onSuccess != null) onSuccess(user);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };

ThunkAction<AppState> accountSendMobileVerifyCodeAction({
  @required String type,
  @required String mobile,
  void Function(String) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final response = await WgContainer().wgService.post(
        '/account/send/mobile/verify/code',
        {
          'type': type,
          'mobile': mobile,
        },
      );

      if (response.code == WgResponse.codeOk) {
        final verifyCode = response.data['verifyCode'] as String;
        if (onSuccess != null) onSuccess(verifyCode);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };
