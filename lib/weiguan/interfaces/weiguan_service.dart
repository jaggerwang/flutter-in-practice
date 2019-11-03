import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

part 'weiguan_service.g.dart';

@JsonSerializable()
@FunctionalData()
class WgResponse extends $WgResponse {
  static const codeError = 'error';
  static const codeOk = 'ok';
  static const codeFail = 'fail';
  static const codeDuplicate = 'duplicate';

  final String code;
  final String message;
  final Map<String, dynamic> data;

  WgResponse({
    this.code = codeOk,
    this.message = '',
    this.data = const {},
  });

  factory WgResponse.fromJson(Map<String, dynamic> json) =>
      _$WgResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WgResponseToJson(this);
}

abstract class IWgService {
  Future<WgResponse> get(String path, [Map<String, dynamic> data]);

  Future<WgResponse> post(String path, Map<String, dynamic> data);

  Future<WgResponse> postForm(String path, Map<String, dynamic> data);
}
