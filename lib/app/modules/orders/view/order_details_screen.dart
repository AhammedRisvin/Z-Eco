import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/orders/view%20model/order_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/enums.dart';
import '../../cart/view model/cart_provider.dart';
import '../../cart/widget/price_details_row.dart';
import '../widget/alert_dialog.dart';
import '../widget/stepper-widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String? isACtive;
  const OrderDetailsScreen({this.isACtive, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: const CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: 'Order Details',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        width: Responsive.width * 100,
        child: SingleChildScrollView(
          child: Consumer<OrderProvider>(builder: (context, obj, _) {
            return obj.orderDetailsStatus == OrderDetailsStatus.loading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey[300],
                          width: Responsive.width * 100,
                          height: Responsive.height * 100,
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StepperWidget(
                          orderStatus: obj.ordersModel.response?[obj.itemLength]
                              .shippingInfo?.length),
                      CommonInkwell(
                        onTap: () {
                          context
                              .pushNamed(AppRouter.orderDetailsStepperScreen);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            obj.orderPrdoct.orderDatas?.first.otp == null ||
                                    obj.orderPrdoct.orderDatas!.first.otp!
                                        .isEmpty
                                ? const SizedBox.shrink()
                                : CustomTextWidgets(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: AppConstants.appPrimaryColor,
                                        ),
                                    text:
                                        "OTP : ${obj.orderPrdoct.orderDatas?.first.otp ?? ''}",
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomTextWidgets(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppConstants.appPrimaryColor,
                                      ),
                                  text: "See More",
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppConstants.appPrimaryColor,
                                  size: 18,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizeBoxH(Responsive.height * 2),
                      Container(
                        width: Responsive.width * 100,
                        height: Responsive.height * 6,
                        padding: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: AppConstants.appMainGreyColor,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Order ID -',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: context
                                                      .watch<ThemeProvider>()
                                                      .isDarkMode ==
                                                  true
                                              ? const Color(0xffffffff)
                                              : AppConstants.appMainGreyColor,
                                          fontSize: 14,
                                        ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' ${obj.orderPrdoct.orderDatas?.first.orderId ?? ''}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: context
                                                      .watch<ThemeProvider>()
                                                      .isDarkMode ==
                                                  true
                                              ? const Color(0xffffffff)
                                              : AppConstants.black,
                                          fontSize: 14,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizeBoxH(Responsive.height * 4),
                      CustomTextWidgets(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                        text: "Product",
                      ),
                      SizeBoxH(Responsive.height * 2),
                      const orderProductScreen(),
                      SizeBoxH(Responsive.height * 4),
                      CustomTextWidgets(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                        text: "Shipping Details",
                      ),
                      SizeBoxH(Responsive.height * 2),
                      Container(
                        width: Responsive.width * 100,
                        // height: Responsive.height * 25,
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: AppConstants.appBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            PriceDetailsRowWidget(
                              title: "State",
                              price:
                                  ' ${obj.orderPrdoct.shippingAddress?.state ?? ''}',
                            ),
                            SizeBoxH(Responsive.height * 2),
                            PriceDetailsRowWidget(
                              title: "City",
                              price:
                                  " ${obj.orderPrdoct.shippingAddress?.city ?? ''}",
                            ),
                            SizeBoxH(Responsive.height * 2),
                            PriceDetailsRowWidget(
                              title: "Zipcode",
                              price:
                                  " ${obj.orderPrdoct.shippingAddress?.pincode ?? ''}",
                            ),
                            SizeBoxH(Responsive.height * 2),
                            PriceDetailsRowWidget(
                              title: "Address",
                              price:
                                  " ${obj.orderPrdoct.shippingAddress?.address ?? ''}",
                            ),
                          ],
                        ),
                      ),
                      SizeBoxH(Responsive.height * 4),
                      CustomTextWidgets(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                        text: "Payment Details",
                      ),
                      SizeBoxH(Responsive.height * 2),
                      Container(
                        width: Responsive.width * 100,
                        height: Responsive.height * 29,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: AppConstants.appBorderColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PriceDetailsRowWidget(
                                title:
                                    "Items (${obj.orderPrdoct.orderDatas?.first.quantity ?? ''})",
                                price:
                                    "${obj.orderPrdoct.currency ?? ''} ${obj.orderPrdoct.currencySymbol ?? ''}${obj.orderPrdoct.orderDatas?.first.price?.toStringAsFixed(2) ?? ''}",
                              ),
                            ),
                            SizeBoxH(Responsive.height * 1),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PriceDetailsRowWidget(
                                title: "Discount",
                                price:
                                    "${obj.orderPrdoct.currency ?? ''} ${obj.orderPrdoct.currencySymbol ?? ''}${obj.orderPrdoct.orderDatas?.first.discount?.toStringAsFixed(2) ?? ''}",
                              ),
                            ),
                            SizeBoxH(Responsive.height * 2),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          color: const Color(0xFF2F4EFF),
                                          fontSize: 12,
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 0.12,
                                        ),
                                    text:
                                        "${obj.orderPrdoct.currency ?? ''} ${obj.orderPrdoct.currencySymbol ?? ''}${obj.orderPrdoct.orderDatas?.first.totalPrice?.toStringAsFixed(2) ?? ''}",
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: isACtive == 'isACtive'
                                  ? MainAxisAlignment.spaceEvenly
                                  : MainAxisAlignment.center,
                              children: [
                                if (isACtive == 'isActive' &&
                                        obj.orderPrdoct.orderDatas?.first
                                                .orderStatus ==
                                            'Placed' ||
                                    obj.orderPrdoct.orderDatas?.first
                                            .orderStatus ==
                                        'Picked')
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialogBox();
                                        },
                                      );
                                    },
                                    child: CustomTextWidgets(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color:
                                                AppConstants.appMainGreyColor,
                                            fontSize: 14,
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontWeight: FontWeight.w700,
                                          ),
                                      text: "Cancel Order",
                                    ),
                                  ),
                                if (isACtive == 'isDeliverd')
                                  TextButton(
                                    onPressed: () {
                                      context.pushNamed(
                                          AppRouter.writeReviewScreen,
                                          queryParameters: {
                                            "productId": obj
                                                    .orderPrdoct
                                                    .orderDatas
                                                    ?.first
                                                    .productId ??
                                                ''
                                          });
                                    },
                                    child: CustomTextWidgets(
                                      textAlign: TextAlign.center,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: AppConstants.appPrimaryColor,
                                            fontSize: 14,
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontWeight: FontWeight.w700,
                                          ),
                                      text: "Write a review",
                                    ),
                                  )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}

class orderProductScreen extends StatelessWidget {
  const orderProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, obj, _) {
      return Container(
        width: Responsive.width * 100,
        height: Responsive.height * 14,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side:
                const BorderSide(width: 1, color: AppConstants.appBorderColor),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          children: [
            CachedImageWidget(
              imageUrl:
                  "${obj.orderPrdoct.orderDatas?.first.productImage?.first}",
              height: Responsive.height * 100,
              width: Responsive.width * 25,
            ),
            const SizeBoxV(10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidgets(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                    text: obj.orderPrdoct.orderDatas?.first.productName ?? '',
                  ),
                  CustomTextWidgets(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                    text: obj.orderPrdoct.orderDatas?.first.brandName ?? '',
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 6.5),
                    decoration: ShapeDecoration(
                      color: context.watch<ThemeProvider>().isDarkMode
                          ? Colors.transparent
                          : const Color(0xffF2F5FC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(31),
                      ),
                    ),
                    child: CustomTextWidgets(
                      text:
                          'Size : ${obj.orderPrdoct.orderDatas?.first.size ?? ''}',
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                    ),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidgets(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color:
                                    context.watch<ThemeProvider>().isDarkMode ==
                                            true
                                        ? const Color(0xffffffff)
                                        : const Color(0xFF303030),
                                fontSize: 14,
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                          text:
                              "Qty :${obj.orderPrdoct.orderDatas?.first.quantity ?? ''} ",
                        ),
                        CustomTextWidgets(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color:
                                    context.watch<ThemeProvider>().isDarkMode ==
                                            true
                                        ? const Color(0xffffffff)
                                        : const Color(0xFF303030),
                                fontSize: 14,
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                          text:
                              "${obj.orderPrdoct.currency ?? ''} ${obj.orderPrdoct.currencySymbol ?? ''}${obj.orderPrdoct.orderDatas?.first.price?.toStringAsFixed(2) ?? ''}",
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
