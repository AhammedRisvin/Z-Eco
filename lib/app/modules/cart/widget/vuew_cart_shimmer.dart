import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extentions.dart';
import '../view model/cart_provider.dart';
import 'cartproduct_details_screen.dart';
import 'price_details_row.dart';

class ViewCartShimmer extends StatelessWidget {
  const ViewCartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          child: Consumer<CartProvider>(
            builder: (context, provider, child) => Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var cartData =
                              provider.getCartModel.cartData?.cart?[index];
                          return CartProductDetailsContainer(
                            singleCartData: cartData,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizeBoxH(Responsive.height * 2),
                        itemCount:
                            provider.getCartModel.cartData?.cart?.length ?? 0),
                    SizeBoxH(Responsive.height * 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: Responsive.width * 100,
                      height: Responsive.height * 7,
                      child: CustomTextFormFieldWidget(
                        suffix: Container(
                          margin: const EdgeInsets.only(
                              right: 8, top: 3, bottom: 3),
                          width: Responsive.width * 20,
                          height: Responsive.height * 1,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextWidgets(
                                text: 'Apply',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      height: 0.15,
                                      letterSpacing: 0.50,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        controller:
                            Provider.of<CartProvider>(context, listen: false)
                                .couponCodeController,
                        hintText: 'Coupon Code',
                      ),
                    ),
                    SizeBoxH(Responsive.height * 2),
                    CommonInkwell(
                      onTap: () {},
                      child: Container(
                        height: Responsive.height * 5.5,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Responsive.width * 60,
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppImages.cartOfferIcon,
                                    height: Responsive.height * 3.5,
                                  ),
                                  const SizeBoxV(20),
                                  CustomTextWidgets(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 12,
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontWeight: FontWeight.w600,
                                          height: 0.15,
                                          letterSpacing: 0.50,
                                        ),
                                    text: "View Available Offers",
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizeBoxH(Responsive.height * 2),
                    Container(
                      width: Responsive.width * 100,
                      height: Responsive.height * 25,
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidgets(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                            text: "Price Details",
                          ),
                          SizeBoxH(Responsive.height * 3),
                          PriceDetailsRowWidget(
                            title:
                                "Items (${provider.getCartModel.cartData?.totalItem ?? 0})",
                            price: "\$598.86",
                            titleColor: AppConstants.appMainGreyColor,
                          ),
                          SizeBoxH(Responsive.height * 2),
                          const PriceDetailsRowWidget(
                            title: "Shipping",
                            price: "\$598.86",
                            titleColor: AppConstants.appMainGreyColor,
                          ),
                          SizeBoxH(Responsive.height * 2),
                          const PriceDetailsRowWidget(
                            title: "Import charges",
                            titleColor: AppConstants.appMainGreyColor,
                            price: "\$598.86",
                          ),
                          SizeBoxH(Responsive.height * 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextWidgets(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 12,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 0.12,
                                    ),
                                text: "Total Price",
                              ),
                              CustomTextWidgets(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 12,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 0.12,
                                    ),
                                text:
                                    "\$ ${provider.getCartModel.cartData?.totalPrice ?? 0}",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizeBoxH(Responsive.height * 2),
                    CommonButton(
                      btnName: "Checkout",
                      ontap: () {},
                    )
                  ],
                )),
          ),
        ));
  }
}
