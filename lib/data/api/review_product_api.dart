import 'dart:convert';
import 'dart:io';

import 'package:either_option/either_option.dart';
import 'package:flutter_catalog/data/dto/error_response.dart';
import 'package:flutter_catalog/data/dto/review_product.dart';
import 'package:flutter_catalog/ui/shared/constants.dart';

import 'package:http/http.dart' as http;

class ReviewProductApi {
  Future<Either<ErrorResponse, List<ReviewProduct>>> getReviewProductsList({int id}) async {
    final url = Uri.parse('$urlApi/api/reviews/$id');
    final result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      final list = jsonDecode(result.body) as List;
      return Right(list.map((entity) => ReviewProduct.fromJson(entity)).toList());
    } else {
      return Left(ErrorResponse.fromJson(jsonDecode(result.body)));
    }
  }
}
