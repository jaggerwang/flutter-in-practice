import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux_logging/redux_logging.dart';

import '../../util/util.dart';
import '../../container.dart';
import 'redux.dart';

Future<Store<AppState>> createStore() async {
  final config = WgContainer().config;
  var initialState = WgContainer().initialAppState;
  final actionLogger = WgContainer().actionLogger;

  final List<Middleware<AppState>> wms = [];
  if (config.logAction) {
    wms.add(LoggingMiddleware<AppState>(logger: actionLogger));
  }

  if (config.persistState) {
    final persistor = Persistor<AppState>(
      storage: FlutterStorage(key: config.packageInfo.packageName),
      serializer: JsonSerializer<AppState>((json) {
        if (json == null) {
          return initialState;
        }
        return AppState.fromJson(json);
      }),
      transforms: Transforms(
        onLoad: [
          (state) {
            if (compareVersion(state.version, config.packageInfo.version, 2) !=
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

  return Store<AppState>(
    appReducer,
    initialState: initialState,
    middleware: wms,
  );
}
