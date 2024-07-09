import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../model/get_homeproduct_model.dart';
import '../view_model/home_provider.dart';
import 'product_widget.dart';

class HomeRecomendedProductsWidget extends StatelessWidget {
  const HomeRecomendedProductsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<HomeProvider, List<ProductDatum>?>(
      selector: (p0, p1) => p1.recommendedProductList,
      builder: (context, value, child) => value?.isEmpty ?? true
          ? const SizedBox.shrink()
          : Container(
              margin: const EdgeInsets.only(bottom: 10, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidgets(
                    textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 20,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                    text: 'Recommended',
                  ),
                  const SizeBoxH(5),
                  CustomTextWidgets(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color(0xFF8390A1),
                          fontSize: 12,
                          fontFamily: AppConstants.fontFamily,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                    text: 'Super summer sale',
                  ),
                  const SizeBoxH(20),
                  SizedBox(
                    height: 210,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: value?.length ?? 0,
                      itemBuilder: (context, index) {
                        var product = value?[index];
                        return CommonInkwell(
                          onTap: () {
                            context.pushNamed(
                              AppRouter.productDetailsViewScreen,
                              queryParameters: {
                                'productLink': product?.link ?? '',
                                'fromWhichList': "HomescreenRecommended",
                                'selectedListIndex': index.toString()
                              },
                            );
                          },
                          child: ProductWidget(
                            isFrom: 'home',
                            withCart: true,
                            isFromWhichScreen: "Recommended",
                            product: product,
                            width: Responsive.width * 44,
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
                      separatorBuilder: (context, index) => const SizeBoxV(15),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
