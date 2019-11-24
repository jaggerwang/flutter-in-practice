import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

part 'user.g.dart';

@JsonSerializable()
@FunctionalData()
class UserLoginForm extends $UserLoginForm {
  String username;
  String password;

  UserLoginForm({
    this.username,
    this.password,
  });

  factory UserLoginForm.fromJson(Map<String, dynamic> json) =>
      _$UserLoginFormFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginFormToJson(this);
}

@JsonSerializable()
@FunctionalData()
class UserRegisterForm extends $UserRegisterForm {
  String username;
  String password;

  UserRegisterForm({
    this.username,
    this.password,
  });

  factory UserRegisterForm.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterFormFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterFormToJson(this);
}

@JsonSerializable()
@FunctionalData()
class UserProfileForm extends $UserProfileForm {
  String username;
  String password;
  String mobile;
  String email;
  int avatarId;
  String intro;
  String code;

  UserProfileForm({
    this.username,
    this.password,
    this.mobile,
    this.email,
    this.avatarId,
    this.intro,
    this.code,
  });

  factory UserProfileForm.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFormFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileFormToJson(this);
}
