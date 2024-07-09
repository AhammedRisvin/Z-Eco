import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/home/view_model/home_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_images.dart';
import '../../cart/view model/cart_provider.dart';

class ProductSearchAndCartWidget extends StatelessWidget {
  final double padding;
  final void Function()? onTap;
  final double? width;
  final bool readOnly;
  final bool isFromFilter;
  final void Function(String)? onChange;
  final bool? isSignedIn;

  const ProductSearchAndCartWidget(
      {super.key,
      this.onTap,
      required this.width,
      this.isFromFilter = false,
      this.onChange,
      this.padding = 12,
      this.readOnly = false,
      this.isSignedIn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isFromFilter ? const EdgeInsets.all(0) : EdgeInsets.all(padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width,
            height: 44,
            child: TextField(
              readOnly: readOnly,
              controller:
                  context.read<HomeProvider>().searchTextEditingController,
              onChanged: onChange,
              onTap: onTap,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search here ...',
              ),
            ),
          ),
          const SizeBoxV(5),
          isFromFilter == true
              ? const SizedBox.shrink()
              : CommonInkwell(
                  onTap: isSignedIn == false
                      ? () {
                          toast(
                            context,
                            title: 'Please login to view cart',
                            backgroundColor: Colors.red,
                          );
                          context.pushReplacementNamed(AppRouter.login);
                        }
                      : () {
                          context.read<CartProvider>().getCartFn();
                          context.pushNamed(AppRouter.yourcartscreen);
                        },
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFDCE4F2)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AppImages.cartIcon,
                        color: context.watch<ThemeProvider>().isDarkMode
                            ? Colors.white
                            : AppConstants.black,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
