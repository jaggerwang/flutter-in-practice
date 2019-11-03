import 'package:redux/redux.dart';

import '../ui.dart';

final accountReducer = combineReducers<AccountState>([
  TypedReducer<AccountState, AccountInfoAction>(_info),
]);

AccountState _info(AccountState state, AccountInfoAction action) {
  return state.copyWith(
    user: action.user,
  );
}
