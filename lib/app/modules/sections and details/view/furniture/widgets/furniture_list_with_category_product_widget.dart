import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/common_widgets.dart';
import '../../../../../helpers/router.dart';
import '../../../../../helpers/sized_box.dart';
import '../../../../../theme/theme_provider.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/extentions.dart';
import '../../../model/get_secdtion_homescreen_model.dart';

class FurnitureListWithCategoryProductWidget extends StatelessWidget {
  final num? offer;
  final List<Product>? relatedProducts;
  final String? sectionName;
  const FurnitureListWithCategoryProductWidget({
    this.offer,
    this.relatedProducts,
    super.key,
    this.sectionName,
  });

  @override
  Widget build(BuildContext context) {
    return relatedProducts?.isNotEmpty ?? false
        ? SizedBox(
            height: Responsive.height * 28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidgets(
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w600,
                      ),
                  text: "Minimum $offer% off Bestsellers in $sectionName ",
                ),
                const SizeBoxH(8),
                SizedBox(
                  height: Responsive.height * 24,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var oneProduct = relatedProducts?[index];
                      return CommonInkwell(
                        onTap: () => context.pushNamed(
                            AppRouter.productDetailsViewScreen,
                            queryParameters: {
                              'productLink': oneProduct?.link ?? '',
                            }),
                        child: Container(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.transparent,
                            )
                          ]),
                          width: Responsive.width * 45,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: Responsive.width * 45,
                                    height: 112,
                                    decoration: ShapeDecoration(
                                      color: context
                                                  .watch<ThemeProvider>()
                                                  .isDarkMode ==
                                              true
                                          ? AppConstants.containerColor
                                          : Colors.grey.withOpacity(0.27),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0, right: 4, top: 5),
                                      child: CachedImageWidget(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6)),
                                          imageUrl: oneProduct?.images?.first ??
                                              "https://blogger.googleusercontent.com/img/a/AVvXsEhUeiRmvP33IgmhAffdiFwHOqweHsFyOW12IoM2sXmU9ZxgzD1hra9-awcHXaF8aL5UZzg6Aa_R_JIde1_ZI-liUkc1UzD2fQYWvUzF7tPX4oyyNxkyGd0jM5_cG_QbA328a_eYs2PN9BCpQRXVEBVrG83lX-I6VrOTvkRfx666VJap6F4AbZakPJioul2y=w640-h192"),
                                    ),
                                  ),
                                  Container(
                                    width: Responsive.width * 45,
                                    // height: 95,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: context
                                                  .watch<ThemeProvider>()
                                                  .isDarkMode ==
                                              true
                                          ? AppConstants.containerColor
                                          : Colors.grey.withOpacity(0.09),
                                      border: Border(
                                          bottom: BorderSide(
                                        color: Colors.black.withOpacity(.028),
                                      )),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextWidgets(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0,
                                                      color: Colors.red),
                                              text: "Limited time deal"),
                                          const SizeBoxH(5),
                                          CustomTextWidgets(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                            text: oneProduct?.productName ?? '',
                                          ),
                                          const SizeBoxH(1),
                                          CustomTextWidgets(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                            text: oneProduct?.description ?? '',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              oneProduct?.offers != 0
                                  ? Positioned(
                                      // left: 8,
                                      top: 5,
                                      child: Container(
                                        width: 40,
                                        height: 24,
                                        decoration: const ShapeDecoration(
                                          color: Color(0xFFDB3022),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight: Radius.circular(30),
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: CustomTextWidgets(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                              text: "${oneProduct?.offers}%"),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (index, context) {
                      return const SizeBoxV(5);
                    },
                    itemCount: relatedProducts?.length ?? 0,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
