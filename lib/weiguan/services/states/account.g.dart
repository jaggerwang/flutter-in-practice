// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $AccountState {
  UserEntity get user;
  const $AccountState();
  AccountState copyWith({UserEntity user}) =>
      AccountState(user: user ?? this.user);
  String toString() => "AccountState(user: $user)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType && user == other.user;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + user.hashCode;
    return result;
  }
}

class AccountState$ {
  static final user = Lens<AccountState, UserEntity>(
      (s_) => s_.user, (s_, user) => s_.copyWith(user: user));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountState _$AccountStateFromJson(Map<String, dynamic> json) {
  return AccountState(
    user: json['user'] == null
        ? null
        : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AccountStateToJson(AccountState instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
