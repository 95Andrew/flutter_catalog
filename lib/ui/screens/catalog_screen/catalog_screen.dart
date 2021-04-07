import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/data/repository/product_repository.dart';
import 'package:flutter_catalog/ui/screens/detail_catalog_screen/detail_catalog_screen.dart';
import 'package:flutter_catalog/ui/shared/gradient_background.dart';
import 'package:flutter_catalog/ui/util/ui_helpers.dart';
import 'package:get/get.dart';

import 'cubit/catalog_screen_cubit.dart';

class CatalogScreen extends StatelessWidget {
  final CatalogScreenCubit cubit = CatalogScreenCubit(ProductRepository());
  @override
  Widget build(BuildContext context) {
    cubit.getProductsList();
    return Scaffold(
      body: BlocConsumer<CatalogScreenCubit, CatalogScreenState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is CatalogScreenLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is CatalogScreenSuccess) {
              var listProduct = state.listProduct;
              return GradientBackground(
                child: ListView.builder(
                  itemCount: listProduct.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () =>
                            Get.to(() => DetailCatalogScreen(id: listProduct[index].id)),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${listProduct[index].id.toString()}'),
                              Text('${listProduct[index].title}'),
                              Text('${listProduct[index].text}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          },
          listener: (context, state) {
            if (state is CatalogScreenError) {
              composeRedMessage(state.message).show(context);
            }
          }),
    );
  }
}
