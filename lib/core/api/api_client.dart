import 'package:dio/dio.dart';
import 'package:jolsetu/core/utils/constants.dart' as app_constants;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  late final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Dio get dio => _dio;

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: app_constants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: app_constants.accessTokenKey);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token expired, try to refresh
          final refreshed = await refreshToken();
          if (refreshed) {
            final token = await _storage.read(key: app_constants.accessTokenKey);
            error.requestOptions.headers['Authorization'] = 'Bearer $token';
            return handler.resolve(await _dio.fetch(error.requestOptions));
          } else {
            // Clear auth and redirect to login
            await _storage.delete(key: app_constants.accessTokenKey);
            await _storage.delete(key: app_constants.refreshTokenKey);
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<void> initialize() async {
    // Already initialized in constructor
  }

  Future<bool> refreshToken() async {
    final refreshToken = await _storage.read(key: app_constants.refreshTokenKey);
    if (refreshToken == null) return false;

    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      if (response.statusCode == 200) {
        final accessToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'];
        await _storage.write(key: app_constants.accessTokenKey, value: accessToken);
        await _storage.write(key: app_constants.refreshTokenKey, value: newRefreshToken);
        return true;
      }
    } catch (_) {
      // Ignore errors
    }
    return false;
  }

  Future<void> setTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: app_constants.accessTokenKey, value: accessToken);
    await _storage.write(key: app_constants.refreshTokenKey, value: refreshToken);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: app_constants.accessTokenKey);
    await _storage.delete(key: app_constants.refreshTokenKey);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: app_constants.accessTokenKey);
  }
}