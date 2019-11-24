// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $PageState {
  PostListType get homeMode;
  PostPublishForm get publishForm;
  const $PageState();
  PageState copyWith({PostListType homeMode, PostPublishForm publishForm}) =>
      PageState(
          homeMode: homeMode ?? this.homeMode,
          publishForm: publishForm ?? this.publishForm);
  String toString() =>
      "PageState(homeMode: $homeMode, publishForm: $publishForm)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      homeMode == other.homeMode &&
      publishForm == other.publishForm;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + homeMode.hashCode;
    result = 37 * result + publishForm.hashCode;
    return result;
  }
}

class PageState$ {
  static final homeMode = Lens<PageState, PostListType>(
      (s_) => s_.homeMode, (s_, homeMode) => s_.copyWith(homeMode: homeMode));
  static final publishForm = Lens<PageState, PostPublishForm>(
      (s_) => s_.publishForm,
      (s_, publishForm) => s_.copyWith(publishForm: publishForm));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageState _$PageStateFromJson(Map<String, dynamic> json) {
  return PageState(
    homeMode: _$enumDecodeNullable(_$PostListTypeEnumMap, json['homeMode']),
    publishForm: json['publishForm'] == null
        ? null
        : PostPublishForm.fromJson(json['publishForm'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PageStateToJson(PageState instance) => <String, dynamic>{
      'homeMode': _$PostListTypeEnumMap[instance.homeMode],
      'publishForm': instance.publishForm,
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

const _$PostListTypeEnumMap = {
  PostListType.FOLLOWING: 'FOLLOWING',
  PostListType.HOT: 'HOT',
};
