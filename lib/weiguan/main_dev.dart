import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'ui/ui.dart';
import 'config.dart';
import 'container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = WgContainer(WgConfig(
    debug: true,
    loggerLevel: Level.ALL,
    logAction: true,
    logApi: true,
    enableRestApi: false,
    enableGraphQLApi: false,
    apiBaseUrl: 'http://localhost:8080',
    enableOAuth2Login: false,
    oAuth2Config: OAuth2Config(
      clientId: 'fip',
      redirectUrl: 'net.jaggerwang.fip:/login/oauth2/code/hydra',
      authorizationEndpoint: 'http://localhost:4444/oauth2/auth',
      tokenEndpoint: 'http://localhost:4444/oauth2/token',
      scopes: ['offline', 'user', 'post', 'file', 'stat'],
    ),
  ));
  await container.onReady;

  runApp(WgApp(
    config: container.config,
    store: container.appStore,
    packageInfo: container.config.packageInfo,
    theme: container.theme.themeData,
  ));
}
