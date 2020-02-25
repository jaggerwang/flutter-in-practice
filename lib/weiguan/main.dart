import 'package:flutter/material.dart';

import 'ui/ui.dart';
import 'config.dart';
import 'container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = WgContainer(WgConfig());
  await container.onReady;

  runApp(WgApp(
    config: container.config,
    store: container.appStore,
    packageInfo: container.config.packageInfo,
    theme: container.theme.themeData,
  ));
}
