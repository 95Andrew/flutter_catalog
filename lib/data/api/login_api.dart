import 'dart:convert';
import 'dart:io';
import 'package:flutter_catalog/data/dto/error_response.dart';
import 'package:flutter_catalog/data/dto/register_and_login.dart';
import 'package:flutter_catalog/ui/shared/constants.dart';
import 'package:http/http.dart' as http;

import 'package:either_option/either_option.dart';

class LoginApi{
  Future<Either<ErrorResponse, LoginResponse>> login({String username, String password}) async {
    final url = Uri.parse('$urlApi/api/login/');
    final body = RegisterAndLogin(username: username, password: password).toJson();
    final result =
        await http.post(url, body: jsonEncode(body), headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType});
    if (result.statusCode == HttpStatus.ok) {
      return Right(LoginResponse.fromJson(jsonDecode(result.body)));
    } else {
      return Left(ErrorResponse.fromJson(jsonDecode(result.body)));
    }
  }
}