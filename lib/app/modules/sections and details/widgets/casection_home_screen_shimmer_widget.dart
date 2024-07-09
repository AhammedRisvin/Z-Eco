import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoco/app/modules/sections%20and%20details/model/get_secdtion_homescreen_model.dart';
import 'package:zoco/app/modules/sections%20and%20details/widgets/carousal_slider.dart';
import 'package:zoco/app/modules/sections%20and%20details/widgets/offer_related_list_widget.dart';
import 'package:zoco/app/modules/sections%20and%20details/widgets/offer_related_product_widget.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import 'category_list_widget.dart';
import 'dot_list_widget.dart';

class SectionHomeScreenShimmerWidget extends StatelessWidget {
  const SectionHomeScreenShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizeBoxH(10),
            const CategoryListWidget(
              categoryid: '',
            ),
            const SizeBoxH(5),
            CarousalSliderWidget(
              carousalBaanner: const [],
              onTap: () {},
            ),
            const SizeBoxH(10),
            const DotListWidget(
              carousalBaanner: [],
            ),
            const SizeBoxH(15),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const OfferRelatedProductListWidget(
                      offer: 0,
                      relatedProducts: [],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizeBoxH(5);
                  },
                  itemCount: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w500,
                    ),
                text: "Top Deals",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 10 / 13,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 0,
                      crossAxisCount: 2),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return OfferRelatedProductWidget(
                      width: Responsive.width * 45,
                      oneProduct: Product(),
                      index: 0,
                      isFrom: '',
                      isFromWhichScreen: '',
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
