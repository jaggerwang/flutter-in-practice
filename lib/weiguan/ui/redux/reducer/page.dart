import 'package:redux/redux.dart';

import '../../ui.dart';

final pageReducer = combineReducers<PageState>([
  TypedReducer<PageState, PageStateAction>(_publishForm),
]);

PageState _publishForm(PageState state, PageStateAction action) {
  return state.copyWith(
    homeMode: action.homePostListType,
    publishForm: action.publishForm,
  );
}
