import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../../app_info.dart';
import '../api/travel_api.dart';
import '../model/base_response.dart';

enum SupportLanguage {
  tw('zh-tw', '正體中文'),
  cn('zh-cn', '簡體中文'),
  en('en', '英文'),
  ja('ja', '日文'),
  ko('ko', '韓文');

  final String code;
  final String name;

  const SupportLanguage(this.code, this.name);
}

final class TravelClient {
  TravelClient({String? languageCode}) {
    _languageCode = languageCode ?? SupportLanguage.tw.code;
  }

  final logger = Logger();
  late String _languageCode;
  String get languageCode => _languageCode;

  AbsTravelRestClient travelClient({required String url}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Accept-Language': languageCode,
        },
      ),
    );

    return AbsTravelRestClient(dio);
  }

  FutureOr<T?> fetchDataByTravelClient<T extends AbsBaseResponse>({
    SupportLanguage? language,
    required Future<T> Function(
      String url,
      String languageCode,
      AbsTravelRestClient client,
    )
    api,
    required ValueChanged<T> success,
    required void Function(int?, String?) error,
  }) async {
    return _fetchData(
      requestByApi: () async {
        final url = '${AppInfo.serverType.travelUrl}/';

        final client = travelClient(url: url);
        return await api(url, _languageCode, client);
      },
      success: success,
      error: error,
    );
  }

  FutureOr<T?> _fetchData<T extends AbsBaseResponse>({
    required Future<T> Function() requestByApi,
    required ValueChanged<T> success,
    required void Function(int?, String?) error,
  }) async {
    T? result;

    try {
      result = await requestByApi();
      success(result);
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.statusMessage;

        switch (statusCode) {
          case 204:
            error(statusCode, 'No Content');
            break;
          case 403:
            error(statusCode, 'Forbidden');
            break;
          case 404:
            error(statusCode, 'Not Found');
            break;
          case 500:
            error(statusCode, 'System Busy');
            break;
          default:
            error(statusCode, '連線錯誤($statusCode): $message');
            break;
        }
      } else {
        final message = e.message;
        error(-1, message);
      }
    } on Exception {
      error(-1, '無法連線伺服器，請稍候再試');
    }

    return result;
  }
}
