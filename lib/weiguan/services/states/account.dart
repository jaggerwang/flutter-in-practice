import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

import '../../entities/entities.dart';

part 'account.g.dart';

@JsonSerializable()
@FunctionalData()
class AccountState extends $AccountState {
  final UserEntity user;

  AccountState({
    this.user,
  });

  factory AccountState.fromJson(Map<String, dynamic> json) =>
      _$AccountStateFromJson(json);

  Map<String, dynamic> toJson() => _$AccountStateToJson(this);
}
