import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../config.dart';
import '../container.dart';
import 'app.dart';

void main() async {
  final container = WgContainer(WgConfig(
    debug: true,
    loggerLevel: Level.ALL,
    isLogAction: true,
    isLogApi: true,
    isMockApi: true,
    // wgApiBase: 'http://localhost:8000',
  ));
  await container.onReady;

  runApp(WgApp(
    store: container.appStore,
    packageInfo: container.config.packageInfo,
    theme: container.theme.themeData,
  ));
}
