import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

part 'account.g.dart';

@JsonSerializable()
@FunctionalData()
class AccountLoginForm extends $AccountLoginForm {
  String username;
  String mobile;
  String password;

  AccountLoginForm({
    this.username,
    this.mobile,
    this.password,
  });

  factory AccountLoginForm.fromJson(Map<String, dynamic> json) =>
      _$AccountLoginFormFromJson(json);

  Map<String, dynamic> toJson() => _$AccountLoginFormToJson(this);
}

@JsonSerializable()
@FunctionalData()
class AccountRegisterForm extends $AccountRegisterForm {
  String username;
  String password;

  AccountRegisterForm({
    this.username,
    this.password,
  });

  factory AccountRegisterForm.fromJson(Map<String, dynamic> json) =>
      _$AccountRegisterFormFromJson(json);

  Map<String, dynamic> toJson() => _$AccountRegisterFormToJson(this);
}

@JsonSerializable()
@FunctionalData()
class AccountProfileForm extends $AccountProfileForm {
  String username;
  String password;
  String mobile;
  String email;
  int avatarId;
  String intro;
  String code;

  AccountProfileForm({
    this.username,
    this.password,
    this.mobile,
    this.email,
    this.avatarId,
    this.intro,
    this.code,
  });

  factory AccountProfileForm.fromJson(Map<String, dynamic> json) =>
      _$AccountProfileFormFromJson(json);

  Map<String, dynamic> toJson() => _$AccountProfileFormToJson(this);
}
