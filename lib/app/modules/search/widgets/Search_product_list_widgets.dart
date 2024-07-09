import 'package:flutter/material.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/prefferences.dart';
import '../../home/widgets/offer_tag_widget.dart';

class SearchProductListWidget extends StatelessWidget {
  final double? width;
  final String? imageUrl;
  final String? brand;
  final String? productName;
  final String? orginalAmount;
  final String? discountAmount;
  final num? offer;
  final String? productRating;
  const SearchProductListWidget({
    super.key,
    this.width,
    this.brand,
    this.discountAmount,
    this.imageUrl,
    this.offer,
    this.orginalAmount,
    this.productName,
    this.productRating,
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
                  // image: DecorationImage(
                  //   image: AssetImage(AppImages.recomanded),
                  //   fit: BoxFit.contain,
                  // )
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
                    imageUrl: imageUrl ??
                        "https://blogger.googleusercontent.com/img/a/AVvXsEhUeiRmvP33IgmhAffdiFwHOqweHsFyOW12IoM2sXmU9ZxgzD1hra9-awcHXaF8aL5UZzg6Aa_R_JIde1_ZI-liUkc1UzD2fQYWvUzF7tPX4oyyNxkyGd0jM5_cG_QbA328a_eYs2PN9BCpQRXVEBVrG83lX-I6VrOTvkRfx666VJap6F4AbZakPJioul2y=w640-h192"),
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
                          text: brand ?? "Nike"),
                      const SizeBoxH(5),
                      CustomTextWidgets(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                        text: productName ?? 'Xtream Gi800 Gear 5',
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
                            text: discountAmount ?? 'AED 19.99',
                          ),
                          const SizeBoxV(10),
                          SizedBox(
                            width: 45,
                            height: 12,
                            child: Stack(
                              children: [
                                CustomTextWidgets(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: const Color(0xFF8390A1),
                                        fontSize: 11,
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                  text: orginalAmount ?? 'AED 19.99',
                                ),
                                const Divider(
                                  thickness: 2,
                                  // height: ,
                                )
                              ],
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
                            text: productRating ?? '4.2',
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
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.favorite_border_outlined,
                size: 20,
              ),
            ),
          ),
          Positioned(
            // left: 8,
            top: 5,
            child: OfferTagWidget(
              offer: offer ?? 0,
            ),
          ),
          // Positioned(
        ],
      ),
    );
  }
}
