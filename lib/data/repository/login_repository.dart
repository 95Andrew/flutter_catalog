import 'package:either_option/either_option.dart';
import 'package:flutter_catalog/data/api/login_api.dart';
import 'package:flutter_catalog/data/dto/error_response.dart';
import 'package:flutter_catalog/data/dto/register_and_login.dart';
import 'package:flutter_catalog/ui/util/secure_storage_service.dart';

class LoginRepository {
  SecureStorageService _storage = SecureStorageService();
  LoginApi _api = LoginApi();

  Future<Either<ErrorResponse, LoginResponse>> login({String username, String password}) async {
    final result = await _api.login(username: username, password: password);
    result.fold((_) {}, (response) {
      _storage.saveToken(response.token);
    });
    return result;
  }
}
