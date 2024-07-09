import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/modules/orders/view%20model/order_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../model/get_cart_model.dart';

class CheckoutProductDetailsContainer extends StatelessWidget {
  final bool isFromOrders;
  final String titleFromOrders;
  final Color titleColor;
  final bool isFromCompleted;
  final bool isACtive;
  final Cart? checkoUtData;
  final String? currency;
  final String? currencyIcon;

  const CheckoutProductDetailsContainer({
    super.key,
    this.isFromOrders = false,
    this.titleFromOrders = "",
    this.titleColor = const Color(0xff1DC57E),
    this.isFromCompleted = false,
    this.isACtive = false,
    this.checkoUtData,
    required this.currency,
    required this.currencyIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isFromOrders ? Responsive.height * 22 : Responsive.height * 16.5,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppConstants.appBorderColor),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: Responsive.height * 13.5,
                width: Responsive.width * 25,
                child: CachedImageWidget(
                  imageUrl: checkoUtData?.images?[0] ?? '',
                  height: Responsive.height * 100,
                  width: Responsive.width * 25,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizeBoxV(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    isFromOrders
                        ? Column(
                            children: [
                              CustomTextWidgets(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: titleColor,
                                    ),
                                text: titleFromOrders,
                                maxLines: 2,
                              ),
                              SizeBoxH(Responsive.height * 0.5),
                            ],
                          )
                        : const SizedBox.shrink(),
                    CustomTextWidgets(
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                      text: checkoUtData?.productName ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    SizeBoxH(Responsive.height * 1),
                    SizedBox(
                      height: 20,
                      child: Row(
                        children: [
                          CustomTextWidgets(
                            text: 'Size : ${checkoUtData?.size ?? ""}',
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const VerticalDivider(color: Colors.black),
                          CustomTextWidgets(
                            text: 'Qty : ${checkoUtData?.quantity ?? ""}',
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizeBoxH(Responsive.height * 1),
                    CustomTextWidgets(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                            color: context.watch<ThemeProvider>().isDarkMode ==
                                    true
                                ? const Color(0xffffffff)
                                : const Color(0xFF303030),
                            fontSize: 14,
                            fontFamily: 'Plus Jakarta Sans',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                      text:
                          "${currencyIcon ?? ''}${checkoUtData?.price?.toStringAsFixed(2) ?? ""} ${currency ?? ''}",
                    ),
                  ],
                ),
              ),
            ],
          ),
          isFromOrders
              ? isFromCompleted
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        checkoUtData?.isReturn == false
                            ? const SizedBox.shrink()
                            : OrdersSmallContainerForCancelAndView(
                                isFromCancel: true,
                                width: Responsive.width * 20,
                                onTap: () {
                                  context.read<OrderProvider>().canceledOrderFn(
                                      bookingId: checkoUtData?.bookingId);
                                  context
                                      .read<OrderProvider>()
                                      .isReturnedTrueFnc(value: true);
                                  context
                                      .pushNamed(AppRouter.cancelOrderScreen);
                                },
                                title: "Return",
                              ),
                        const SizeBoxV(10),
                        OrdersSmallContainerForCancelAndView(
                          width: Responsive.width * 30,
                          onTap: () {
                            context.pushNamed(AppRouter.writeReviewScreen,
                                queryParameters: {
                                  "productId": checkoUtData?.productId ?? ''
                                });
                          },
                          title: "Write a Review",
                        ),
                        const SizeBoxV(10),
                      ],
                    )
                  : isACtive
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            checkoUtData?.orderStatus == 'Placed' ||
                                    checkoUtData?.orderStatus == 'Picked'
                                ? OrdersSmallContainerForCancelAndView(
                                    isFromCancel: true,
                                    width: Responsive.width * 30,
                                    onTap: () {
                                      context
                                          .read<OrderProvider>()
                                          .canceledOrderFn(
                                              bookingId:
                                                  checkoUtData?.bookingId);
                                      context.pushNamed(
                                          AppRouter.cancelOrderScreen);
                                    },
                                    title: "Cancel Order",
                                  )
                                : const SizedBox.shrink(),
                            const SizeBoxV(10),
                            OrdersSmallContainerForCancelAndView(
                              width: Responsive.width * 20,
                              onTap: () {
                                context
                                    .read<OrderProvider>()
                                    .getOrderProductDetailFnc(
                                        context: context,
                                        bookingId:
                                            checkoUtData?.bookingId ?? '',
                                        sizeId: checkoUtData?.sizeId ?? '');
                              },
                              title: "View",
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OrdersSmallContainerForCancelAndView(
                              width: Responsive.width * 30,
                              onTap: () {
                                context.pushNamed(
                                    AppRouter.productDetailsViewScreen,
                                    queryParameters: {
                                      'productLink':
                                          checkoUtData?.productLink ?? '',
                                    });
                              },
                              title: "Order Again",
                            ),
                            const SizeBoxV(10),
                          ],
                        )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class OrdersSmallContainerForCancelAndView extends StatelessWidget {
  final void Function() onTap;
  final double width;
  final bool isFromCancel;
  final String title;
  const OrdersSmallContainerForCancelAndView({
    super.key,
    required this.onTap,
    required this.width,
    this.isFromCancel = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        height: Responsive.height * 4,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isFromCancel
              ? const Color(0xffFFE0E5)
              : AppConstants.appPrimaryColor,
        ),
        child: Center(
          child: CustomTextWidgets(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isFromCancel
                      ? const Color(0xFFEB002B)
                      : AppConstants.white,
                  fontSize: 14,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
            text: title,
          ),
        ),
      ),
    );
  }
}
