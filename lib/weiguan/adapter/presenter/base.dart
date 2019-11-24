import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:redux/redux.dart';

import '../../entity/entity.dart';
import '../../ui/ui.dart';
import '../../usecase/usecase.dart';
import '../../container.dart';

class BasePresenter {
  Store<AppState> appStore;

  BasePresenter({@required this.appStore});

  NavigatorState navigator([BuildContext context]) {
    return context == null
        ? WgContainer().rootNavigatorKey.currentState
        : Navigator.of(context);
  }

  void dispatchAction(BaseAction action) {
    appStore.dispatch(action);
  }

  void handleException(Exception e) {
    if (e is UnauthenticatedException) {
      showNotification("您的登录已过期，点击通知可重新登录。",
          onTap: () =>
              navigator().pushNamedAndRemoveUntil("/", (route) => false));
    } else if (e is UsecaseException) {
      showMessage(e.message);
    } else {
      showMessage(e.toString());
    }
  }

  void showMessage(
    String text, {
    MessageLevel level = MessageLevel.ERROR,
    Duration duration = const Duration(seconds: 4),
  }) {
    Color backgroundColor;
    switch (level) {
      case MessageLevel.INFO:
        backgroundColor = Colors.blue[100];
        break;
      case MessageLevel.WARNING:
        backgroundColor = Colors.yellow[100];
        break;
      case MessageLevel.SUCCESS:
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

  void showNotification(
    String title, {
    String subtitle,
    NotificationLevel level = NotificationLevel.ERROR,
    Duration duration = const Duration(seconds: 4),
    VoidCallback onTap,
  }) {
    IconData iconData;
    switch (level) {
      case NotificationLevel.INFO:
        iconData = Icons.info;
        break;
      case NotificationLevel.WARNING:
        iconData = Icons.warning;
        break;
      case NotificationLevel.SUCCESS:
        iconData = Icons.check_circle;
        break;
      default:
        iconData = Icons.error;
    }

    Color iconColor;
    switch (level) {
      case NotificationLevel.INFO:
        iconColor = Colors.blue[500];
        break;
      case NotificationLevel.WARNING:
        iconColor = Colors.yellow[500];
        break;
      case NotificationLevel.SUCCESS:
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

  Future<T> doWithLoading<T>(Future<T> Function() doSomething) async {
    final cancelLoading = showLoading();
    T result;
    try {
      result = await doSomething();
    } on Exception catch (e) {
      handleException(e);
    } finally {
      cancelLoading();
    }
    return result;
  }
}
