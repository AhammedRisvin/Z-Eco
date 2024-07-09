import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import '../view model/section_provider.dart';
import 'offer_related_product_widget.dart';

class ProductDetailsAlsoLikeProductsWidget extends StatelessWidget {
  final SectionProvider provider;
  const ProductDetailsAlsoLikeProductsWidget({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidgets(
            text: "You Might Also Like",
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizeBoxH(15),
          SizedBox(
            height: 220,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount:
                  provider.getProductDetailsModel.relatedProducts?.length ?? 0,
              itemBuilder: (context, index) {
                var relatedProductData =
                    provider.getProductDetailsModel.relatedProducts?[index];
                return CommonInkwell(
                  onTap: () => context.pushNamed(
                      AppRouter.productDetailsViewScreen,
                      queryParameters: {
                        'productLink': relatedProductData?.link ?? '',
                      }),
                  child: OfferRelatedProductWidget(
                    offer: provider.getProductDetailsModel.product?.offers ?? 0,
                    width: Responsive.width * 44,
                    oneProduct: relatedProductData,
                    index: index,
                    isFrom: "Details Recommended Products",
                    isFromWhichScreen: "You Might Also Like",
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizeBoxV(15),
            ),
          ),
        ],
      ),
    );
  }
}
