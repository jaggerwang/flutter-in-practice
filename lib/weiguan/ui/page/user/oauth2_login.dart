import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

import '../../../container.dart';
import '../../ui.dart';

class OAuth2LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OAuth2 登录'),
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  void _login() async {
    final config = WgContainer().config;
    final appAuth = FlutterAppAuth();
    final appStore = WgContainer().appStore;
    final oAuth2State = appStore.state.oauth2;
    if (oAuth2State.refreshToken != null) {
      final response = await appAuth.token(TokenRequest(
        config.oAuth2Config.clientId,
        config.oAuth2Config.redirectUrl,
        serviceConfiguration: AuthorizationServiceConfiguration(
          config.oAuth2Config.authorizationEndpoint,
          config.oAuth2Config.tokenEndpoint,
        ),
        scopes: config.oAuth2Config.scopes,
        refreshToken: oAuth2State.refreshToken,
        allowInsecureConnections: true,
      ));

      if (response.accessToken != null) {
        WgContainer().basePresenter.dispatchAction(OAuth2StateAction(
              accessToken: response.accessToken,
              accessTokenExpireAt: response.accessTokenExpirationDateTime,
              refreshToken: response.refreshToken,
            ));
        WgContainer()
            .basePresenter
            .navigator()
            .pushNamedAndRemoveUntil('/', (route) => false);
        return;
      }
    }

    final response =
        await appAuth.authorizeAndExchangeCode(AuthorizationTokenRequest(
      config.oAuth2Config.clientId,
      config.oAuth2Config.redirectUrl,
      serviceConfiguration: AuthorizationServiceConfiguration(
        config.oAuth2Config.authorizationEndpoint,
        config.oAuth2Config.tokenEndpoint,
      ),
      scopes: config.oAuth2Config.scopes,
      allowInsecureConnections: true,
    ));
    if (response.accessToken != null) {
      WgContainer().basePresenter.dispatchAction(OAuth2StateAction(
            accessToken: response.accessToken,
            accessTokenExpireAt: response.accessTokenExpirationDateTime,
            refreshToken: response.refreshToken,
          ));
      WgContainer()
          .basePresenter
          .navigator()
          .pushNamedAndRemoveUntil('/', (route) => false);
      return;
    }

    WgContainer().basePresenter.showMessage('OAuth2 登录失败');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(WgContainer().theme.paddingSizeLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(flex: 5),
          RaisedButton(
            padding: EdgeInsets.all(WgContainer().theme.paddingSizeNormal),
            onPressed: _login,
            color: Theme.of(context).primaryColorDark,
            child: Text(
              'OAuth2 登录',
              style: Theme.of(context)
                  .primaryTextTheme
                  .button
                  .copyWith(fontSize: 16),
            ),
          ),
          Spacer(),
          RaisedButton(
            padding: EdgeInsets.all(WgContainer().theme.paddingSizeNormal),
            onPressed: () =>
                WgContainer().basePresenter.navigator().pushNamed('/register'),
            color: Theme.of(context).primaryColor,
            child: Text(
              '注册新帐号',
              style: Theme.of(context)
                  .primaryTextTheme
                  .button
                  .copyWith(fontSize: 16),
            ),
          ),
          Spacer(flex: 5),
        ],
      ),
    );
  }
}
