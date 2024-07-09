import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/sections%20and%20details/model/get_secdtion_homescreen_model.dart';
import 'package:zoco/app/modules/sections%20and%20details/view%20model/section_provider.dart';
import 'package:zoco/app/modules/sections%20and%20details/widgets/offer_related_product_widget.dart';
import 'package:zoco/app/utils/app_images.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../model/get_section_product_model.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  final String? categoryid;
  final String isFromDealsScreen;
  final String? subCategoryId;
  final String? categoryname;
  final String isBrand;
  const ProductListByCategoryScreen({
    super.key,
    this.isBrand = 'false',
    this.categoryid,
    this.subCategoryId,
    this.categoryname,
    this.isFromDealsScreen = "false",
  });

  @override
  State<ProductListByCategoryScreen> createState() =>
      _ProductListByCategoryScreenState();
}

class _ProductListByCategoryScreenState
    extends State<ProductListByCategoryScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.isFromDealsScreen == "false") {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        context
            .read<SectionProvider>()
            .getProductProductsFn(catagoryId: widget.subCategoryId ?? "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: widget.categoryname ?? '',
          actions: [
            CommonInkwell(
                onTap: () {
                  widget.isBrand == 'true'
                      ? context.pushNamed(AppRouter.productSearchScreen,
                          queryParameters: {
                              'categoryid': widget.categoryid,
                              'brandId': widget.subCategoryId,
                            })
                      : context.pushNamed(AppRouter.productSearchScreen,
                          queryParameters: {
                              'categoryid': widget.categoryid,
                              'subCategoryId': widget.subCategoryId,
                            });
                  FocusScope.of(context).unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ImageIcon(AssetImage(AppImages.searchIcon)),
                )),
            const SizeBoxV(15),
            CommonInkwell(
              onTap: () {
                context.pushNamed(AppRouter.filterScreen, queryParameters: {
                  'subCategory': widget.subCategoryId ?? '',
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 15, bottom: 10),
                height: 35,
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: .8, color: AppConstants.appBorderColor),
                  borderRadius: BorderRadius.circular(10),
                )),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.filterImage,
                    ),
                    const SizeBoxV(5),
                    Text(
                      'Filter',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            fontFamily: 'Plus Jakarta Sans',
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: FadeInLeft(
          duration: const Duration(milliseconds: 700),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizeBoxH(10),
                  const SizeBoxH(15),
                  Selector<SectionProvider, int>(
                    selector: (p0, p1) => p1.getFashionProductStatus,
                    builder: (context, value, child) => value == 0
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio:
                                            Responsive.height * 0.090,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 2),
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return OfferRelatedProductWidget(
                                    width: Responsive.width * 45,
                                    oneProduct: Product(),
                                    index: index,
                                    isFrom: "Details",
                                    isFromWhichScreen: "You Might Also Like",
                                  );
                                }),
                          )
                        : Selector<SectionProvider, GetSectionProductModel>(
                            selector: (p0, provider) =>
                                provider.fashionProductModel,
                            builder: (context, value, child) => value
                                        .products?.isEmpty ??
                                    true
                                ? const NoProductWidget()
                                : GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio:
                                                Responsive.height * 0.090,
                                            crossAxisSpacing: 8,
                                            crossAxisCount: 2),
                                    itemCount: value.products?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final fashionProductData =
                                          value.products?[index];
                                      return CommonInkwell(
                                        onTap: () => context.pushNamed(
                                            AppRouter.productDetailsViewScreen,
                                            queryParameters: {
                                              'productLink':
                                                  fashionProductData?.link ??
                                                      '',
                                              'fromWhichList':
                                                  "ProductListByCatagory",
                                              'selectedListIndex':
                                                  index.toString()
                                            }),
                                        child: OfferRelatedProductWidget(
                                          width: Responsive.width * 45,
                                          oneProduct: fashionProductData,
                                          index: index,
                                          isFrom: "product",
                                          isFromWhichScreen: "catagory",
                                        ),
                                      );
                                    }),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
