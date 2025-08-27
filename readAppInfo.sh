#!/bin/bash

# 讀取 app_info.dart 中的 serverType
serverType=$(grep -m1 'static ServerType' lib/app_info.dart | awk -F'=' '{print $2}' | sed 's/ServerType\.//g' | sed 's/;//g' | tr -d '[:space:]')

# 檢查是否成功提取到 serverType，並設置 isUAT
if [ "$serverType" == "debug" ]; then
  echo "ServerType is debug"
  isUAT=true
elif [ "$serverType" == "release" ]; then
  echo "ServerType is release"
  isUAT=false
else
  echo "Unknown or missing ServerType in lib/app_info.dart"
  exit 1  # Exit if serverType is unknown or not found
fi

echo "app_info.properties has been generated with isUAT=$isUAT."
