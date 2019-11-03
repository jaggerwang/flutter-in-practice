import 'dart:io';
import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../container.dart';
import '../../utils/utils.dart';
import '../../entities/entities.dart';
import '../../services/services.dart';
import '../components/components.dart';
import 'pages.dart';

class PublishPage extends StatelessWidget {
  static final _bodyKey = GlobalKey<_BodyState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PostPublishForm>(
      converter: (store) => store.state.post.publishForm,
      distinct: true,
      builder: (context, vm) => Scaffold(
        appBar: AppBar(
          title: Text('发动态'),
          actions: [
            Theme(
              data: Theme.of(context)
                  .copyWith(canvasColor: Theme.of(context).primaryColor),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<PostType>(
                  value: vm.type,
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                  iconEnabledColor: Colors.white,
                  onChanged: (value) =>
                      _bodyKey.currentState._switchType(value),
                  items: PostType.values
                      .map((value) => DropdownMenuItem<PostType>(
                            value: value,
                            child: Text(PostEntity.typeNames[value]),
                          ))
                      .toList(),
                ),
              ),
            ),
            FlatButton(
              onPressed: () => _bodyKey.currentState._submit(),
              child: Text(
                '提交',
                style: Theme.of(context).primaryTextTheme.subhead,
              ),
            ),
          ],
        ),
        body: _Body(key: _bodyKey),
        bottomNavigationBar: WgTabBar(currentIndex: 1),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  _Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  Store<AppState> _store;
  PostPublishForm _vm;
  TextEditingController _textEditingController;
  var _isSubmitting = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _switchType(PostType type) {
    _store.dispatch(PostPublishFormAction(
      form: _vm.copyWith(type: type),
    ));
  }

  void _saveText(String value) {
    _store.dispatch(PostPublishFormAction(
      form: _vm.copyWith(text: value.trim()),
    ));
  }

  void _addFile() async {
    final source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FlatButton(
                  onPressed: () =>
                      Navigator.of(context).pop(ImageSource.gallery),
                  textColor: Theme.of(context).primaryColor,
                  child: Text('从相册选取'),
                ),
                Divider(),
                FlatButton(
                  onPressed: () =>
                      Navigator.of(context).pop(ImageSource.camera),
                  textColor: Theme.of(context).primaryColor,
                  child: Text('用相机拍摄'),
                ),
                Divider(),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('取消'),
                ),
              ],
            ));
    if (source == null) {
      return;
    }

    if (_vm.type == PostType.image) {
      final file = await ImagePicker.pickImage(source: source);
      if (file != null) {
        _store.dispatch(PostPublishFormAction(
          form: _vm.copyWith(images: _vm.images + [file.path]),
        ));
      }
    } else if (_vm.type == PostType.video) {
      final file = await ImagePicker.pickVideo(source: source);
      if (file != null) {
        _store.dispatch(PostPublishFormAction(
          form: _vm.copyWith(video: file.path),
        ));
      }
    }
  }

  void _removeFile(String path) {
    if (_vm.type == PostType.image) {
      _store.dispatch(PostPublishFormAction(
          form: _vm.copyWith(images: [..._vm.images]..remove(path))));
    } else if (_vm.type == PostType.video) {
      _store.dispatch(PostPublishFormAction(
        form: _vm.copyWith(video: null),
      ));
    }
  }

  void _submit() {
    if (_isSubmitting) {
      showSnackBar(context, NoticeEntity(message: '请勿重复提交'));
      return;
    }

    if ((_vm.type == PostType.text && _vm.text == '') ||
        (_vm.type == PostType.image && _vm.images.isEmpty) ||
        (_vm.type == PostType.video && _vm.video == null)) {
      showSnackBar(context, NoticeEntity(message: '内容不能为空'));
      return;
    }

    setState(() {
      _isSubmitting = true;
    });
    final completer = Completer<List<FileEntity>>();
    if (_vm.type == PostType.image || _vm.type == PostType.video) {
      _store.dispatch(storageUploadAction(
        form: StorageUploadForm(
          files: _vm.type == PostType.image ? _vm.images : [_vm.video],
        ),
        onSuccess: (files) => completer.complete(files),
        onFailure: (notice) => completer.completeError(notice),
      ));
    } else {
      completer.complete();
    }

    completer.future.then((files) {
      _store.dispatch(postPublishAction(
        form: _vm.copyWith(
          imageIds: _vm.type == PostType.image
              ? files.map((v) => v.id).toList()
              : null,
          videoId: _vm.type == PostType.video ? files[0].id : null,
        ),
        onSuccess: (id) {
          setState(() {
            _isSubmitting = false;
          });
          _store.dispatch(PostPublishFormAction(form: PostPublishForm()));
          _textEditingController.clear();
          showSnackBar(
              context,
              NoticeEntity(
                message: '发布成功',
                duration: Duration(hours: 24),
                level: NoticeLevel.success,
              ),
              action: SnackBarAction(
                onPressed: () => Scaffold.of(context).removeCurrentSnackBar(),
                label: '知道了',
              ));
        },
        onFailure: (notice) {
          setState(() {
            _isSubmitting = false;
          });
          showSnackBar(
              context,
              notice.copyWith(
                  message: '发布失败：${notice.message}',
                  duration: Duration(hours: 24)),
              action: SnackBarAction(
                onPressed: () => Scaffold.of(context).removeCurrentSnackBar(),
                label: '知道了',
              ));
        },
      ));
    }).catchError((notice) {
      setState(() {
        _isSubmitting = false;
      });
      showSnackBar(
          context,
          notice.copyWith(
              message: '上传失败：${notice.message}', duration: Duration(hours: 24)),
          action: SnackBarAction(
            onPressed: () => Scaffold.of(context).removeCurrentSnackBar(),
            label: '知道了',
          ));
    });
  }

  Widget _buildImagePicker(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final margin = 5.0;
        final columns = 3;
        final width = (constraints.maxWidth - (columns - 1) * margin) / columns;
        final height = width;
        final images = _vm.images.map((v) => File(v)).toList();

        final children = images
            .asMap()
            .entries
            .map<Widget>((entry) => Container(
                  width: width,
                  height: height,
                  color: Colors.grey[200],
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: Feedback.wrapForTap(
                            () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ImagePlayerPage(
                                    files: images,
                                    initialIndex: entry.key,
                                  ),
                                )),
                            context),
                        child: Image.file(
                          entry.value,
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: Feedback.wrapForTap(
                              () => _removeFile(entry.value.path), context),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.clear, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList();

        if (_vm.images.length < 6) {
          children.add(GestureDetector(
            onTap: Feedback.wrapForTap(_addFile, context),
            child: Container(
              width: width,
              height: height,
              color: Colors.grey[200],
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.grey[500],
                  size: 32,
                ),
              ),
            ),
          ));
        }

        return Wrap(
          spacing: margin,
          runSpacing: margin,
          children: children,
        );
      },
    );
  }

  Widget _buildVideoPicker(BuildContext context) {
    if (_vm.video != null) {
      return Stack(
        fit: StackFit.passthrough,
        children: [
          VideoPlayerWithControlBar(file: File(_vm.video)),
          Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: Feedback.wrapForTap(() => _removeFile(_vm.video), context),
              child: Container(
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.clear, color: Colors.white)),
            ),
          ),
        ],
      );
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: GestureDetector(
        onTap: Feedback.wrapForTap(_addFile, context),
        child: Container(
          color: Colors.grey[200],
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.grey[500],
              size: 32,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PostPublishForm>(
      onInit: (store) {
        _store = store;
        _textEditingController =
            TextEditingController(text: store.state.post.publishForm.text);
      },
      converter: (store) {
        _vm = store.state.post.publishForm;
        return _vm;
      },
      distinct: true,
      builder: (context, vm) => Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              padding: EdgeInsets.all(WgContainer().theme.paddingSizeNormal),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: _textEditingController,
                    maxLength: 1000,
                    maxLengthEnforced: true,
                    maxLines: 5,
                    onChanged: _saveText,
                    decoration: InputDecoration(
                      hintText: '说点儿啥',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (vm.type == PostType.image)
                  Container(
                    margin: EdgeInsets.only(
                        top: WgContainer().theme.marginSizeNormal),
                    child: _buildImagePicker(context),
                  ),
                if (vm.type == PostType.video)
                  Container(
                    margin: EdgeInsets.only(
                        top: WgContainer().theme.marginSizeNormal),
                    child: _buildVideoPicker(context),
                  ),
              ],
            ),
          ),
          Visibility(
            visible: _isSubmitting,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
