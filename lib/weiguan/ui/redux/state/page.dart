import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

import '../../../entity/entity.dart';
import '../../ui.dart';

part 'page.g.dart';

@JsonSerializable()
@FunctionalData()
class PageState extends $PageState {
  final PostListType homeMode;
  final PostPublishForm publishForm;

  PageState({
    this.homeMode = PostListType.FOLLOWING,
    PostPublishForm publishForm,
  }) : this.publishForm = publishForm ?? PostPublishForm();

  factory PageState.fromJson(Map<String, dynamic> json) =>
      _$PageStateFromJson(json);

  Map<String, dynamic> toJson() => _$PageStateToJson(this);
}
