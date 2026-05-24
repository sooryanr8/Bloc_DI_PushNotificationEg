import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final storage = const FlutterSecureStorage();

  Future<void> save({required String access, required String refresh}) async {
    await storage.write(key: "access", value: access);

    await storage.write(key: "refresh", value: refresh);
  }

  Future<String?> getAccess() {
    return storage.read(key: "access");
  }

  Future<String?> getRefresh() {
    return storage.read(key: "refresh");
  }

  Future<void> clear() {
    return storage.deleteAll();
  }
}
