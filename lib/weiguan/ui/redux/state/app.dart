import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

import '../../ui.dart';

part 'app.g.dart';

@JsonSerializable()
@FunctionalData()
class AppState extends $AppState {
  final String version;
  final UserState user;
  final PostState post;
  final PageState page;

  AppState({
    @required this.version,
    UserState user,
    PostState post,
    PageState page,
  })  : this.user = user ?? UserState(),
        this.post = post ?? PostState(),
        this.page = page ?? PageState();

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
