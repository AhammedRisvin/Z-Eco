import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoco/app/modules/settings/model/coupons_model.dart';
import 'package:zoco/app/modules/settings/view%20model/settings_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/enums.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../theme/theme_provider.dart';
import '../../cart/view model/cart_provider.dart';
import '../../widgets/view/empty_screen.dart';
import 'ticket_painter.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({
    super.key,
  });

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  @override
  void initState() {
    super.initState();
    String cartId = context.read<CartProvider>().getCartModel.cartData?.id ??
        ""; // get cart id
    context
        .read<SettingsProvider>()
        .getCouponsFn(context: context, cartId: cartId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().isDarkMode == true
          ? const Color(0x33333333)
          : const Color(0xffF2F2F8),
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: const CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: 'Available Offers',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<SettingsProvider>(
                builder: (context, provider, child) => provider
                            .getCouponsData.coupons?.isEmpty ==
                        true
                    ? EmptyScreenWidget(
                        height: Responsive.height * 100,
                        image: AppImages.dealsNoData,
                        text: 'No coupons available for this cart product',
                      )
                    : provider.getCouponsStatus == GetCouponsStatus.loading
                        ? const ShimmerContainer()
                        : provider.getCouponsStatus == GetCouponsStatus.loaded
                            ? ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var couponsData =
                                      provider.getCouponsData.coupons?[(provider
                                                  .getCouponsData
                                                  .coupons
                                                  ?.length ??
                                              0) -
                                          1 -
                                          index];
                                  return couponsData?.isAvailable == false
                                      ? CouponWidget(
                                          isCouponExpired: true,
                                          couponsData: couponsData,
                                          provider: provider,
                                          onTap: () {
                                            toast(
                                              context,
                                              backgroundColor: Colors.red,
                                              title:
                                                  "Coupon is not available for this cart product",
                                            );
                                          },
                                        )
                                      : CouponWidget(
                                          couponsData: couponsData,
                                          provider: provider,
                                          onTap: () {
                                            provider.applyCouponCodeFn(
                                              cartId: context
                                                      .read<CartProvider>()
                                                      .getCartModel
                                                      .cartData
                                                      ?.id ??
                                                  "",
                                              couponId: couponsData?.id ?? "",
                                              context: context,
                                            );
                                          },
                                        );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizeBoxH(15),
                                itemCount:
                                    provider.getCouponsData.coupons?.length ??
                                        0,
                              )
                            : const SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CouponWidget extends StatelessWidget {
  const CouponWidget({
    super.key,
    required this.couponsData,
    required this.provider,
    required this.onTap,
    this.isCouponExpired = false,
  });

  final Coupon? couponsData;
  final SettingsProvider? provider;
  final void Function() onTap;
  final bool isCouponExpired;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.width * 100,
      child: CustomPaint(
        painter: TicketPainter(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.width * 8.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeBoxH(Responsive.height * 2),
                  CustomTextWidgets(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 0,
                          color: context.read<ThemeProvider>().isDarkMode
                              ? isCouponExpired
                                  ? const Color(0xff8391A1)
                                  : AppConstants.white
                              : const Color(0xff8391A1),
                        ),
                    text: couponsData?.name ?? "",
                  ),
                  SizeBoxH(Responsive.height * 2),
                  CustomTextWidgets(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 0,
                          color: const Color(0xff8391A1),
                        ),
                    maxLines: 20,
                    text: couponsData?.description ?? "",
                  ),
                  SizeBoxH(Responsive.height * 1.5),
                  Row(
                    children: [
                      Image.asset(
                        AppImages.couponShape,
                        height: 25,
                      ),
                      SizeBoxV(Responsive.width * 2),
                      Expanded(
                        child: CustomTextWidgets(
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                    letterSpacing: -0.3,
                                    color: isCouponExpired
                                        ? const Color(0xff8391A1)
                                        : const Color(0xff2F4EFF),
                                  ),
                          maxLines: 2,
                          text: couponsData?.discountType?.toLowerCase() ==
                                  "price"
                              ? 'Get ${provider?.returnOfferPercentageFn(discountPrice: couponsData?.discount?.toInt() ?? 0, totalPrice: couponsData?.minPrice?.toInt() ?? 0)}% OFF max upto ${couponsData?.discount ?? 0} Rs'
                              : "Get ${couponsData?.discount} % OFF purchase above  ${couponsData?.minPrice ?? 0} Rs",
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizeBoxH(Responsive.height * 2),
            CommonInkwell(
              onTap: onTap,
              child: Container(
                height: Responsive.height * 5.5,
                width: Responsive.width * 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: isCouponExpired
                      ? const Color(0xffF2F2F2)
                      : const Color(0xff2F4EFF),
                ),
                child: Center(
                  child: CustomTextWidgets(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 0,
                          color: isCouponExpired
                              ? const Color(0xff8391A1)
                              : AppConstants.white,
                        ),
                    text: 'APPLY CODE',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.height * 20,
      width: Responsive.width * 100,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Container(
                width: 100,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
