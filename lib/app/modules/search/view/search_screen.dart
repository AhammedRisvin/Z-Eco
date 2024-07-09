import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/home/view_model/home_provider.dart';
import 'package:zoco/app/modules/sections%20and%20details/widgets/offer_related_product_widget.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../utils/enums.dart';
import '../../home/widgets/product_search_and_cart_widget.dart';
import '../view model/search_provider.dart';
import '../widgets/search_empty_screen.dart';

class ProductSearchScreen extends StatelessWidget {
  final String? categoryid;
  final String? subCategoryId;
  final String? brandId;

  ProductSearchScreen({
    super.key,
    this.categoryid,
    this.subCategoryId,
    this.brandId,
  });

  final debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        context.read<HomeProvider>().searchTextEditingController.clear();
        context.read<SearchProvider>().searchDataList.clear();
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          leading: const SizedBox.shrink(),
          toolbarHeight: 80,
          flexibleSpace: Column(
            children: [
              SizeBoxH(Responsive.height * 6),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<HomeProvider>()
                            .searchTextEditingController
                            .clear();
                        context.read<SearchProvider>().searchDataList.clear();
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 22,
                      )),
                  ProductSearchAndCartWidget(
                    onChange: (query) {
                      debouncer.run(
                        () {
                          context.read<SearchProvider>().getSerchProductFnc(
                              categoryid: categoryid ?? '',
                              subCategoryid: subCategoryId ?? '',
                              brandId: brandId ?? '',
                              query: query);
                        },
                      );
                    },
                    padding: 5,
                    width: Responsive.width * 69,
                  ),
                ],
              ),
            ],
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(5),
            child: Divider(
              height: 8,
            ),
          ),
        ),
        body: SizedBox(
          height: Responsive.height * 100,
          width: Responsive.width * 100,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<SearchProvider>(builder: (context, obj, _) {
                return Column(
                  children: [
                    obj.serchStatus == SerchStatus.loading
                        ? const ProductShimmer()
                        : context
                                    .read<HomeProvider>()
                                    .searchTextEditingController
                                    .text
                                    .isNotEmpty &&
                                obj.searchDataList.isEmpty
                            ? const SearchEmptyScreen()
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio:
                                            Responsive.height * 0.090,
                                        crossAxisSpacing: 8,
                                        // mainAxisSpacing: 8,
                                        crossAxisCount: 2),
                                itemCount: obj.searchDataList.length,
                                itemBuilder: (context, index) {
                                  final product = obj.searchDataList[index];
                                  return InkWell(
                                    onTap: () {
                                      context.pushNamed(
                                          AppRouter.productDetailsViewScreen,
                                          queryParameters: {
                                            'productLink': product.link ?? '',
                                            'fromWhichList': "Search",
                                            'selectedListIndex':
                                                index.toString()
                                          });
                                    },
                                    child: OfferRelatedProductWidget(
                                      index: index,
                                      oneProduct: product,
                                      width: Responsive.width * 100,
                                      isFrom: '',
                                      offer: product.offers,
                                      isFromWhichScreen: '',
                                    ),
                                  );
                                },
                              ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: Responsive.height * 0.090,
        crossAxisSpacing: 8,
        crossAxisCount: 2,
      ),
      itemCount: 10, // Assuming a fixed count for demo
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ));
      },
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
