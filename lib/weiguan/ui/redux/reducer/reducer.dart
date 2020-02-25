import '../../../container.dart';
import '../../ui.dart';
import 'oauth2.dart';
import 'page.dart';
import 'user.dart';
import 'post.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is ResetAction) {
    return WgContainer().initialAppState;
  } else {
    return state.copyWith(
      oauth2: oauth2Reducer(state.oauth2, action),
      page: pageReducer(state.page, action),
      user: userReducer(state.user, action),
      post: postReducer(state.post, action),
    );
  }
}
