import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../container.dart';

class SelectImageSource extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FlatButton(
          onPressed: () => WgContainer()
              .basePresenter
              .navigator(context)
              .pop(ImageSource.gallery),
          textColor: Theme.of(context).primaryColor,
          child: Text('从相册选取'),
        ),
        Divider(),
        FlatButton(
          onPressed: () => WgContainer()
              .basePresenter
              .navigator(context)
              .pop(ImageSource.camera),
          textColor: Theme.of(context).primaryColor,
          child: Text('用相机拍摄'),
        ),
        Divider(),
        FlatButton(
          onPressed: () => WgContainer().basePresenter.navigator(context).pop(),
          child: Text('取消'),
        ),
      ],
    );
  }
}
