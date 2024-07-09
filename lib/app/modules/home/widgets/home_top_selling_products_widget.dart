import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import '../model/get_homeproduct_model.dart';
import '../view_model/home_provider.dart';
import 'product_widget.dart';

class HomeTopSellingProductsWidget extends StatelessWidget {
  const HomeTopSellingProductsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<HomeProvider, GetHomeProductsModel>(
      selector: (p0, provider) => provider.topSellingProductModel,
      builder: (context, value, child) => Container(
        margin: const EdgeInsets.only(bottom: 5, top: 15),
        child: value.productData?.isEmpty == true
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidgets(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 20,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                    text: 'Top Selling',
                  ),
                  const SizeBoxH(15),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: Responsive.height * 0.095,
                      crossAxisSpacing: 8,
                      crossAxisCount: 2,
                    ),
                    itemCount: value.productData?.length ?? 0,
                    itemBuilder: (context, index) {
                      var data = value.productData?[index];
                      return CommonInkwell(
                        onTap: () => context.pushNamed(
                          AppRouter.productDetailsViewScreen,
                          queryParameters: {
                            'productLink': data?.link ?? '',
                            'fromWhichList': "HomescreenTopSelling",
                            'selectedListIndex': index.toString()
                          },
                        ),
                        child: ProductWidget(
                          isFrom: 'home',
                          withCart: false,
                          product: data,
                          isFromWhichScreen: "Top Selling",
                          width: Responsive.width * 100,
                          index: index,
                          currency: context
                              .read<HomeProvider>()
                              .recomendedProductsModel
                              .currency,
                          currencyIcon: context
                              .read<HomeProvider>()
                              .recomendedProductsModel
                              .currencySymbol,
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
