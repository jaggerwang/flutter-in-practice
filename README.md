# Flutter in Practice

This project is the reference source code of online video course [叽歪课程 - Flutter 移动应用开发实战](https://blog.jaggerwang.net/jwcourse-flutter-mobile-app-develop-in-practice/), including usage demo of flutter components and a social video app weiguan like tiktok.

> To students of course: 最新的实战项目目录结构已按照新版 [干净架构最佳实践](https://blog.jaggerwang.net/clean-architecture-in-practice/) 进行了重构，目录结构调整较大。如想获取之前版本，可查看提交记录。

## Dependent frameworks and packages

1. [Flutter](https://flutter.dev/)
1. [cached_network_image](https://pub.dev/packages/cached_network_image)
1. [carousel_slider](https://pub.dev/packages/carousel_slider)
1. [cookie_jar](https://pub.dev/packages/cookie_jar)
1. [dio](https://pub.dev/packages/dio)
1. [flutter_redux](https://pub.dev/packages/flutter_redux)
1. [functional_data](https://pub.dev/packages/functional_data)
1. [image_picker](https://pub.dev/packages/image_picker)
1. [injector](https://pub.dev/packages/injector)
1. [json_annotation](https://pub.dev/packages/json_annotation)
1. [logging](https://pub.dev/packages/logging)
1. [meta](https://pub.dev/packages/meta)
1. [package_info](https://pub.dev/packages/package_info)
1. [provider](https://pub.dev/packages/provider)
1. [redux](https://pub.dev/packages/redux)
1. [redux_logging](https://pub.dev/packages/redux_logging)
1. [redux_persist](https://pub.dev/packages/redux_persist)
1. [redux_persist_flutter](https://pub.dev/packages/redux_persist_flutter)
1. [redux_thunk](https://pub.dev/packages/redux_thunk)
1. [video_player](https://pub.dev/packages/video_player)
1. [build_runner](https://pub.dev/packages/build_runner)
1. [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
1. [functional_data_generator](https://pub.dev/packages/functional_data_generator)
1. [json_serializable](https://pub.dev/packages/json_serializable)

## How to run

### Install flutter sdk

Please refer to flutter official document [Install](https://flutter.dev/docs/get-started/install).

### Clone repository

```bash
git clone git@github.com:jaggerwang/flutter-in-practice.git && cd flutter-in-practice
```

### Install dependent packages

```bash
flutter packages get
```

### Connect a device or run a simulator

Connet your Android or iOS device to your computer or run a simulator using the following commands.

```bash
$ flutter emulators
2 available emulators:

9.0-1080p           • 9.0-1080p     • Google • android
apple_ios_simulator • iOS Simulator • Apple  • ios

...
$ flutter emulators --launch apple_ios_simulator
```

### Run app

This repository contains several apps.

To run flutter demo:

```bash
flutter run -t lib/demo/main.dart
```

To run weiguan:

```bash
flutter run -t lib/weiguan/mobile/main.dart
```

The weiguan app need a backend api service, as default it will use a mocked api service. You can enable `enableRestApi` option to use a real service from [Sanic in Practice](https://github.com/jaggerwang/sanic-in-practice) or [Spring Boot in Practice](https://github.com/jaggerwang/spring-boot-in-practice). The later one also supplys a graphql api service, you can enable `enableGraphQLApi` option to use it.

If you want to see more log info, you can run weiguan in dev mode:

```bash
flutter run -t lib/weiguan/mobile/main_dev.dart
```

> The video player can not work on iOS simulator, you should use an Android emulator or a real device.

## Screenshots

<p float="left">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/demo-drawer.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/demo-lake.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/demo-silver-app-bar.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/demo-tab-navigation.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/weiguan-home-1.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/weiguan-publish.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/weiguan-me-2.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/weiguan-user.png" width="240">
</p>
