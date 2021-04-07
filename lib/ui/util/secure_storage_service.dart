import 'package:flutter_catalog/ui/util/secure_storage_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveToken(String value) async {
    await _storage.write(key: SecuredStorage.token, value: value);
  }

  Future<String> readToken() async {
    return await _storage.read(key: SecuredStorage.token);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: SecuredStorage.token);
  }
}
