#!/bin/bash

# 設定檔案路徑和檔案名稱
file_path="build/web"
file_name="vercel.dart"

# 生成Class dart檔案
cat << EOF > "$file_path/$file_name"
{
  "version": 2,
  "builds": [
    {
      "src": "build/web/**",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    { "src": "/(.*)", "dest": "/index.html" }
  ]
}
EOF

flutter/bin/flutter build web --release
