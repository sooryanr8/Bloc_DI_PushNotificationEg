import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:test1/core/auth/token_storage.dart';

import '../../features/auth/domain/usecases/refresh_token_usecase.dart';

class SessionManager {
  final TokenStorage storage;
  final RefreshTokenUseCase refresh;

  SessionManager(this.storage, this.refresh);

  Future<String?> getValidToken() async {
    var access = await storage.getAccess();

    var refreshToken = await storage.getRefresh();

    print("ACCESS -> $access");
    print("REFRESH -> $refreshToken");

    /// No session
    if (access == null) {
      print("NO ACCESS TOKEN");

      return null;
    }

    /// Access valid
    if (!JwtDecoder.isExpired(access)) {
      print("TOKEN STILL VALID");

      return access;
    }

    print("TOKEN EXPIRED");

    /// Cannot refresh
    if (refreshToken == null) {
      print("NO REFRESH TOKEN");

      await storage.clear();

      return null;
    }

    try {
      final result = await refresh(refreshToken);

      await storage.save(
        access: result.accessToken,

        refresh: result.refreshToken,
      );

      print("REFRESH SUCCESS");

      return result.accessToken;
    } catch (e) {
      print("REFRESH FAILED -> $e");

      await storage.clear();

      return null;
    }
  }

  Future<void> logout() async {
    try {
      final refreshToken = await storage.getRefresh();

      if (refreshToken != null) {
        await refresh.call(refreshToken);
      }
    } catch (_) {}

    await storage.clear();
  }
}
