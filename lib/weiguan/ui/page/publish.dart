import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../entity/entity.dart';
import '../../container.dart';
import '../ui.dart';

class PublishPage extends StatelessWidget {
  static final _bodyKey = GlobalKey<_BodyState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(bodyKey: _bodyKey),
      body: _Body(key: _bodyKey),
      bottomNavigationBar: WgTabBar(currentIndex: 1),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<_BodyState> bodyKey;

  _AppBar({@required this.bodyKey});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PostPublishForm>(
      converter: (store) => store.state.page.publishForm,
      distinct: true,
      builder: (context, vm) => AppBar(
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
                onChanged: (value) => bodyKey.currentState._switchType(value),
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
            onPressed: () => bodyKey.currentState._submit(),
            child: Text(
              '提交',
              style: Theme.of(context).primaryTextTheme.subhead,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _Body extends StatefulWidget {
  _Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  PostPublishForm _vm;
  TextEditingController _textEditingController;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _switchType(PostType type) {
    WgContainer()
        .basePresenter
        .dispatchAction(PageStateAction(publishForm: _vm.copyWith(type: type)));
  }

  void _saveText(String value) {
    WgContainer().basePresenter.dispatchAction(
        PageStateAction(publishForm: _vm.copyWith(text: value.trim())));
  }

  void _addFile() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SelectImageSource(),
    );
    if (source == null) {
      return;
    }

    if (_vm.type == PostType.IMAGE) {
      final file = await ImagePicker.pickImage(source: source);
      if (file != null) {
        WgContainer().basePresenter.dispatchAction(PageStateAction(
            publishForm: _vm.copyWith(images: _vm.images + [file.path])));
      }
    } else if (_vm.type == PostType.VIDEO) {
      final file = await ImagePicker.pickVideo(source: source);
      if (file != null) {
        WgContainer().basePresenter.dispatchAction(
            PageStateAction(publishForm: _vm.copyWith(video: file.path)));
      }
    }
  }

  void _removeFile(String path) {
    if (_vm.type == PostType.IMAGE) {
      WgContainer().basePresenter.dispatchAction(PageStateAction(
          publishForm: _vm.copyWith(images: [..._vm.images]..remove(path))));
    } else if (_vm.type == PostType.VIDEO) {
      WgContainer().basePresenter.dispatchAction(
          PageStateAction(publishForm: _vm.copyWith(video: null)));
    }
  }

  void _submit() async {
    if ((_vm.type == PostType.TEXT && _vm.text == '') ||
        (_vm.type == PostType.IMAGE && _vm.images.isEmpty) ||
        (_vm.type == PostType.VIDEO && _vm.video == null)) {
      WgContainer().basePresenter.showMessage('内容不能为空');
      return;
    }

    WgContainer().basePresenter.doWithLoading(() async {
      await WgContainer().postPresenter.publish(_vm);

      WgContainer()
          .basePresenter
          .dispatchAction(PageStateAction(publishForm: PostPublishForm()));
      _textEditingController.clear();
      WgContainer()
          .basePresenter
          .showMessage('发布成功', level: MessageLevel.SUCCESS);
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
                            () => WgContainer()
                                .basePresenter
                                .navigator()
                                .push(MaterialPageRoute(
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
        _textEditingController =
            TextEditingController(text: store.state.page.publishForm.text);
      },
      converter: (store) {
        _vm = store.state.page.publishForm;
        return _vm;
      },
      distinct: true,
      builder: (context, vm) => GestureDetector(
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
            if (vm.type == PostType.IMAGE)
              Container(
                margin:
                    EdgeInsets.only(top: WgContainer().theme.marginSizeNormal),
                child: _buildImagePicker(context),
              ),
            if (vm.type == PostType.VIDEO)
              Container(
                margin:
                    EdgeInsets.only(top: WgContainer().theme.marginSizeNormal),
                child: _buildVideoPicker(context),
              ),
          ],
        ),
      ),
    );
  }
}
