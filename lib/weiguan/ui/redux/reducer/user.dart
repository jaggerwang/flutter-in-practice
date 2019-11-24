import 'package:redux/redux.dart';

import '../../ui.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UserLoggedAction>(_info),
]);

UserState _info(UserState state, UserLoggedAction action) {
  return state.copyWith(
    logged: action.user,
  );
}
