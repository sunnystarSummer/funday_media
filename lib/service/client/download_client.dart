import 'package:dio/dio.dart';

final class DownloadClient {
  Future<void> downloadFile({
    required String url,
    required String savePath,
    void Function(int, int)? onReceiveProgress,
  }) async {
    final dio = Dio();
    //final url = "https://example.com/file.pdf";

    // final dir = await getApplicationDocumentsDirectory();
    // final savePath = "${dir.path}/file.pdf";

    await dio.download(url, savePath, onReceiveProgress: onReceiveProgress);
  }
}
