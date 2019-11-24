import '../../../entity/entity.dart';
import '../../ui.dart';

class PageStateAction extends BaseAction {
  final PostListType homePostListType;
  final PostPublishForm publishForm;

  PageStateAction({
    this.homePostListType,
    this.publishForm,
  });
}
