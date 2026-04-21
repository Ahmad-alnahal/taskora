import 'package:taskora/core/services/remote/dio_client.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);

  final DioClient _dio;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _dio.post(
      '/User/login',
      data: {'email': email, 'password': password},
    );
    final body = response.data as Map<String, dynamic>;
    final token = body['token'] as String?;
    if (token == null) throw Exception('استجابة غير صالحة من الخادم.');

    // WatchCost may come back as int or double
    final rawCost = body['WatchCost'] ?? body['watchCost'] ?? body['hourly_rate'];
    final watchCost = (rawCost as num?)?.toDouble() ?? 0.0;

    return {'token': token, 'watchCost': watchCost};
  }

  Future<void> signup(
    String name,
    String email,
    String password,
    double hourlyRate,
  ) async {
    await _dio.post(
      '/user/signup',
      data: {
        'email': email,
        'password': password,
        'username': name.toLowerCase().replaceAll(' ', ''),
        'name': name,
        'WatchCost': hourlyRate,
      },
    );
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await _dio.post(
      '/user/forgotPassword',
      data: {'email': email},
    );
    final body = response.data as Map<String, dynamic>;
    return {
      'message': body['message']?.toString() ??
          'تم إرسال رمز التحقق إلى بريدك الإلكتروني.',
      'code': body['code']?.toString() ?? '',
    };
  }

  Future<void> verifyResetCode(String email, String code) async {
    await _dio.post(
      '/user/checkCodeController',
      data: {'code': int.tryParse(code) ?? code},
    );
  }

  Future<void> resetPassword(String email, String pass, String confirm) async {
    if (pass != confirm) throw Exception('كلمتا المرور غير متطابقتين.');
    await _dio.post(
      '/user/resetPassword',
      data: {'email': email, 'newPassword': pass},
    );
  }
}
