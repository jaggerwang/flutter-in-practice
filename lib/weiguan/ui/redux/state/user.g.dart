// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $UserState {
  UserEntity get logged;
  const $UserState();
  UserState copyWith({UserEntity logged}) =>
      UserState(logged: logged ?? this.logged);
  String toString() => "UserState(logged: $logged)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType && logged == other.logged;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + logged.hashCode;
    return result;
  }
}

class UserState$ {
  static final logged = Lens<UserState, UserEntity>(
      (s_) => s_.logged, (s_, logged) => s_.copyWith(logged: logged));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserState _$UserStateFromJson(Map<String, dynamic> json) {
  return UserState(
    logged: json['logged'] == null
        ? null
        : UserEntity.fromJson(json['logged'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserStateToJson(UserState instance) => <String, dynamic>{
      'logged': instance.logged,
    };
