import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/cart/view%20model/cart_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../model/get_product_details_model.dart';
import '../view model/section_provider.dart';

class ProductDetailsBottomNavigationBarWidget extends StatelessWidget {
  const ProductDetailsBottomNavigationBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<SectionProvider, GetProductDetailsModel>(
      selector: (p0, provider) => provider.getProductDetailsModel,
      builder: (context, value, child) => Container(
        height: Responsive.height * 9,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppConstants.appBorderColor,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Responsive.width * 38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Selector<SectionProvider, int>(
                      selector: (p0, p1) => p1.selectedProductDiscountPrice,
                      builder: (context, selectedProductDiscountPrice, child) =>
                          CustomTextWidgets(
                        text:
                            "${value.product?.currency ?? ''} ${selectedProductDiscountPrice.toStringAsFixed(2)} ",
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                    Selector<SectionProvider, int>(
                      selector: (p0, p1) => p1.selectedProductPrice,
                      builder: (context, selectedProductPrice, child) =>
                          selectedProductPrice ==
                                  context
                                      .read<SectionProvider>()
                                      .selectedProductDiscountPrice
                              ? const SizedBox.shrink()
                              : CustomTextWidgets(
                                  text:
                                      "${value.product?.currency ?? ''} ${selectedProductPrice.toStringAsFixed(2)}",
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 12,
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 2.5,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        decorationColor:
                                            const Color(0xFF8390A1),
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Responsive.width * 35,
                height: 45,
                child: Selector<SectionProvider, bool>(
                  selector: (p0, p1) => p1.isProductAddedToCart,
                  builder: (context, isProductAddedToCart, child) =>
                      Selector<CartProvider, List>(
                    selector: (p0, p1) => p1.getCartModel.cartData?.cart ?? [],
                    builder: (context, list, child) => CommonButton(
                      fontSize: 16,
                      btnName: list.isEmpty
                          ? "Add To Cart"
                          : isProductAddedToCart
                              ? "View Cart"
                              : "Add To Cart",
                      ontap: () {
                        if (isProductAddedToCart) {
                          context.pushNamed(AppRouter.yourcartscreen);
                        } else {
                          context.read<SectionProvider>().addToCartFn(
                                context: context,
                                productId: value.product?.id ?? "",
                              );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
