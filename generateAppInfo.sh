#!/bin/bash

# 讀取gitSortHash
gitSortHash=$(git rev-parse --short HEAD)

# 讀取版本號
VERSION=$(grep -m1 version: pubspec.yaml | awk '{print $2}' | sed 's/ //g' | sed 's/"//g')

flutterVersionInfo=$(flutter --version | sed 's/.*/"&\\n"/')
# 讀取 Flutter 版本資訊，並為每行添加 //
flutterVersionInfoWithChangeLine=$(flutter --version | sed 's/^/\/\/ /')

# 設定檔案路徑和檔案名稱
file_path="lib"
file_name="app_info.dart"

isDebug=0

while getopts "d" opt; do
  case $opt in
    d)
      isDebug=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [ $isDebug -eq 1 ]; then
  TYPE="ServerType.uat"
else
  TYPE="ServerType.release"
fi

# 生成Class dart檔案
cat << EOF > "$file_path/$file_name"
import 'package:funday_media/service/serverType.dart';

$flutterVersionInfoWithChangeLine

// App Version: $VERSION
// Git Hash: $gitSortHash

class AppInfo {
  static ServerType serverType = $TYPE;

  static String getAppInfo() {
    return "$VERSION\\n$gitSortHash";
  }

  static String getFlutterInfo() {
    return $flutterVersionInfo;
  }
}
EOF

# 設定檔案路徑和檔案名稱
file_path="android"
file_name="app_info.properties"

if [ $isDebug -eq 1 ]; then
  isUAT=true
else
  isUAT=false
fi

# 生成Class dart檔案
cat << EOF > "$file_path/$file_name"
isUAT = $isUAT
EOF

sh "readAppInfo.sh"
