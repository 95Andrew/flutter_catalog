import 'package:either_option/either_option.dart';
import 'package:flutter_catalog/data/api/register_api.dart';
import 'package:flutter_catalog/data/dto/error_response.dart';
import 'package:flutter_catalog/data/dto/register_and_login.dart';

class RegisterRepository {
  final RegisterApi _api = RegisterApi();

  Future<Either<ErrorResponse, LoginResponse>> register({String username, String password}) async {
    return await _api.register(username: username, password: password);
  }
}
