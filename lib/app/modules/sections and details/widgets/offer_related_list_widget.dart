import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import '../model/get_secdtion_homescreen_model.dart';
import 'offer_related_product_widget.dart';

class OfferRelatedProductListWidget extends StatelessWidget {
  final num? offer;
  final List<Product>? relatedProducts;
  final String? sectionName;
  const OfferRelatedProductListWidget({
    this.offer,
    this.relatedProducts,
    super.key,
    this.sectionName,
  });

  @override
  Widget build(BuildContext context) {
    return relatedProducts?.isNotEmpty ?? false
        ? SizedBox(
            // height: Responsive.height * 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidgets(
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w600,
                      ),
                  text: "Minimum $offer% off Bestsellers in $sectionName ",
                ),
                const SizeBoxH(12),
                SizedBox(
                  height: Responsive.height * 21,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var offerProduct = relatedProducts?[index];
                      return CommonInkwell(
                          onTap: () {
                            context.pushNamed(
                                AppRouter.productDetailsViewScreen,
                                queryParameters: {
                                  'productLink': offerProduct?.link ?? '',
                                });
                          },
                          child: OfferRelatedProductWidget(
                            offer: offer,
                            oneProduct: offerProduct,
                            width: Responsive.width * 45,
                            index: index,
                            isFrom: "Offer related",
                            isFromWhichScreen: "Every Section",
                          ));
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
