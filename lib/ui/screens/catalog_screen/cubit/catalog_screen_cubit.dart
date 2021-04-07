import 'package:bloc/bloc.dart';
import 'package:flutter_catalog/data/api/product.dart';
import 'package:flutter_catalog/data/repository/product_repository.dart';
import 'package:meta/meta.dart';

part 'catalog_screen_state.dart';

class CatalogScreenCubit extends Cubit<CatalogScreenState> {
  ProductRepository productRepository;
  CatalogScreenCubit(this.productRepository) : super(CatalogScreenInitial());

  Future<void> getProductsList() async {
    emit(CatalogScreenLoading());
    final result = await productRepository.getProductsList();
    result.fold((error) {
      emit(CatalogScreenError(message: error.message));
    }, (response) {
      emit(CatalogScreenSuccess(listProduct: response));
    });
  }
}
