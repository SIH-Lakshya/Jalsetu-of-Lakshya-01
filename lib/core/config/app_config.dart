/// Central place to store API keys and external service credentials.
/// Fill the values here as the project integrates with real services.
/// Firebase configuration is managed by FlutterFire CLI in firebase_options.dart
class AppConfig {
  AppConfig._();

  // Base API
  static const String apiBaseUrl = 'https://api.jalsetu.example.com/v1';

  // Map / geospatial services
  static const String mapApiKey = 'Yb4MZZ2qBvldmWOD_H-YmSTvJJ4VvmLUUYUIW15GPz4';

  // Other third-party APIs
  static const String weatherApiKey = '0d1db278bbef5a98e1e0232ca99329e3';
  static const String authClientId = 'PASTE_CLIENT_ID';
  static const String authClientSecret = 'PASTE_CLIENT_SECRET';
}
