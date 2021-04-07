import 'package:either_option/either_option.dart';
import 'package:flutter_catalog/data/api/post_review_product_api.dart';
import 'package:flutter_catalog/data/dto/error_response.dart';

class PostReviewProductRepository {
  PostReviewProductApi reviewProductApi = PostReviewProductApi();

  Future<Either<ErrorResponse, bool>> postReviewProduct({int id, int rate, String text}) async {
    final response = await reviewProductApi.postReviewProduct(id: id, rate: rate, text: text);

    return response;
  }
}
