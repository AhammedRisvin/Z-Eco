import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/settings/view%20model/settings_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/prefferences.dart';
import '../../home/view_model/home_provider.dart';
import '../../sections and details/model/get_secdtion_homescreen_model.dart';

class WishListProductWidget extends StatelessWidget {
  final bool withCart;
  final double width;
  final Product? wishListProduct;
  const WishListProductWidget({
    super.key,
    this.withCart = true,
    this.wishListProduct,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
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
                    imageUrl: wishListProduct?.images?.first ??
                        "https://blogger.googleusercontent.com/img/a/AVvXsEhUeiRmvP33IgmhAffdiFwHOqweHsFyOW12IoM2sXmU9ZxgzD1hra9-awcHXaF8aL5UZzg6Aa_R_JIde1_ZI-liUkc1UzD2fQYWvUzF7tPX4oyyNxkyGd0jM5_cG_QbA328a_eYs2PN9BCpQRXVEBVrG83lX-I6VrOTvkRfx666VJap6F4AbZakPJioul2y=w640-h192"),
              ),
              Container(
                width: width,
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
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                          text: wishListProduct?.productName ?? ''),
                      const SizeBoxH(5),
                      CustomTextWidgets(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                        text: wishListProduct?.description ?? '',
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
                                '${wishListProduct?.discountPrice == wishListProduct?.price ? wishListProduct?.price ?? '' : wishListProduct?.discountPrice ?? ""} ${wishListProduct?.currency ?? ""}',
                          ),
                          const SizeBoxV(10),
                          wishListProduct?.discountPrice ==
                                  wishListProduct?.price
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
                                    text:
                                        '${wishListProduct?.price ?? ''} ${wishListProduct?.currency ?? ''}',
                                  ),
                                ),
                        ],
                      ),
                      const SizeBoxH(5),
                      Row(
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
                            text: context.read<HomeProvider>().formatNumber(
                                wishListProduct?.ratings?.average ?? 0.0),
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
            right: 5,
            top: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonInkwell(
                onTap: () {
                  context.read<SettingsProvider>().removeFromWishlistFn(
                        context: context,
                        productId: wishListProduct?.id ?? "",
                      );
                },
                child: const Icon(
                  Icons.close,
                  size: 20,
                ),
              ),
            ),
          ),
          wishListProduct?.offers == 0
              ? const SizedBox.shrink()
              : Positioned(
                  // left: 8,
                  top: 5,
                  child: Container(
                    width: 46,
                    height: 24,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFDB3022),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    child: Center(
                      child: CustomTextWidgets(
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                          text: "20%"),
                    ),
                  ),
                ),
          // Positioned(
        ],
      ),
    );
  }
}
