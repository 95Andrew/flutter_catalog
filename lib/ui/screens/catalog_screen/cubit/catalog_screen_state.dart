part of 'catalog_screen_cubit.dart';

@immutable
abstract class CatalogScreenState {}

class CatalogScreenInitial extends CatalogScreenState {}

class CatalogScreenLoading extends CatalogScreenState {}

class CatalogScreenError extends CatalogScreenState {
  final String message;

  CatalogScreenError({this.message});
}

class CatalogScreenSuccess extends CatalogScreenState {
  final List<Product> listProduct;

  CatalogScreenSuccess({this.listProduct});
}
