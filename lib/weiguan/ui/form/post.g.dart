// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $PostPublishForm {
  PostType get type;
  String get text;
  List<String> get images;
  List<int> get imageIds;
  String get video;
  int get videoId;
  const $PostPublishForm();
  PostPublishForm copyWith(
          {PostType type,
          String text,
          List<String> images,
          List<int> imageIds,
          String video,
          int videoId}) =>
      PostPublishForm(
          type: type ?? this.type,
          text: text ?? this.text,
          images: images ?? this.images,
          imageIds: imageIds ?? this.imageIds,
          video: video ?? this.video,
          videoId: videoId ?? this.videoId);
  String toString() =>
      "PostPublishForm(type: $type, text: $text, images: $images, imageIds: $imageIds, video: $video, videoId: $videoId)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      type == other.type &&
      text == other.text &&
      images == other.images &&
      imageIds == other.imageIds &&
      video == other.video &&
      videoId == other.videoId;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + type.hashCode;
    result = 37 * result + text.hashCode;
    result = 37 * result + images.hashCode;
    result = 37 * result + imageIds.hashCode;
    result = 37 * result + video.hashCode;
    result = 37 * result + videoId.hashCode;
    return result;
  }
}

class PostPublishForm$ {
  static final type = Lens<PostPublishForm, PostType>(
      (s_) => s_.type, (s_, type) => s_.copyWith(type: type));
  static final text = Lens<PostPublishForm, String>(
      (s_) => s_.text, (s_, text) => s_.copyWith(text: text));
  static final images = Lens<PostPublishForm, List<String>>(
      (s_) => s_.images, (s_, images) => s_.copyWith(images: images));
  static final imageIds = Lens<PostPublishForm, List<int>>(
      (s_) => s_.imageIds, (s_, imageIds) => s_.copyWith(imageIds: imageIds));
  static final video = Lens<PostPublishForm, String>(
      (s_) => s_.video, (s_, video) => s_.copyWith(video: video));
  static final videoId = Lens<PostPublishForm, int>(
      (s_) => s_.videoId, (s_, videoId) => s_.copyWith(videoId: videoId));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPublishForm _$PostPublishFormFromJson(Map<String, dynamic> json) {
  return PostPublishForm(
    type: _$enumDecodeNullable(_$PostTypeEnumMap, json['type']),
    text: json['text'] as String,
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
    imageIds: (json['imageIds'] as List)?.map((e) => e as int)?.toList(),
    video: json['video'] as String,
    videoId: json['videoId'] as int,
  );
}

Map<String, dynamic> _$PostPublishFormToJson(PostPublishForm instance) =>
    <String, dynamic>{
      'type': _$PostTypeEnumMap[instance.type],
      'text': instance.text,
      'images': instance.images,
      'imageIds': instance.imageIds,
      'video': instance.video,
      'videoId': instance.videoId,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PostTypeEnumMap = {
  PostType.TEXT: 'TEXT',
  PostType.IMAGE: 'IMAGE',
  PostType.VIDEO: 'VIDEO',
};
