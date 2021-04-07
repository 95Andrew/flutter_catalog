part of 'detail_catalog_screen_cubit.dart';

@immutable
abstract class DetailCatalogScreenState {}

class DetailCatalogScreenInitial extends DetailCatalogScreenState {}

class DetailCatalogScreenLoading extends DetailCatalogScreenState {}

class DetailCatalogScreenError extends DetailCatalogScreenState {
  final String message;

  DetailCatalogScreenError({this.message});
}

class DetailCatalogScreenSuccess extends DetailCatalogScreenState {
  final List<ReviewProduct> listReviewProduct;

  DetailCatalogScreenSuccess({this.listReviewProduct});
}

class DetailCatalogScreenSuccessPost extends DetailCatalogScreenState {}
