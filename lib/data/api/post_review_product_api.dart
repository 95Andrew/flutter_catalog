import 'dart:convert';
import 'dart:io';

import 'package:either_option/either_option.dart';
import 'package:flutter_catalog/data/dto/error_response.dart';
import 'package:flutter_catalog/data/dto/post_review_product.dart';
import 'package:flutter_catalog/ui/shared/constants.dart';

import 'package:http/http.dart' as http;

class PostReviewProductApi {
  Future<Either<ErrorResponse, bool>> postReviewProduct({int id, int rate, String text}) async {
    final url = Uri.parse('$urlApi/api/reviews/$id');
    final body = PostReviewProductBody(rate: rate, text: text).toJson();
    final result =
        await http.post(url, body: jsonEncode(body), headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType});

    if (result.statusCode == HttpStatus.ok) {
      return Right(true);
    } else {
      return Left(ErrorResponse.fromJson(jsonDecode(result.body)));
    }
  }
}
