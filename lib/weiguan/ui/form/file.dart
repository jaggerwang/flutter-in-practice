import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';

part 'file.g.dart';

@JsonSerializable()
@FunctionalData()
class FileUploadForm extends $FileUploadForm {
  String region;
  String bucket;
  String path;
  List<String> files;

  FileUploadForm({
    this.region,
    this.bucket,
    this.path,
    @required this.files,
  });

  factory FileUploadForm.fromJson(Map<String, dynamic> json) =>
      _$FileUploadFormFromJson(json);

  Map<String, dynamic> toJson() => _$FileUploadFormToJson(this);
}
