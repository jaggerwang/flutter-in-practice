import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';

part 'notice.g.dart';

enum NoticeLevel { info, warning, error, success }

@JsonSerializable()
@FunctionalData()
class NoticeEntity extends $NoticeEntity {
  final String message;
  final NoticeLevel level;
  final Duration duration;

  const NoticeEntity({
    @required this.message,
    this.level = NoticeLevel.error,
    this.duration = const Duration(seconds: 4),
  });

  factory NoticeEntity.fromJson(Map<String, dynamic> json) =>
      _$NoticeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeEntityToJson(this);
}
