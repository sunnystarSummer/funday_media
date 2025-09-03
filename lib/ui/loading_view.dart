import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingView {
  // 私有建構子
  LoadingView._();

  static TransitionBuilder init() => EasyLoading.init();

  static void config() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      // ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      // ..progressColor = Colors.yellow
      // ..backgroundColor = Colors.green
      // ..indicatorColor = Colors.yellow
      // ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withValues(alpha: 0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static Future<void> show() async => await EasyLoading.show();

  static Future<void> showProgress(int received, int total) async {
    if (received != total) {
      // final progressValue = "${(received / total * 100).toStringAsFixed(0)}%";

      await EasyLoading.showProgress(received / total);
    } else {
      await dismiss();
    }
  }

  static Future<void> dismiss() async => await EasyLoading.dismiss();
}
