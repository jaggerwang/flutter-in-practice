import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

import '../../entity/entity.dart';

part 'post.g.dart';

@JsonSerializable()
@FunctionalData()
class PostPublishForm extends $PostPublishForm {
  PostType type;
  String text;
  List<String> images;
  List<int> imageIds;
  String video;
  int videoId;

  PostPublishForm({
    this.type = PostType.image,
    this.text = '',
    this.images = const [],
    this.imageIds = const [],
    this.video,
    this.videoId,
  });

  factory PostPublishForm.fromJson(Map<String, dynamic> json) =>
      _$PostPublishFormFromJson(json);

  Map<String, dynamic> toJson() => _$PostPublishFormToJson(this);
}
