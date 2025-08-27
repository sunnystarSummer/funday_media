import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MediaCacheRepository {

  //JSON文字寫入檔案，並儲存於暫存資料夾
  void saveJson(String fileName, Map<String, dynamic> data) => _JsonCacheManager().saveJson(fileName, data);
}

class _MediaCacheManager {
  Future<File> saveTempFile(String fileName, List<int> bytes) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    return await file.writeAsBytes(bytes, flush: true);
  }

  Future<File?> getTempFile(String fileName) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    return await file.exists() ? file : null;
  }

  Future<void> clearCache() async {
    final dir = await getTemporaryDirectory();
    if (await dir.exists()) {
      await dir.delete(recursive: true);
      await dir.create(); // 保留空資料夾
    }
  }
}

class _JsonCacheManager {
  /// 儲存 JSON 文字到暫存檔案
  Future<File> saveJson(String fileName, Map<String, dynamic> data) async {
    final dir = await getTemporaryDirectory(); // 取得暫存資料夾
    final file = File('${dir.path}/$fileName.json');

    // 轉換成 JSON 文字並寫入檔案
    final jsonString = jsonEncode(data);
    return await file.writeAsString(jsonString, flush: true);
  }

  /// 讀取 JSON 檔案並轉換回 Map
  Future<Map<String, dynamic>?> readJson(String fileName) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName.json');

    if (await file.exists()) {
      final contents = await file.readAsString();
      return jsonDecode(contents);
    }
    return null;
  }

  /// 清除指定 JSON 檔案
  Future<void> deleteJson(String fileName) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName.json');

    if (await file.exists()) {
      await file.delete();
    }
  }
}

