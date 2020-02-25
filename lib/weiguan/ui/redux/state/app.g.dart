// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $AppState {
  String get version;
  OAuth2State get oauth2;
  PageState get page;
  UserState get user;
  PostState get post;
  const $AppState();
  AppState copyWith(
          {String version,
          OAuth2State oauth2,
          PageState page,
          UserState user,
          PostState post}) =>
      AppState(
          version: version ?? this.version,
          oauth2: oauth2 ?? this.oauth2,
          page: page ?? this.page,
          user: user ?? this.user,
          post: post ?? this.post);
  String toString() =>
      "AppState(version: $version, oauth2: $oauth2, page: $page, user: $user, post: $post)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      version == other.version &&
      oauth2 == other.oauth2 &&
      page == other.page &&
      user == other.user &&
      post == other.post;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + version.hashCode;
    result = 37 * result + oauth2.hashCode;
    result = 37 * result + page.hashCode;
    result = 37 * result + user.hashCode;
    result = 37 * result + post.hashCode;
    return result;
  }
}

class AppState$ {
  static final version = Lens<AppState, String>(
      (s_) => s_.version, (s_, version) => s_.copyWith(version: version));
  static final oauth2 = Lens<AppState, OAuth2State>(
      (s_) => s_.oauth2, (s_, oauth2) => s_.copyWith(oauth2: oauth2));
  static final page = Lens<AppState, PageState>(
      (s_) => s_.page, (s_, page) => s_.copyWith(page: page));
  static final user = Lens<AppState, UserState>(
      (s_) => s_.user, (s_, user) => s_.copyWith(user: user));
  static final post = Lens<AppState, PostState>(
      (s_) => s_.post, (s_, post) => s_.copyWith(post: post));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    version: json['version'] as String,
    oauth2: json['oauth2'] == null
        ? null
        : OAuth2State.fromJson(json['oauth2'] as Map<String, dynamic>),
    page: json['page'] == null
        ? null
        : PageState.fromJson(json['page'] as Map<String, dynamic>),
    user: json['user'] == null
        ? null
        : UserState.fromJson(json['user'] as Map<String, dynamic>),
    post: json['post'] == null
        ? null
        : PostState.fromJson(json['post'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'version': instance.version,
      'oauth2': instance.oauth2,
      'page': instance.page,
      'user': instance.user,
      'post': instance.post,
    };
