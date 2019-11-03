import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

enum MessageLevel { info, warning, error, success }

void showMessage(
  String text, {
  MessageLevel level = MessageLevel.error,
  Duration duration = const Duration(seconds: 4),
}) {
  Color backgroundColor;
  switch (level) {
    case MessageLevel.info:
      backgroundColor = Colors.blue[100];
      break;
    case MessageLevel.warning:
      backgroundColor = Colors.yellow[100];
      break;
    case MessageLevel.success:
      backgroundColor = Colors.green[100];
      break;
    default:
      backgroundColor = Colors.red[100];
  }

  BotToast.showText(
    text: text,
    duration: duration,
    contentColor: backgroundColor,
    textStyle: TextStyle(fontSize: 16, color: Colors.black87),
  );
}

enum NotificationLevel { info, warning, error, success }

void showNotification(
  String title, {
  String subtitle,
  NotificationLevel level = NotificationLevel.error,
  Duration duration = const Duration(seconds: 4),
  VoidCallback onTap,
}) {
  IconData iconData;
  switch (level) {
    case NotificationLevel.info:
      iconData = Icons.info;
      break;
    case NotificationLevel.warning:
      iconData = Icons.warning;
      break;
    case NotificationLevel.success:
      iconData = Icons.check_circle;
      break;
    default:
      iconData = Icons.error;
  }

  Color iconColor;
  switch (level) {
    case NotificationLevel.info:
      iconColor = Colors.blue[500];
      break;
    case NotificationLevel.warning:
      iconColor = Colors.yellow[500];
      break;
    case NotificationLevel.success:
      iconColor = Colors.green[500];
      break;
    default:
      iconColor = Colors.red[500];
  }

  BotToast.showNotification(
    title: (_) => Text(title),
    subtitle: (_) => subtitle == null ? null : Text(subtitle),
    leading: (_) => Icon(iconData, color: iconColor),
    trailing: (cancel) =>
        IconButton(icon: Icon(Icons.close), onPressed: cancel),
    duration: duration,
    onTap: onTap,
  );
}

VoidCallback showLoading() {
  return BotToast.showLoading();
}
