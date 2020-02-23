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
  ));
  await container.onReady;

  runApp(WgApp(
    store: container.appStore,
    packageInfo: container.config.packageInfo,
    theme: container.theme.themeData,
  ));
}
