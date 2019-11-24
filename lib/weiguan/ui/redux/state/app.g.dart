// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $AppState {
  String get version;
  UserState get user;
  PostState get post;
  PageState get page;
  const $AppState();
  AppState copyWith(
          {String version, UserState user, PostState post, PageState page}) =>
      AppState(
          version: version ?? this.version,
          user: user ?? this.user,
          post: post ?? this.post,
          page: page ?? this.page);
  String toString() =>
      "AppState(version: $version, user: $user, post: $post, page: $page)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      version == other.version &&
      user == other.user &&
      post == other.post &&
      page == other.page;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + version.hashCode;
    result = 37 * result + user.hashCode;
    result = 37 * result + post.hashCode;
    result = 37 * result + page.hashCode;
    return result;
  }
}

class AppState$ {
  static final version = Lens<AppState, String>(
      (s_) => s_.version, (s_, version) => s_.copyWith(version: version));
  static final user = Lens<AppState, UserState>(
      (s_) => s_.user, (s_, user) => s_.copyWith(user: user));
  static final post = Lens<AppState, PostState>(
      (s_) => s_.post, (s_, post) => s_.copyWith(post: post));
  static final page = Lens<AppState, PageState>(
      (s_) => s_.page, (s_, page) => s_.copyWith(page: page));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    version: json['version'] as String,
    user: json['user'] == null
        ? null
        : UserState.fromJson(json['user'] as Map<String, dynamic>),
    post: json['post'] == null
        ? null
        : PostState.fromJson(json['post'] as Map<String, dynamic>),
    page: json['page'] == null
        ? null
        : PageState.fromJson(json['page'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'version': instance.version,
      'user': instance.user,
      'post': instance.post,
      'page': instance.page,
    };
