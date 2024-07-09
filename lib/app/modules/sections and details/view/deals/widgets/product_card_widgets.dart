import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/home/view_model/home_provider.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../../../helpers/common_widgets.dart';
import '../../../../../helpers/sized_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/prefferences.dart';
import '../../../../home/widgets/offer_tag_widget.dart';
import '../../../model/get_deals_model.dart';

class DealsProductWidget extends StatelessWidget {
  final bool? bigsavingyou;
  final bool? isSpecialDeal;
  final BigSaving? productModel;
  final double? width;
  final int index;
  final void Function()? onTap;
  const DealsProductWidget(
      {super.key,
      this.width,
      this.bigsavingyou,
      this.isSpecialDeal,
      this.onTap,
      required this.index,
      this.productModel});

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.transparent,
          )
        ]),
        width: width ?? Responsive.width * 44,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: width,
                  height: 112,
                  decoration: const ShapeDecoration(
                    color: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                  ),
                  child: CachedImageWidget(
                      width: width ?? Responsive.width * 44,
                      // height: 112,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      imageUrl: productModel?.images?.first ??
                          "https://api.dev.test.image.theowpc.com/chkUz0Dj8.jpeg"),
                ),
                Container(
                  width: width,
                  height: isSpecialDeal == true
                      ? 80
                      : bigsavingyou == true
                          ? 85
                          : 95,
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
                    padding: const EdgeInsets.all(8.0),
                    child: isSpecialDeal == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizeBoxH(10),
                              CustomTextWidgets(
                                overflow: TextOverflow.ellipsis,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                text: productModel?.productName?.trim() ?? '',
                              ),
                              const SizeBoxH(10),
                              Row(
                                children: [
                                  CustomTextWidgets(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 12,
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                    text: 'From',
                                  ),
                                  const SizeBoxV(5),
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
                                        '${productModel?.currency ?? ''} ${productModel?.discountPrice?.toStringAsFixed(2) ?? 0}',
                                  ),
                                ],
                              ),
                            ],
                          )
                        : bigsavingyou == true
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Responsive.text * 5,
                                        child: CustomTextWidgets(
                                            overflow: TextOverflow.ellipsis,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                            text: productModel?.productName
                                                    ?.trim() ??
                                                ''),
                                      ),
                                      CustomTextWidgets(
                                        overflow: TextOverflow.ellipsis,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: const Color(0xffDB3022),
                                              fontSize: 12,
                                              fontFamily: 'Plus Jakarta Sans',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                        text: 'Limited time deal',
                                      ),
                                    ],
                                  ),
                                  const SizeBoxH(5),
                                  CustomTextWidgets(
                                    overflow: TextOverflow.ellipsis,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                    text:
                                        productModel?.brandInfo?.name?.trim() ??
                                            "",
                                  ),
                                  const SizeBoxH(5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Responsive.width * 4,
                                        child: CustomTextWidgets(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14,
                                                fontFamily: 'Plus Jakarta Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                          text:
                                              '${productModel?.currency ?? ''} ${productModel?.discountPrice?.toStringAsFixed(2) ?? 0}',
                                        ),
                                      ),
                                      productModel?.ratings?.count != 0
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
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 0,
                                                      ),
                                                  text:
                                                      '${productModel?.ratings?.count ?? 0}',
                                                ),
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  )
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: CustomTextWidgets(
                                        overflow: TextOverflow.ellipsis,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                        text: productModel?.brandInfo?.name
                                                ?.trim() ??
                                            ""),
                                  ),
                                  const SizeBoxH(5),
                                  CustomTextWidgets(
                                    overflow: TextOverflow.ellipsis,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                    text:
                                        productModel?.productName?.trim() ?? '',
                                  ),
                                  const SizeBoxH(5),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Responsive.width * 25,
                                        child: CustomTextWidgets(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14,
                                                fontFamily: 'Plus Jakarta Sans',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                          text:
                                              '${productModel?.currency ?? ''} ${productModel?.discountPrice?.toStringAsFixed(2) ?? 0}',
                                        ),
                                      ),
                                      // const SizeBoxV(10),
                                      Expanded(
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
                                          text:
                                              '${productModel?.currency ?? ''} ${productModel?.price?.toStringAsFixed(2) ?? 0}',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizeBoxH(5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      productModel?.ratings?.count != 0
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
                                                          fontFamily:
                                                              'Plus Jakarta Sans',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                    text: context
                                                        .read<HomeProvider>()
                                                        .formatNumber(
                                                            productModel
                                                                    ?.ratings
                                                                    ?.average ??
                                                                0.0)),
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                      CustomTextWidgets(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: const Color(0xffDB3022),
                                              fontSize: 12,
                                              fontFamily: 'Plus Jakarta Sans',
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                        text: 'Limited time deal',
                                      ),
                                    ],
                                  ),
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
                  builder: (context, provider, child) => CommonInkwell(
                    onTap: () {
                      productModel?.wishlist == true
                          ? provider.removeFromWishlistFn(
                              index: index,
                              isFromWhichList: "isFromWhichScreen",
                              isFrom: "isFrom",
                              context: context,
                              productId: productModel?.productId ??
                                  productModel?.id ??
                                  '',
                            )
                          : provider.addToWishlistFn(
                              index: index,
                              isFrom: "isFrom",
                              isFromWhichList: "isFromWhichScreen",
                              context: context,
                              productId: productModel?.productId ??
                                  productModel?.id ??
                                  '',
                            );
                    },
                    child: Icon(
                      productModel?.wishlist == true
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      size: 20,
                      color: productModel?.wishlist == true
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 5,
              child: productModel?.offers != 0
                  ? OfferTagWidget(
                      offer: productModel?.offers ?? 0,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
