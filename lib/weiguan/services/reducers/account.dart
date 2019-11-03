import 'package:redux/redux.dart';

import '../states/states.dart';
import '../actions/actions.dart';

final accountReducer = combineReducers<AccountState>([
  TypedReducer<AccountState, AccountInfoAction>(_info),
]);

AccountState _info(AccountState state, AccountInfoAction action) {
  return state.copyWith(
    user: action.user,
  );
}
