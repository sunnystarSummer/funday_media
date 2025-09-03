import 'package:dio/dio.dart';

final class DownloadClient {
  Future<void> downloadFile({
    required String url,
    required String savePath,
    void Function(int, int)? onReceiveProgress,
  }) async {
    final dio = Dio();
    await dio.download(url, savePath, onReceiveProgress: onReceiveProgress);
  }
}
