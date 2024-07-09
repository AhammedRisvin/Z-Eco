import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import '../../home/widgets/offer_tag_widget.dart';
import '../view model/section_provider.dart';
import 'dot_list_widget.dart';

class ProductDetailProductImageWidget extends StatelessWidget {
  final SectionProvider provider;
  const ProductDetailProductImageWidget({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            width: Responsive.width * 100,
            child: Stack(
              children: [
                SizedBox(
                  width: Responsive.width * 100,
                  height: Responsive.height * 32,
                  child: PageView.builder(
                    itemCount: provider
                            .getProductDetailsModel.product?.images?.length ??
                        0,
                    onPageChanged: (value) {
                      context.read<SectionProvider>().nextPage(value);
                    },
                    itemBuilder: (context, index) {
                      var image = provider
                          .getProductDetailsModel.product?.images?[index];
                      return CachedImageWidget(imageUrl: image ?? "");
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: provider.getProductDetailsModel.product?.offers == 0
                      ? const SizedBox.shrink()
                      : OfferTagWidget(
                          offer:
                              provider.getProductDetailsModel.product?.offers ??
                                  0,
                        ),
                ),
              ],
            ),
          ),
          const SizeBoxH(15),
          if ((provider.getProductDetailsModel.product?.images?.length ?? 0) >
              1) ...[
            DotListWidget(
              productDetailsImages:
                  provider.getProductDetailsModel.product?.images ?? [],
              isProductDetails: true,
            ),
          ],
          const SizeBoxH(15),
        ],
      ),
    );
  }
}
