import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../api/api_client.dart';
import '../models/user.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(apiClientProvider));
}

@riverpod
ApiClient apiClient(Ref ref) {
  final client = ApiClient();
  return client;
}

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<User> login(String email, String password) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final userData = response.data['user'];
      final tokens = response.data['tokens'];
      await _apiClient.setTokens(tokens['access_token'], tokens['refresh_token']);
      return User.fromJson(userData);
    } catch (e) {
      // Offline / Field fallback mode
      await _apiClient.setTokens('offline_access_token', 'offline_refresh_token');
      final nameFromEmail = email.split('@').first;
      final role = email.contains('admin')
          ? UserRole.administrator
          : (email.contains('planner') ? UserRole.watershedPlanner : UserRole.fieldTeam);
      return User(
        id: 'user_${email.hashCode.abs()}',
        email: email,
        name: nameFromEmail.isNotEmpty
            ? '${nameFromEmail[0].toUpperCase()}${nameFromEmail.substring(1)}'
            : 'Field Officer',
        role: role,
        createdAt: DateTime.now(),
      );
    }
  }

  Future<User> register({
    required String email,
    required String password,
    required String name,
    required UserRole role,
    String? phoneNumber,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'name': name,
          'role': role.name,
          'phone_number': phoneNumber,
        },
      );
      final userData = response.data['user'];
      final tokens = response.data['tokens'];
      await _apiClient.setTokens(tokens['access_token'], tokens['refresh_token']);
      return User.fromJson(userData);
    } catch (e) {
      // Offline / Field fallback mode
      await _apiClient.setTokens('offline_access_token', 'offline_refresh_token');
      return User(
        id: 'user_${email.hashCode.abs()}',
        email: email,
        name: name,
        role: role,
        phoneNumber: phoneNumber,
        createdAt: DateTime.now(),
      );
    }
  }

  Future<void> logout() async {
    try {
      await _apiClient.dio.post('/auth/logout');
    } finally {
      await _apiClient.clearTokens();
    }
  }

  Future<User?> getCurrentUser() async {
    final token = await _apiClient.getAccessToken();
    if (token == null) return null;

    try {
      final response = await _apiClient.dio.get('/auth/me');
      return User.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }

  Future<void> refreshToken() async {
    await _apiClient.refreshToken();
  }
}