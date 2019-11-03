# Flutter in Practice

This project is the reference source code of online video course [叽歪课程 - Flutter 移动应用开发实战](https://blog.jaggerwang.net/jwcourse-flutter-mobile-app-develop-in-practice/), including usage demo of flutter components and a social video app weiguan like tiktok.

## Screenshots

<p float="left">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/demo-drawer.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/demo-lake.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/demo-silver-app-bar.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/demo-tab-navigation.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/weiguan-home-1.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/weiguan-publish.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/weiguan-me.png" width="240">
  <img src="https://jw-asset.oss-cn-shanghai.aliyuncs.com/course/flutter-in-practice/screenshot/weiguan-user.png" width="240">
</p>

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

> The video player can not work on iOS simulator, you should use an Android emulator or a real device.

To run weiguan in development mode:

```bash
flutter run -t lib/weiguan/mobile/main_dev.dart
```

The weiguan app default use a mocked api service, you can replace it with a real api service supplied by [Sanic in Practice](https://github.com/jaggerwang/sanic-in-practice). Please remember to change the main file as the following:

```dart
...

void main() async {
  final container = WgContainer(WgConfig(
    ...
    isMockApi: false,
    wgApiBase: 'http://localhost:8000',
  ));
  await container.onReady;

  ...
}
```

## Changelog

### 2019-11-03

1. Upgrade Flutter SDK to v1.9.

### 2019-05-25

1. Upgrade Flutter SDK to v1.5.

### 2019-01-14

1. First release.
