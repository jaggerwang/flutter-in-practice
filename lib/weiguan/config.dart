import 'dart:io';

import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';

class WgConfig {
  bool debug;
  Level loggerLevel;
  bool logAction;
  bool logApi;
  bool enableRestApi;
  bool enableGraphQLApi;
  String apiBaseUrl;
  bool persistState;
  PackageInfo packageInfo;
  Directory appDocDir;

  WgConfig({
    this.debug = false,
    this.loggerLevel = Level.INFO,
    this.logAction = false,
    this.logApi = false,
    this.enableRestApi = false,
    this.enableGraphQLApi = false,
    this.apiBaseUrl = '',
    this.persistState = true,
  });
}
