import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

import '../../../entity/entity.dart';

part 'user.g.dart';

@JsonSerializable()
@FunctionalData()
class UserState extends $UserState {
  final UserEntity logged;

  UserState({
    this.logged,
  });

  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);

  Map<String, dynamic> toJson() => _$UserStateToJson(this);
}
