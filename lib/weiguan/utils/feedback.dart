import 'package:flutter/material.dart';

import '../entities/entities.dart';

void showSnackBar(BuildContext context, NoticeEntity notice,
    {SnackBarAction action}) {
  Color bgColor;
  if (notice.level == NoticeLevel.info) {
    bgColor = Colors.blue[100];
  } else if (notice.level == NoticeLevel.warning) {
    bgColor = Colors.yellow[100];
  } else if (notice.level == NoticeLevel.error) {
    bgColor = Colors.red[100];
  } else if (notice.level == NoticeLevel.success) {
    bgColor = Colors.green[100];
  }

  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(
      notice.message,
      style: Theme.of(context).textTheme.body1,
    ),
    duration: notice.duration,
    action: action,
    backgroundColor: bgColor,
  ));
}
