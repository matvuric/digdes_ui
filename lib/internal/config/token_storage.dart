import 'package:digdes_ui/domain/models/token_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _accessTokenKey = "accessToken";
  static const _refreshTokenKey = "refreshToken";

  static Future<TokenResponse?> getStoredToken() async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: _accessTokenKey);
    final refreshToken = await storage.read(key: _refreshTokenKey);

    return accessToken == null || refreshToken == null
        ? null
        : TokenResponse(accessToken: accessToken, refreshToken: refreshToken);
  }

  static Future setStoredToken(TokenResponse? token) async {
    const storage = FlutterSecureStorage();
    storage.delete(key: _accessTokenKey);
    storage.delete(key: _refreshTokenKey);

    if (token != null) {
      await storage.write(key: _accessTokenKey, value: token.accessToken);
      await storage.write(key: _refreshTokenKey, value: token.refreshToken);
    }
  }

  static Future<String?> getAccessToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: _accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: _refreshTokenKey);
  }
}
