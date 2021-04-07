import 'package:either_option/either_option.dart';
import 'package:flutter_catalog/data/api/product.dart';
import 'package:flutter_catalog/data/api/product_api.dart';
import 'package:flutter_catalog/data/dto/error_response.dart';

class ProductRepository {
  final ProductApi _productApi = ProductApi();
  Future<Either<ErrorResponse, List<Product>>> getProductsList() async {
    return await _productApi.getProductsList();
  }
}
