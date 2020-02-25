import 'package:redux/redux.dart';

import '../../ui.dart';

final oauth2Reducer = combineReducers<OAuth2State>([
  TypedReducer<OAuth2State, OAuth2StateAction>(_publishForm),
]);

OAuth2State _publishForm(OAuth2State state, OAuth2StateAction action) {
  return state.copyWith(
    accessToken: action.accessToken,
    accessTokenExpireAt: action.accessTokenExpireAt,
    refreshToken: action.refreshToken,
  );
}
