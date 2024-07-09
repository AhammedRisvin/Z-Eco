import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/modules/settings/view%20model/settings_provider.dart';
import 'package:zoco/app/utils/enums.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/extentions.dart';
import '../widgets/wishlist_product_widget.dart';
import '../widgets/wishlist_shimmer.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: const CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: 'Wishlist',
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Consumer<SettingsProvider>(
            builder: (context, provider, child) =>
                provider.wishlistData.wishlists?.product?.isEmpty == true
                    ? const NoProductWidget()
                    : provider.getWishlistStatus == GetWishlistStatus.loading
                        ? WishListProductWidgetShimmer(
                            width: Responsive.width * 50,
                          )
                        : provider.getWishlistStatus == GetWishlistStatus.loaded
                            ? GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio:
                                            Responsive.height * 0.090,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 2),
                                itemCount: provider
                                    .wishlistData.wishlists?.product?.length,
                                itemBuilder: (context, index) {
                                  return CommonInkwell(
                                    onTap: () {
                                      context.pushNamed(
                                          AppRouter.productDetailsViewScreen,
                                          queryParameters: {
                                            "productLink": provider.wishlistData
                                                .wishlists?.product?[index].link
                                                .toString()
                                          });
                                    },
                                    child: WishListProductWidget(
                                      width: Responsive.width * 100,
                                      withCart: true,
                                      wishListProduct: provider.wishlistData
                                          .wishlists?.product?[index],
                                    ),
                                  );
                                },
                              )
                            : const SizedBox.shrink(),
          )),
    );
  }
}
