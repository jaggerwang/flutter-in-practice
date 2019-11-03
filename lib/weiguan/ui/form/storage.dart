import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';

part 'storage.g.dart';

@JsonSerializable()
@FunctionalData()
class StorageUploadForm extends $StorageUploadForm {
  String region;
  String bucket;
  String path;
  List<String> files;

  StorageUploadForm({
    this.region,
    this.bucket,
    this.path,
    @required this.files,
  });

  factory StorageUploadForm.fromJson(Map<String, dynamic> json) =>
      _$StorageUploadFormFromJson(json);

  Map<String, dynamic> toJson() => _$StorageUploadFormToJson(this);
}
