// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $AccountRegisterForm {
  String get username;
  String get password;
  const $AccountRegisterForm();
  AccountRegisterForm copyWith({String username, String password}) =>
      AccountRegisterForm(
          username: username ?? this.username,
          password: password ?? this.password);
  String toString() =>
      "AccountRegisterForm(username: $username, password: $password)";
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

class AccountRegisterForm$ {
  static final username = Lens<AccountRegisterForm, String>(
      (s_) => s_.username, (s_, username) => s_.copyWith(username: username));
  static final password = Lens<AccountRegisterForm, String>(
      (s_) => s_.password, (s_, password) => s_.copyWith(password: password));
}

abstract class $AccountLoginForm {
  String get username;
  String get mobile;
  String get password;
  const $AccountLoginForm();
  AccountLoginForm copyWith(
          {String username, String mobile, String password}) =>
      AccountLoginForm(
          username: username ?? this.username,
          mobile: mobile ?? this.mobile,
          password: password ?? this.password);
  String toString() =>
      "AccountLoginForm(username: $username, mobile: $mobile, password: $password)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      username == other.username &&
      mobile == other.mobile &&
      password == other.password;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + username.hashCode;
    result = 37 * result + mobile.hashCode;
    result = 37 * result + password.hashCode;
    return result;
  }
}

class AccountLoginForm$ {
  static final username = Lens<AccountLoginForm, String>(
      (s_) => s_.username, (s_, username) => s_.copyWith(username: username));
  static final mobile = Lens<AccountLoginForm, String>(
      (s_) => s_.mobile, (s_, mobile) => s_.copyWith(mobile: mobile));
  static final password = Lens<AccountLoginForm, String>(
      (s_) => s_.password, (s_, password) => s_.copyWith(password: password));
}

abstract class $AccountProfileForm {
  String get username;
  String get password;
  String get mobile;
  String get email;
  int get avatarId;
  String get intro;
  String get code;
  const $AccountProfileForm();
  AccountProfileForm copyWith(
          {String username,
          String password,
          String mobile,
          String email,
          int avatarId,
          String intro,
          String code}) =>
      AccountProfileForm(
          username: username ?? this.username,
          password: password ?? this.password,
          mobile: mobile ?? this.mobile,
          email: email ?? this.email,
          avatarId: avatarId ?? this.avatarId,
          intro: intro ?? this.intro,
          code: code ?? this.code);
  String toString() =>
      "AccountProfileForm(username: $username, password: $password, mobile: $mobile, email: $email, avatarId: $avatarId, intro: $intro, code: $code)";
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

class AccountProfileForm$ {
  static final username = Lens<AccountProfileForm, String>(
      (s_) => s_.username, (s_, username) => s_.copyWith(username: username));
  static final password = Lens<AccountProfileForm, String>(
      (s_) => s_.password, (s_, password) => s_.copyWith(password: password));
  static final mobile = Lens<AccountProfileForm, String>(
      (s_) => s_.mobile, (s_, mobile) => s_.copyWith(mobile: mobile));
  static final email = Lens<AccountProfileForm, String>(
      (s_) => s_.email, (s_, email) => s_.copyWith(email: email));
  static final avatarId = Lens<AccountProfileForm, int>(
      (s_) => s_.avatarId, (s_, avatarId) => s_.copyWith(avatarId: avatarId));
  static final intro = Lens<AccountProfileForm, String>(
      (s_) => s_.intro, (s_, intro) => s_.copyWith(intro: intro));
  static final code = Lens<AccountProfileForm, String>(
      (s_) => s_.code, (s_, code) => s_.copyWith(code: code));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountRegisterForm _$AccountRegisterFormFromJson(Map<String, dynamic> json) {
  return AccountRegisterForm(
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$AccountRegisterFormToJson(
        AccountRegisterForm instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

AccountLoginForm _$AccountLoginFormFromJson(Map<String, dynamic> json) {
  return AccountLoginForm(
    username: json['username'] as String,
    mobile: json['mobile'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$AccountLoginFormToJson(AccountLoginForm instance) =>
    <String, dynamic>{
      'username': instance.username,
      'mobile': instance.mobile,
      'password': instance.password,
    };

AccountProfileForm _$AccountProfileFormFromJson(Map<String, dynamic> json) {
  return AccountProfileForm(
    username: json['username'] as String,
    password: json['password'] as String,
    mobile: json['mobile'] as String,
    email: json['email'] as String,
    avatarId: json['avatarId'] as int,
    intro: json['intro'] as String,
    code: json['code'] as String,
  );
}

Map<String, dynamic> _$AccountProfileFormToJson(AccountProfileForm instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'mobile': instance.mobile,
      'email': instance.email,
      'avatarId': instance.avatarId,
      'intro': instance.intro,
      'code': instance.code,
    };
