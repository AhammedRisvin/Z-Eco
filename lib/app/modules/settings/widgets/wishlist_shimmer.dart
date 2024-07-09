import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/prefferences.dart';

class WishListProductWidgetShimmer extends StatelessWidget {
  final bool withCart;
  final double width;
  // final Product? wishListProduct;

  const WishListProductWidgetShimmer({
    Key? key,
    this.withCart = true,
    // this.wishListProduct,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
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
          ],
        ),
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
                ),
                Container(
                  width: width,
                  height: withCart == true ? 135 : 95,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppPref.isDark == true
                        ? AppConstants.containerColor
                        : const Color(0xFFF9F9FB),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(.028),
                      ),
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
            const Positioned(
              right: 5,
              top: 5,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
