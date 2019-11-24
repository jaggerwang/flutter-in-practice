import 'package:flutter/material.dart';

import 'ui/ui.dart';
import 'config.dart';
import 'container.dart';

void main() async {
  final container = WgContainer(WgConfig(
    enableRestApi: false,
    apiUrlBase: 'http://localhost:8000',
  ));
  await container.onReady;

  runApp(WgApp(
    store: container.appStore,
    packageInfo: container.config.packageInfo,
    theme: container.theme.themeData,
  ));
}
