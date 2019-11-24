// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $FileUploadForm {
  String get region;
  String get bucket;
  String get path;
  List<String> get files;
  const $FileUploadForm();
  FileUploadForm copyWith(
          {String region, String bucket, String path, List<String> files}) =>
      FileUploadForm(
          region: region ?? this.region,
          bucket: bucket ?? this.bucket,
          path: path ?? this.path,
          files: files ?? this.files);
  String toString() =>
      "FileUploadForm(region: $region, bucket: $bucket, path: $path, files: $files)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      region == other.region &&
      bucket == other.bucket &&
      path == other.path &&
      files == other.files;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + region.hashCode;
    result = 37 * result + bucket.hashCode;
    result = 37 * result + path.hashCode;
    result = 37 * result + files.hashCode;
    return result;
  }
}

class FileUploadForm$ {
  static final region = Lens<FileUploadForm, String>(
      (s_) => s_.region, (s_, region) => s_.copyWith(region: region));
  static final bucket = Lens<FileUploadForm, String>(
      (s_) => s_.bucket, (s_, bucket) => s_.copyWith(bucket: bucket));
  static final path = Lens<FileUploadForm, String>(
      (s_) => s_.path, (s_, path) => s_.copyWith(path: path));
  static final files = Lens<FileUploadForm, List<String>>(
      (s_) => s_.files, (s_, files) => s_.copyWith(files: files));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileUploadForm _$FileUploadFormFromJson(Map<String, dynamic> json) {
  return FileUploadForm(
    region: json['region'] as String,
    bucket: json['bucket'] as String,
    path: json['path'] as String,
    files: (json['files'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FileUploadFormToJson(FileUploadForm instance) =>
    <String, dynamic>{
      'region': instance.region,
      'bucket': instance.bucket,
      'path': instance.path,
      'files': instance.files,
    };
