import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/home/view_model/home_provider.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/prefferences.dart';
import '../model/get_homeproduct_model.dart';
import 'offer_tag_widget.dart';

class ProductWidget extends StatelessWidget {
  final bool withCart;
  final double width;
  final String isFrom;
  final String isFromWhichScreen;
  final ProductDatum? product;
  final int index;
  final String? currency;
  final String? currencyIcon;

  const ProductWidget({
    super.key,
    this.withCart = true,
    required this.width,
    this.product,
    required this.index,
    required this.isFromWhichScreen,
    required this.isFrom,
    required this.currency,
    required this.currencyIcon,
  });

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = context.read<HomeProvider>();
    return Container(
      decoration: BoxDecoration(boxShadow: [
        withCart == true
            ? BoxShadow(
                color: Colors.black.withOpacity(.027),
                blurRadius: .02,
                offset: const Offset(5, -9),
                spreadRadius: .02,
              )
            : const BoxShadow(
                color: Colors.transparent,
              )
      ]),
      width: width,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: width,
                height: 112,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                ),
                child: CachedImageWidget(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    imageUrl: product?.images?.first ?? ""),
              ),
              Container(
                width: width,
                height: 95,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppPref.isDark == true
                      ? AppConstants.containerColor
                      : const Color(0xFFF9F9FB),
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.black.withOpacity(.028),
                  )),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidgets(
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                          text: product?.productName ?? ""),
                      const SizeBoxH(5),
                      CustomTextWidgets(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                        text: product?.brandInfo?.name ?? "",
                      ),
                      const SizeBoxH(5),
                      Row(
                        children: [
                          CustomTextWidgets(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 14,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                            text:
                                '${currency ?? ''} ${currencyIcon ?? ''}${product?.discountPrice?.toStringAsFixed(2) ?? ""}',
                          ),
                          const SizeBoxV(10),
                          product?.discountPrice == product?.price
                              ? const SizedBox.shrink()
                              : Expanded(
                                  child: CustomTextWidgets(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationThickness: 2.5,
                                          decorationStyle:
                                              TextDecorationStyle.solid,
                                          decorationColor:
                                              const Color(0xFF8390A1),
                                          color: const Color(0xFF8390A1),
                                          fontSize: 11,
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                    text: product?.price?.toStringAsFixed(2) ??
                                        "",
                                  ),
                                ),
                        ],
                      ),
                      const SizeBoxH(5),
                      product?.ratings != 0
                          ? Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Color(0xFFFFC732),
                                ),
                                const SizeBoxV(5),
                                CustomTextWidgets(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 12,
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                  text: provider
                                      .formatNumber(product?.ratings ?? 0.0),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: Responsive.width * 35,
            top: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<HomeProvider>(
                builder: (context, value, child) => CommonInkwell(
                  onTap: () {
                    product?.wishlist == true
                        ? provider.removeFromWishlistFn(
                            index: index,
                            isFromWhichList: isFromWhichScreen,
                            isFrom: isFrom,
                            context: context,
                            productId: product?.productId ?? '',
                          )
                        : provider.addToWishlistFn(
                            index: index,
                            isFrom: isFrom,
                            isFromWhichList: isFromWhichScreen,
                            context: context,
                            productId: product?.productId ?? '',
                          );
                  },
                  child: product?.wishlist == true
                      ? const Icon(
                          Icons.favorite_outlined,
                          size: 22,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border_outlined,
                          size: 22,
                        ),
                ),
              ),
            ),
          ),
          product?.offers != 0
              ? Positioned(
                  top: 5,
                  child: OfferTagWidget(
                    offer: product?.offers ?? 0,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
