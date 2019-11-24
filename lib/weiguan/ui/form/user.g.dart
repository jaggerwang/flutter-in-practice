// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $UserLoginForm {
  String get username;
  String get password;
  const $UserLoginForm();
  UserLoginForm copyWith({String username, String password}) => UserLoginForm(
      username: username ?? this.username, password: password ?? this.password);
  String toString() =>
      "UserLoginForm(username: $username, password: $password)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      username == other.username &&
      password == other.password;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + username.hashCode;
    result = 37 * result + password.hashCode;
    return result;
  }
}

class UserLoginForm$ {
  static final username = Lens<UserLoginForm, String>(
      (s_) => s_.username, (s_, username) => s_.copyWith(username: username));
  static final password = Lens<UserLoginForm, String>(
      (s_) => s_.password, (s_, password) => s_.copyWith(password: password));
}

abstract class $UserRegisterForm {
  String get username;
  String get password;
  const $UserRegisterForm();
  UserRegisterForm copyWith({String username, String password}) =>
      UserRegisterForm(
          username: username ?? this.username,
          password: password ?? this.password);
  String toString() =>
      "UserRegisterForm(username: $username, password: $password)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      username == other.username &&
      password == other.password;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + username.hashCode;
    result = 37 * result + password.hashCode;
    return result;
  }
}

class UserRegisterForm$ {
  static final username = Lens<UserRegisterForm, String>(
      (s_) => s_.username, (s_, username) => s_.copyWith(username: username));
  static final password = Lens<UserRegisterForm, String>(
      (s_) => s_.password, (s_, password) => s_.copyWith(password: password));
}

abstract class $UserProfileForm {
  String get username;
  String get password;
  String get mobile;
  String get email;
  int get avatarId;
  String get intro;
  String get code;
  const $UserProfileForm();
  UserProfileForm copyWith(
          {String username,
          String password,
          String mobile,
          String email,
          int avatarId,
          String intro,
          String code}) =>
      UserProfileForm(
          username: username ?? this.username,
          password: password ?? this.password,
          mobile: mobile ?? this.mobile,
          email: email ?? this.email,
          avatarId: avatarId ?? this.avatarId,
          intro: intro ?? this.intro,
          code: code ?? this.code);
  String toString() =>
      "UserProfileForm(username: $username, password: $password, mobile: $mobile, email: $email, avatarId: $avatarId, intro: $intro, code: $code)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      username == other.username &&
      password == other.password &&
      mobile == other.mobile &&
      email == other.email &&
      avatarId == other.avatarId &&
      intro == other.intro &&
      code == other.code;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + username.hashCode;
    result = 37 * result + password.hashCode;
    result = 37 * result + mobile.hashCode;
    result = 37 * result + email.hashCode;
    result = 37 * result + avatarId.hashCode;
    result = 37 * result + intro.hashCode;
    result = 37 * result + code.hashCode;
    return result;
  }
}

class UserProfileForm$ {
  static final username = Lens<UserProfileForm, String>(
      (s_) => s_.username, (s_, username) => s_.copyWith(username: username));
  static final password = Lens<UserProfileForm, String>(
      (s_) => s_.password, (s_, password) => s_.copyWith(password: password));
  static final mobile = Lens<UserProfileForm, String>(
      (s_) => s_.mobile, (s_, mobile) => s_.copyWith(mobile: mobile));
  static final email = Lens<UserProfileForm, String>(
      (s_) => s_.email, (s_, email) => s_.copyWith(email: email));
  static final avatarId = Lens<UserProfileForm, int>(
      (s_) => s_.avatarId, (s_, avatarId) => s_.copyWith(avatarId: avatarId));
  static final intro = Lens<UserProfileForm, String>(
      (s_) => s_.intro, (s_, intro) => s_.copyWith(intro: intro));
  static final code = Lens<UserProfileForm, String>(
      (s_) => s_.code, (s_, code) => s_.copyWith(code: code));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginForm _$UserLoginFormFromJson(Map<String, dynamic> json) {
  return UserLoginForm(
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserLoginFormToJson(UserLoginForm instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

UserRegisterForm _$UserRegisterFormFromJson(Map<String, dynamic> json) {
  return UserRegisterForm(
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserRegisterFormToJson(UserRegisterForm instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

UserProfileForm _$UserProfileFormFromJson(Map<String, dynamic> json) {
  return UserProfileForm(
    username: json['username'] as String,
    password: json['password'] as String,
    mobile: json['mobile'] as String,
    email: json['email'] as String,
    avatarId: json['avatarId'] as int,
    intro: json['intro'] as String,
    code: json['code'] as String,
  );
}

Map<String, dynamic> _$UserProfileFormToJson(UserProfileForm instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'mobile': instance.mobile,
      'email': instance.email,
      'avatarId': instance.avatarId,
      'intro': instance.intro,
      'code': instance.code,
    };
