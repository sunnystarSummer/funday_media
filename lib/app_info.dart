import 'package:funday_media/service/serverType.dart';

// Flutter 3.32.8 • channel stable • https://github.com/flutter/flutter.git
// Framework • revision edada7c56e (5 weeks ago) • 2025-07-25 14:08:03 +0000
// Engine • revision ef0cd00091 (5 weeks ago) • 2025-07-24 12:23:50 -0700
// Tools • Dart 3.8.1 • DevTools 2.45.1

// App Version: 1.0.0+1
// Git Hash: 7bf303f

class AppInfo {
  static ServerType serverType = ServerType.release;

  static String getAppInfo() {
    return "1.0.0+1\n7bf303f";
  }

  static String getFlutterInfo() {
    return "Flutter 3.32.8 • channel stable • https://github.com/flutter/flutter.git\n"
"Framework • revision edada7c56e (5 weeks ago) • 2025-07-25 14:08:03 +0000\n"
"Engine • revision ef0cd00091 (5 weeks ago) • 2025-07-24 12:23:50 -0700\n"
"Tools • Dart 3.8.1 • DevTools 2.45.1\n";
  }
}
