import 'dart:async';

import 'package:dio/dio.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:injector/injector.dart';
import 'package:package_info/package_info.dart';

import 'config.dart';
import 'theme.dart';
import 'utils/utils.dart';
import 'interfaces/interfaces.dart';
import 'services/services.dart';
import 'dependencies/dependencies.dart';

class WgContainer {
  static WgContainer _instance;

  final _injector = Injector();
  WgConfig _config;
  Future<void> onReady;

  factory WgContainer([WgConfig config]) {
    if (_instance == null) {
      _instance = WgContainer._(config);
    }

    return _instance;
  }

  WgContainer._(WgConfig config) {
    _config = config;

    onReady = Future(() async {
      _config.packageInfo = await PackageInfo.fromPlatform();
      _config.appDocDir = await getApplicationDocumentsDirectory();
      print(_config);

      _injectTheme();

      _injectLogger();

      _injectAppState();

      await _injectAppStore();

      _injectWgService();
    });
  }

  WgConfig get config {
    return _config;
  }

  void _injectTheme() {
    _injector.registerSingleton<WgTheme>((injector) {
      return WgTheme();
    });
  }

  WgTheme get theme {
    return _injector.getDependency<WgTheme>();
  }

  void _injectLogger() {
    Logger.root.level = config.loggerLevel;
    Logger.root.onRecord.listen((record) {
      final label = record.loggerName.padRight(3).substring(0, 3).toUpperCase();
      final time = record.time.toIso8601String().substring(0, 23);
      final level = record.level.toString().padRight(4);
      print('$label $time $level ${record.message}');
    });

    _injector.registerSingleton<Logger>((injector) {
      return Logger('app');
    }, dependencyName: 'app');
    _injector.registerSingleton<Logger>((injector) {
      return Logger('action');
    }, dependencyName: 'action');
    _injector.registerSingleton<Logger>((injector) {
      return Logger('api');
    }, dependencyName: 'api');
  }

  Logger get appLogger {
    return _injector.getDependency<Logger>(dependencyName: 'app');
  }

  Logger get apiLogger {
    return _injector.getDependency<Logger>(dependencyName: 'api');
  }

  Logger get actionLogger {
    return _injector.getDependency<Logger>(dependencyName: 'action');
  }

  void _injectAppState() {
    _injector.registerDependency<AppState>((injector) {
      return AppState(version: _config.packageInfo.version);
    });
  }

  AppState get appState {
    return _injector.getDependency<AppState>();
  }

  Future<void> _injectAppStore() async {
    var initialState = appState;

    final List<Middleware<AppState>> wms = [];
    if (config.isLogAction) {
      wms.add(LoggingMiddleware<AppState>(logger: actionLogger));
    }
    wms.add(thunkMiddleware);

    if (config.isPersistState) {
      final persistor = Persistor<AppState>(
        storage: FlutterStorage(key: _config.packageInfo.packageName),
        serializer: JsonSerializer<AppState>((json) {
          if (json == null) {
            return initialState;
          }
          return AppState.fromJson(json);
        }),
        transforms: Transforms(
          onLoad: [
            (state) {
              if (compareVersion(
                      state.version, _config.packageInfo.version, 2) !=
                  0) {
                state = initialState;
              }
              return state;
            }
          ],
        ),
      );

      initialState = await persistor.load();

      wms.add(persistor.createMiddleware());
    }

    final store = Store<AppState>(
      appReducer,
      initialState: initialState,
      middleware: wms,
    );

    _injector.registerSingleton<Store<AppState>>((injector) {
      return store;
    });
  }

  Store<AppState> get appStore {
    return _injector.getDependency<Store<AppState>>();
  }

  void _injectWgService() {
    _injector.registerSingleton<IWgService>((injector) {
      if (config.isMockApi) {
        return WgServiceMock(
          config: config,
          logger: apiLogger,
        );
      } else {
        final client = Dio();
        client.options.baseUrl = config.wgApiBase;
        client.interceptors.add(CookieManager(
            PersistCookieJar(dir: '${config.appDocDir.path}/cookies')));

        return WgService(
          config: config,
          logger: apiLogger,
          client: client,
        );
      }
    });
  }

  IWgService get wgService {
    return _injector.getDependency<IWgService>();
  }
}
