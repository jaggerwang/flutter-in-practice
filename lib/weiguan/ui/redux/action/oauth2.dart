import '../../ui.dart';

class OAuth2StateAction extends BaseAction {
  final String accessToken;
  final DateTime accessTokenExpireAt;
  final String refreshToken;

  OAuth2StateAction({
    this.accessToken,
    this.accessTokenExpireAt,
    this.refreshToken,
  });
}
