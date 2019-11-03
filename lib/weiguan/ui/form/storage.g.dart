// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $StorageUploadForm {
  String get region;
  String get bucket;
  String get path;
  List<String> get files;
  const $StorageUploadForm();
  StorageUploadForm copyWith(
          {String region, String bucket, String path, List<String> files}) =>
      StorageUploadForm(
          region: region ?? this.region,
          bucket: bucket ?? this.bucket,
          path: path ?? this.path,
          files: files ?? this.files);
  String toString() =>
      "StorageUploadForm(region: $region, bucket: $bucket, path: $path, files: $files)";
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

class StorageUploadForm$ {
  static final region = Lens<StorageUploadForm, String>(
      (s_) => s_.region, (s_, region) => s_.copyWith(region: region));
  static final bucket = Lens<StorageUploadForm, String>(
      (s_) => s_.bucket, (s_, bucket) => s_.copyWith(bucket: bucket));
  static final path = Lens<StorageUploadForm, String>(
      (s_) => s_.path, (s_, path) => s_.copyWith(path: path));
  static final files = Lens<StorageUploadForm, List<String>>(
      (s_) => s_.files, (s_, files) => s_.copyWith(files: files));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageUploadForm _$StorageUploadFormFromJson(Map<String, dynamic> json) {
  return StorageUploadForm(
    region: json['region'] as String,
    bucket: json['bucket'] as String,
    path: json['path'] as String,
    files: (json['files'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$StorageUploadFormToJson(StorageUploadForm instance) =>
    <String, dynamic>{
      'region': instance.region,
      'bucket': instance.bucket,
      'path': instance.path,
      'files': instance.files,
    };
