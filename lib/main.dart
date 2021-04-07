import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/ui/screens/catalog_screen/cubit/catalog_screen_cubit.dart';
import 'package:flutter_catalog/ui/screens/detail_catalog_screen/cubit/detail_catalog_screen_cubit.dart';
import 'package:flutter_catalog/ui/screens/login_screen/cubit/login_screen_cubit.dart';
import 'package:flutter_catalog/ui/screens/register_screen/cubit/register_screen_cubit.dart';
import 'package:flutter_catalog/ui/util/root.dart';
import 'package:flutter_catalog/ui/util/secure_storage_service.dart';
import 'package:get/get.dart';

import 'data/repository/login_repository.dart';
import 'data/repository/post_review_product_repository.dart';
import 'data/repository/product_repository.dart';
import 'data/repository/register_repository.dart';
import 'data/repository/review_product_repository.dart';

void main() {
  runApp(initApp());
}

Widget initApp() {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => RegisterScreenCubit(RegisterRepository())),
      BlocProvider(create: (context) => LoginScreenCubit(LoginRepository())),
      BlocProvider(create: (context) => CatalogScreenCubit(ProductRepository())),
      BlocProvider(
          create: (context) =>
              DetailCatalogScreenCubit(ReviewProducRepository(), PostReviewProductRepository(), SecureStorageService())),
    ],
    child: MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Root(),
    );
  }
}
