import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/cart/view%20model/cart_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extentions.dart';
import '../model/get_cart_model.dart';

class CartProductDetailsContainer extends StatefulWidget {
  final bool isFromOrders;
  final bool isFromOrderDetails;
  final Cart? singleCartData;
  final int? index;
  final String? currency;
  const CartProductDetailsContainer({
    super.key,
    this.isFromOrders = false,
    this.isFromOrderDetails = false,
    this.singleCartData,
    this.index,
    this.currency,
  });

  @override
  State<CartProductDetailsContainer> createState() =>
      _CartProductDetailsContainerState();
}

class _CartProductDetailsContainerState
    extends State<CartProductDetailsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      height: Responsive.height * 16,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppConstants.appBorderColor),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        children: [
          CachedImageWidget(
            imageUrl: widget.singleCartData?.images?.first ?? "",
            height: Responsive.height * 100,
            width: Responsive.width * 25,
            borderRadius: BorderRadius.circular(15),
          ),
          const SizeBoxV(10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextWidgets(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                        text: widget.singleCartData?.productName ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    widget.isFromOrderDetails
                        ? const SizedBox.shrink()
                        : CommonInkwell(
                            onTap: () {
                              context.read<CartProvider>().cartRemoveFn(
                                  context: context,
                                  productId:
                                      widget.singleCartData?.productId ?? "",
                                  selectedSizeId:
                                      widget.singleCartData?.sizeId ?? "");
                            },
                            child: const Icon(
                              Icons.close,
                              size: 22,
                              color: AppConstants.appMainGreyColor,
                            ),
                          )
                  ],
                ),
                Container(
                  height: 25,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(31),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextWidgets(
                        text: 'Size : ${widget.singleCartData?.size ?? ""}',
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 0.13,
                                ),
                      ),
                    ],
                  ),
                ),
                Consumer<CartProvider>(
                  builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.isFromOrders
                          ? CustomTextWidgets(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: context
                                                .watch<ThemeProvider>()
                                                .isDarkMode ==
                                            true
                                        ? const Color(0xffffffff)
                                        : const Color(0xFF303030),
                                    fontSize: 14,
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                              text:
                                  "Qty : ${widget.singleCartData?.quantity ?? '0'} ",
                            )
                          : SizedBox(
                              width: Responsive.width * 25,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonInkwell(
                                    onTap: () {
                                      if ((widget.singleCartData?.quantity ??
                                              0) >
                                          0) {
                                        value.quantityDecrementFn(
                                          productId: widget
                                                  .singleCartData?.productId ??
                                              "",
                                          selectedSizeId:
                                              widget.singleCartData?.sizeId ??
                                                  "",
                                          quantity: widget
                                                  .singleCartData?.quantity
                                                  ?.toInt() ??
                                              0,
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppConstants
                                                .containerBorderColor),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppImages.cartMinusIcon,
                                            fit: BoxFit.contain,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  CustomTextWidgets(
                                    text: widget.singleCartData?.quantity
                                            .toString() ??
                                        "",
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          height: 0.13,
                                        ),
                                  ),
                                  CommonInkwell(
                                    onTap: () {
                                      value.quantityIncrementFn(
                                          productId: widget
                                                  .singleCartData?.productId ??
                                              "",
                                          selectedSizeId:
                                              widget.singleCartData?.sizeId ??
                                                  "",
                                          quantity: widget
                                                  .singleCartData?.quantity
                                                  ?.toInt() ??
                                              0,
                                          totalQuantity: widget.singleCartData
                                                  ?.availableQuantity
                                                  ?.toInt() ??
                                              0,
                                          context: context);
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppConstants
                                                .containerBorderColor),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppImages.cartAddIocn,
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                            "${widget.singleCartData?.pricePerItem?.toStringAsFixed(2) ?? ""} ${widget.currency ?? ""}",
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
  }
}
