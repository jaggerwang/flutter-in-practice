import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

import '../../container.dart';
import '../../entities/entities.dart';
import '../../interfaces/interfaces.dart';
import '../forms/forms.dart';
import '../states/states.dart';

ThunkAction<AppState> storageUploadAction({
  @required StorageUploadForm form,
  void Function(List<FileEntity>) onSuccess,
  void Function(NoticeEntity) onFailure,
}) =>
    (Store<AppState> store) async {
      final data = FormData.from(form.toJson());

      data['files'] = form.files
          .map(
            (v) => UploadFileInfo(File(v), basename(v),
                contentType: ContentType.parse(lookupMimeType(v))),
          )
          .toList();

      final response =
          await WgContainer().wgService.postForm('/storage/upload', data);

      if (response.code == WgResponse.codeOk) {
        final files = (response.data['files'] as List<Map<String, dynamic>>)
            .map((v) => FileEntity.fromJson(v))
            .toList();
        if (onSuccess != null) onSuccess(files);
      } else {
        if (onFailure != null)
          onFailure(NoticeEntity(message: response.message));
      }
    };
