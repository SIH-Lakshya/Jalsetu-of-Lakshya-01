import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import '../utils/constants.dart';

part 'auth_state.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  Future<User?> build() async {
    final storage = const FlutterSecureStorage();
    final token = await storage.read(key: accessTokenKey);
    if (token == null) return null;

    // Try to get current user from API
    // This will be handled by the auth repository
    return null;
  }

  Future<void> login(User user) async {
    state = AsyncValue.data(user);
  }

  Future<void> logout() async {
    state = const AsyncValue.data(null);
  }
}