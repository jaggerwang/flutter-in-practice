import 'package:redux/redux.dart';

import '../../ui.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UserLoggedAction>(_logged),
]);

UserState _logged(UserState state, UserLoggedAction action) {
  return state.copyWith(
    logged: action.user,
  );
}
