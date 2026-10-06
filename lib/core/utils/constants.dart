import 'package:jolsetu/core/config/app_config.dart';

const String apiBaseUrl = AppConfig.apiBaseUrl;

const String accessTokenKey = 'access_token';
const String refreshTokenKey = 'refresh_token';
const String userIdKey = 'user_id';
const String userRoleKey = 'user_role';

const int maxSyncRetries = 3;
const Duration syncInterval = Duration(minutes: 5);
const double minGpsAccuracy = 10.0; // meters

const String mapTileUrl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
const String mapAttribution = '© OpenStreetMap contributors';