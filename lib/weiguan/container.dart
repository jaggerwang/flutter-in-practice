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
import 'theme.dart';

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

      injectTheme();

      injectLogger();

      injectAppState();

      await injectAppStore();

      injectService();

      injectUseCase();

      injectPresenter();
    });
  }

  WgConfig get config {
    return _config;
  }

  void injectTheme() {
    _injector.registerSingleton<WgTheme>((injector) {
      return WgTheme();
    });
  }

  WgTheme get theme {
    return _injector.getDependency<WgTheme>();
  }

  void injectLogger() {
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

  void injectAppState() {
    _injector.registerDependency<AppState>((injector) {
      return AppState(version: _config.packageInfo.version);
    });
  }

  AppState get appState {
    return _injector.getDependency<AppState>();
  }

  Future<void> injectAppStore() async {
    final store = await createStore();

    _injector.registerSingleton<Store<AppState>>((injector) {
      return store;
    });
  }

  Store<AppState> get appStore {
    return _injector.getDependency<Store<AppState>>();
  }

  void injectService() {
    _injector.registerSingleton<WeiguanService>((injector) {
      if (config.isMockApi) {
        return WeiguanServiceMock(
          config: config,
          logger: apiLogger,
        );
      } else {
        final client = Dio();
        client.options.baseUrl = config.wgApiBase;
        client.interceptors.add(CookieManager(
            PersistCookieJar(dir: '${config.appDocDir.path}/cookies')));

        return WeiguanServiceImpl(
          config: config,
          logger: apiLogger,
          client: client,
        );
      }
    });
  }

  WeiguanService get weiguanService {
    return _injector.getDependency<WeiguanService>();
  }

  void injectUseCase() {
    _injector.registerSingleton<AccountUseCase>((injector) {
      return AccountUseCase(weiguanService);
    });

    _injector.registerSingleton<PostUseCase>((injector) {
      return PostUseCase(weiguanService);
    });

    _injector.registerSingleton<UserUseCase>((injector) {
      return UserUseCase(weiguanService);
    });
  }

  AccountUseCase get accountUseCase {
    return _injector.getDependency<AccountUseCase>();
  }

  PostUseCase get postUseCase {
    return _injector.getDependency<PostUseCase>();
  }

  UserUseCase get userUseCase {
    return _injector.getDependency<UserUseCase>();
  }

  void injectPresenter() {
    _injector.registerSingleton<AccountPresenter>((injector) {
      return AccountPresenter(appStore, accountUseCase);
    });

    _injector.registerSingleton<PostPresenter>((injector) {
      return PostPresenter(appStore, postUseCase);
    });

    _injector.registerSingleton<UserPresenter>((injector) {
      return UserPresenter(appStore, userUseCase);
    });
  }

  AccountPresenter get accountPresenter {
    return _injector.getDependency<AccountPresenter>();
  }

  PostPresenter get postPresenter {
    return _injector.getDependency<PostPresenter>();
  }

  UserPresenter get userPresenter {
    return _injector.getDependency<UserPresenter>();
  }
}
