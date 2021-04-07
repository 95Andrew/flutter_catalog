import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/data/dto/review_product.dart';
import 'package:flutter_catalog/data/repository/post_review_product_repository.dart';
import 'package:flutter_catalog/data/repository/review_product_repository.dart';
import 'package:flutter_catalog/ui/screens/catalog_screen/catalog_screen.dart';
import 'package:flutter_catalog/ui/screens/detail_catalog_screen/cubit/detail_catalog_screen_cubit.dart';
import 'package:flutter_catalog/ui/shared/const_strings.dart';
import 'package:flutter_catalog/ui/shared/gradient_background.dart';
import 'package:flutter_catalog/ui/util/secure_storage_service.dart';
import 'package:flutter_catalog/ui/util/ui_helpers.dart';
import 'package:flutter_catalog/ui/widgets/custom_button.dart';
import 'package:flutter_catalog/ui/widgets/custom_rating_bar.dart';

import 'package:get/get.dart';

class DetailCatalogScreen extends StatelessWidget {
  final int id;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController orderCommentController = TextEditingController();
  final DetailCatalogScreenCubit cubit =
      DetailCatalogScreenCubit(ReviewProducRepository(), PostReviewProductRepository(), SecureStorageService());

  DetailCatalogScreen({Key key, this.id});

  @override
  Widget build(BuildContext context) {
    cubit.checkTokenAndGetReviewProductsList(id: id);

    return Scaffold(
        body: GradientBackground(
      child: BlocConsumer<DetailCatalogScreenCubit, DetailCatalogScreenState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is DetailCatalogScreenInitial) {
            return Container();
          }
          if (state is DetailCatalogScreenLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is DetailCatalogScreenSuccess) {
            var listReviewProduct = state.listReviewProduct;
            return buildForm(listReviewProduct);
          }
          return Container();
        },
        listener: (context, state) {
          if (state is DetailCatalogScreenError) {
            composeRedMessage(state.message).show(context);
          }
          if (state is DetailCatalogScreenSuccessPost) {
            Get.to(() => CatalogScreen());
          }
        },
      ),
    ));
  }

  Widget buildForm(List<ReviewProduct> listReviewProduct) {
    return CustomScrollView(
      slivers: [
        buildSliverAppBar(),
        buildSliverListReviewProduct(listReviewProduct),
        cubit.tokenVerification ? buildSliverListTokenVerificationTrue() : buildSliverListbuildSliverListTokenVerificationFalse(),
      ],
    );
  }

  SliverList buildSliverListbuildSliverListTokenVerificationFalse() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(),
        ],
      ),
    );
  }

  SliverList buildSliverListTokenVerificationTrue() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          verticalSpacer(verticalSpaceMedium),
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomRatingBar(
                    isIgnorePointer: false,
                    rating: cubit.rating,
                    onRatingUpdate: (val) {
                      cubit.rating = val;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: orderComment),
                    controller: orderCommentController,
                    validator: (value) => value.isEmpty ? orderComment : null,
                  ),
                  verticalSpacer(verticalSpaceMedium),
                  CustomButton(
                      text: submitComment,
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          // cubit.postReviewProduct(id: id, text: orderCommentController.text);
                          cubit.emit(DetailCatalogScreenSuccessPost());
                        }
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverList buildSliverListReviewProduct(List<ReviewProduct> listReviewProduct) {
    return SliverList(
        delegate: SliverChildListDelegate(listReviewProduct
            .map((product) => Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(product.createdBy.username),
                      Text(product.text),
                      CustomRatingBar(
                        rating: product.rate.toDouble(),
                      ),
                    ],
                  ),
                ))
            .toList()));
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      title: Text(cubit.tokenVerification ? logout : home.toUpperCase()),
      centerTitle: true,
      backgroundColor: Colors.purple,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => cubit.logout(),
        )
      ],
    );
  }
}
