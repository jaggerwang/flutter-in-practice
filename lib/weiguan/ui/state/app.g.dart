// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $AppState {
  String get version;
  AccountState get account;
  PostState get post;
  const $AppState();
  AppState copyWith({String version, AccountState account, PostState post}) =>
      AppState(
          version: version ?? this.version,
          account: account ?? this.account,
          post: post ?? this.post);
  String toString() =>
      "AppState(version: $version, account: $account, post: $post)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      version == other.version &&
      account == other.account &&
      post == other.post;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + version.hashCode;
    result = 37 * result + account.hashCode;
    result = 37 * result + post.hashCode;
    return result;
  }
}

class AppState$ {
  static final version = Lens<AppState, String>(
      (s_) => s_.version, (s_, version) => s_.copyWith(version: version));
  static final account = Lens<AppState, AccountState>(
      (s_) => s_.account, (s_, account) => s_.copyWith(account: account));
  static final post = Lens<AppState, PostState>(
      (s_) => s_.post, (s_, post) => s_.copyWith(post: post));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    version: json['version'] as String,
    account: json['account'] == null
        ? null
        : AccountState.fromJson(json['account'] as Map<String, dynamic>),
    post: json['post'] == null
        ? null
        : PostState.fromJson(json['post'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'version': instance.version,
      'account': instance.account,
      'post': instance.post,
    };
