import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';

class OAuth2Config {
  String clientId;
  String redirectUrl;
  String authorizationEndpoint;
  String tokenEndpoint;
  List<String> scopes;

  OAuth2Config({
    this.clientId,
    this.redirectUrl,
    this.authorizationEndpoint,
    this.tokenEndpoint,
    this.scopes,
  });
}

class WgConfig {
  bool debug;
  Level loggerLevel;
  bool logAction;
  bool logApi;
  bool enableRestApi;
  bool enableGraphQLApi;
  String apiBaseUrl;
  bool enableOAuth2Login;
  OAuth2Config oAuth2Config;
  bool persistState;
  PackageInfo packageInfo;
  Directory appDocDir;
  GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  WgConfig({
    this.debug = false,
    this.loggerLevel = Level.INFO,
    this.logAction = false,
    this.logApi = false,
    this.enableRestApi = false,
    this.enableGraphQLApi = false,
    this.apiBaseUrl = '',
    this.enableOAuth2Login = false,
    this.oAuth2Config,
    this.persistState = true,
  });
}
