import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:injector/injector.dart';
import 'package:package_info/package_info.dart';

import 'adapter/adapter.dart';
import 'ui/ui.dart';
import 'usecase/usecase.dart';
import 'config.dart';

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

      registerLoggers();

      registerTheme();

      registerInitialAppState();

      await registerAppStore();

      registerServices();

      registerUsecases();

      registerPresenters();
    });
  }

  WgConfig get config {
    return _config;
  }

  void registerLoggers() {
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

  void registerTheme() {
    _injector.registerSingleton<WgTheme>((injector) {
      return WgTheme();
    });
  }

  WgTheme get theme {
    return _injector.getDependency<WgTheme>();
  }

  void registerInitialAppState() {
    _injector.registerDependency<AppState>((injector) {
      return AppState(version: _config.packageInfo.version);
    });
  }

  AppState get initialAppState {
    return _injector.getDependency<AppState>();
  }

  Future<void> registerAppStore() async {
    final store = await createStore();

    _injector.registerSingleton<Store<AppState>>((injector) {
      return store;
    });
  }

  Store<AppState> get appStore {
    return _injector.getDependency<Store<AppState>>();
  }

  void registerServices() {
    _injector.registerSingleton<WeiguanService>((injector) {
      final createClient = () {
        final client = Dio();
        client.options.baseUrl = config.apiBaseUrl;
        client.interceptors.add(CookieManager(
            PersistCookieJar(dir: '${config.appDocDir.path}/cookies')));
        return client;
      };

      if (config.enableRestApi) {
        return WeiguanRestService(
          config: config,
          appStore: appStore,
          logger: apiLogger,
          client: createClient(),
        );
      } else if (config.enableGraphQLApi) {
        return WeiguanGraphQLService(
          config: config,
          appStore: appStore,
          logger: apiLogger,
          client: createClient(),
        );
      } else {
        return WeiguanMockService(
          config: config,
          logger: apiLogger,
        );
      }
    });
  }

  WeiguanService get weiguanService {
    return _injector.getDependency<WeiguanService>();
  }

  void registerUsecases() {
    _injector.registerSingleton<UserUsecases>((injector) {
      return UserUsecases(weiguanService);
    });

    _injector.registerSingleton<PostUsecases>((injector) {
      return PostUsecases(weiguanService);
    });
  }

  UserUsecases get userUsecases {
    return _injector.getDependency<UserUsecases>();
  }

  PostUsecases get postUsecases {
    return _injector.getDependency<PostUsecases>();
  }

  void registerPresenters() {
    _injector.registerSingleton<BasePresenter>((injector) {
      return BasePresenter(
        config: config,
        appStore: appStore,
        logger: appLogger,
      );
    });

    _injector.registerSingleton<UserPresenter>((injector) {
      return UserPresenter(
          config: config,
          appStore: appStore,
          logger: appLogger,
          weiguanService: weiguanService,
          userUsecases: userUsecases);
    });

    _injector.registerSingleton<PostPresenter>((injector) {
      return PostPresenter(
          config: config,
          appStore: appStore,
          logger: appLogger,
          weiguanService: weiguanService,
          postUsecases: postUsecases);
    });
  }

  BasePresenter get basePresenter {
    return _injector.getDependency<BasePresenter>();
  }

  UserPresenter get userPresenter {
    return _injector.getDependency<UserPresenter>();
  }

  PostPresenter get postPresenter {
    return _injector.getDependency<PostPresenter>();
  }
}
