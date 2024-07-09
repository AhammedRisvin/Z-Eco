import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/home/view_model/home_provider.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/prefferences.dart';
import '../../home/widgets/offer_tag_widget.dart';
import '../model/get_secdtion_homescreen_model.dart';

class OfferRelatedProductWidget extends StatelessWidget {
  final double width;
  final num? offer;
  final Product? oneProduct;

  final String isFrom;
  final String isFromWhichScreen;
  final int index;
  const OfferRelatedProductWidget({
    super.key,
    required this.width,
    this.oneProduct,
    this.offer,
    required this.index,
    required this.isFrom,
    required this.isFromWhichScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.transparent,
        )
      ]),
      width: width,
      child: Stack(
        children: [
          Column(
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
                    imageUrl: oneProduct?.images?.first ??
                        "https://blogger.googleusercontent.com/img/a/AVvXsEhUeiRmvP33IgmhAffdiFwHOqweHsFyOW12IoM2sXmU9ZxgzD1hra9-awcHXaF8aL5UZzg6Aa_R_JIde1_ZI-liUkc1UzD2fQYWvUzF7tPX4oyyNxkyGd0jM5_cG_QbA328a_eYs2PN9BCpQRXVEBVrG83lX-I6VrOTvkRfx666VJap6F4AbZakPJioul2y=w640-h192"),
              ),
              Container(
                width: width,
                height: 100,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidgets(
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                          text: oneProduct?.productName?.trim() ?? ''),
                      const SizeBoxH(5),
                      CustomTextWidgets(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                        text: oneProduct?.description?.trim() ?? '', //
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
                                '${oneProduct?.currency ?? ''} ${oneProduct?.discountPrice?.toInt().toStringAsFixed(2) ?? 0}',
                          ),
                          const SizeBoxV(10),
                          oneProduct?.discountPrice == oneProduct?.price
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
                                    text: "${oneProduct?.price?.toInt() ?? ""}",
                                  ),
                                ),
                        ],
                      ),
                      const SizeBoxH(5),
                      oneProduct?.ratings?.average != null &&
                              oneProduct?.ratings?.average != 0
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
                                  text: "${oneProduct?.ratings?.average ?? 0}",
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
                builder: (context, provider, child) => CommonInkwell(
                  onTap: () {
                    oneProduct?.wishlist == true
                        ? provider.removeFromWishlistFn(
                            index: index,
                            isFromWhichList: isFromWhichScreen,
                            isFrom: isFrom,
                            context: context,
                            offerProduct: oneProduct,
                            productId: oneProduct?.id ?? '',
                          )
                        : provider.addToWishlistFn(
                            index: index,
                            isFrom: isFrom,
                            isFromWhichList: isFromWhichScreen,
                            context: context,
                            offerProduct: oneProduct,
                            productId: oneProduct?.id ?? '',
                          );
                  },
                  child: Icon(
                    oneProduct?.wishlist == true
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    size: 20,
                    color: oneProduct?.wishlist == true
                        ? Colors.red
                        : AppConstants.black,
                  ),
                ),
              ),
            ),
          ),
          oneProduct?.offers != 0
              ? Positioned(
                  top: 5,
                  child: OfferTagWidget(
                    offer: oneProduct?.offers ?? 0,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
