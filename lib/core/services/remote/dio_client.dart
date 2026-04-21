import 'package:dio/dio.dart';
import 'package:taskora/features/auth/data/datasources/auth_local_datasource.dart';

class DioClient {
  late final Dio _dio;
  final AuthLocalDataSource _localDataSource;

  static const String _baseUrl = 'https://api.mohammedzomlot.dev';

  DioClient(this._localDataSource) {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: const {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _localDataSource.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) => handler.next(error),
      ),
    );
  }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<dynamic>> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<dynamic>> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<dynamic>> delete(String path, {dynamic data}) async {
    try {
      return await _dio.delete(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    final response = e.response;
    if (response != null) {
      final body = response.data;
      if (body is Map) {
        final msg = body['message'] ?? body['error'] ?? 'حدث خطأ في الخادم.';
        return Exception(msg.toString());
      }
      return Exception('خطأ في الخادم: ${response.statusCode}');
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Exception('انتهت مهلة الاتصال. يرجى التحقق من اتصالك بالإنترنت.');
      case DioExceptionType.connectionError:
        return Exception('لا يوجد اتصال بالإنترنت.');
      default:
        return Exception(e.message ?? 'حدث خطأ غير متوقع.');
    }
  }
}
