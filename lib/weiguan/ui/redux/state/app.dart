import 'package:flutter/widgets.dart';
import 'package:flutter_in_practice/weiguan/ui/redux/state/oauth2.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

import '../../ui.dart';

part 'app.g.dart';

@JsonSerializable()
@FunctionalData()
class AppState extends $AppState {
  final String version;
  final OAuth2State oauth2;
  final PageState page;
  final UserState user;
  final PostState post;

  AppState({
    @required this.version,
    OAuth2State oauth2,
    PageState page,
    UserState user,
    PostState post,
  })  : this.oauth2 = oauth2 ?? OAuth2State(),
        this.page = page ?? PageState(),
        this.user = user ?? UserState(),
        this.post = post ?? PostState();

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
