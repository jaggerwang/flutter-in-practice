import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

import '../ui.dart';

part 'app.g.dart';

@JsonSerializable()
@FunctionalData()
class AppState extends $AppState {
  final String version;
  final AccountState account;
  final PostState post;

  AppState({
    @required this.version,
    AccountState account,
    PostState post,
  })  : this.account = account ?? AccountState(),
        this.post = post ?? PostState();

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
