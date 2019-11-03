import 'dart:io';

import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';

class WgConfig {
  String wgApiBase;
  bool debug;
  Level loggerLevel;
  bool isLogAction;
  bool isLogApi;
  bool isMockApi;
  bool isPersistState;
  PackageInfo packageInfo;
  Directory appDocDir;

  WgConfig({
    this.wgApiBase = 'https://weiguan.app/api',
    this.debug = false,
    this.loggerLevel = Level.INFO,
    this.isLogAction = false,
    this.isLogApi = false,
    this.isMockApi = false,
    this.isPersistState = true,
  });
}
