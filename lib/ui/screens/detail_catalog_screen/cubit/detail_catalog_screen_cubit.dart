import 'package:bloc/bloc.dart';
import 'package:flutter_catalog/data/dto/review_product.dart';
import 'package:flutter_catalog/data/repository/post_review_product_repository.dart';
import 'package:flutter_catalog/data/repository/review_product_repository.dart';
import 'package:flutter_catalog/ui/screens/home_screen/home_screen.dart';
import 'package:flutter_catalog/ui/util/secure_storage_service.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'detail_catalog_screen_state.dart';

class DetailCatalogScreenCubit extends Cubit<DetailCatalogScreenState> {
  ReviewProducRepository reviewProducRepository;
  PostReviewProductRepository postReviewProductRepository;
  SecureStorageService secureStorage;

  double rating = 0.0;
  bool tokenVerification = true;

  DetailCatalogScreenCubit(this.reviewProducRepository, this.postReviewProductRepository, this.secureStorage)
      : super(DetailCatalogScreenInitial());

  Future<void> postReviewProduct({int id, String text}) async {
    final result = await postReviewProductRepository.postReviewProduct(id: id, rate: rating.round(), text: text);
    result.fold((error) {
      emit(DetailCatalogScreenError(message: error.message));
    }, (resul) {
      emit(DetailCatalogScreenSuccessPost());
    });
  }

  Future<void> logout() async {
    await secureStorage.clearToken();
    Get.offAll(() => HomeScreen());
  }

  Future<void> checkTokenAndGetReviewProductsList({int id}) async {
    emit(DetailCatalogScreenLoading());
    var token = await secureStorage.readToken();
    if (token != null) {
      tokenVerification = true;
    } else {
      tokenVerification = false;
    }
    final result = await reviewProducRepository.getReviewProductsList(id: id);
    result.fold((error) {
      emit(DetailCatalogScreenError(message: error.message));
    }, (result) {
      emit(DetailCatalogScreenSuccess(listReviewProduct: result));
    });
  }
}
