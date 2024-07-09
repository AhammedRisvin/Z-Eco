import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/cart/view%20model/cart_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/extentions.dart';
import 'package:zoco/app/utils/prefferences.dart';

import '../../../theme/theme_provider.dart';
import '../../../utils/enums.dart';
import '../model/get_cart_model.dart';
import '../widget/cartproduct_details_screen.dart';
import '../widget/payment_select_card_widget.dart';
import '../widget/price_details_row.dart';
import '../widget/vuew_cart_shimmer.dart';

class YourCartScreen extends StatefulWidget {
  const YourCartScreen({super.key});

  @override
  State<YourCartScreen> createState() => _YourCartScreenState();
}

class _YourCartScreenState extends State<YourCartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getCartFn();
    context.read<CartProvider>().getAllAddressFnc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        flexibleSpace: const CustomAppBarWidget(
          title: "Your Cart",
          isLeadingIconBorder: true,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Consumer<CartProvider>(
              builder: (context, provider, child) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  child: provider.getCartModel.cartData?.cart?.isEmpty == true
                      ? const NoProductWidget()
                      : provider.getCartStatus == GetCartStatus.loading
                          ? const ViewCartShimmer()
                          : provider.getCartStatus == GetCartStatus.loaded
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var cartData = provider.getCartModel
                                            .cartData?.cart?[index];
                                        return CommonInkwell(
                                          onTap: () {
                                            context.pushNamed(
                                                AppRouter
                                                    .productDetailsViewScreen,
                                                queryParameters: {
                                                  "productLink":
                                                      cartData?.productLink ??
                                                          "",
                                                });
                                          },
                                          child: CartProductDetailsContainer(
                                            singleCartData: cartData,
                                            currency:
                                                provider.getCartModel.currency,
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizeBoxH(Responsive.height * 2),
                                      itemCount: provider.getCartModel.cartData
                                              ?.cart?.length ??
                                          0,
                                    ),
                                    SizeBoxH(Responsive.height * 2),
                                    ViewAvailableOfferWidget(
                                      cartData: provider.getCartModel.cartData,
                                    ),
                                    SizeBoxH(Responsive.height * 4),
                                    CustomTextWidgets(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 15,
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontWeight: FontWeight.w700,
                                            height: 0.12,
                                            letterSpacing: 0.50,
                                          ),
                                      text: "Delivery to : ",
                                    ),
                                    context
                                            .read<CartProvider>()
                                            .slectedAddressList
                                            .id
                                            .isNullOrEmpty()
                                        ? Column(
                                            children: [
                                              SizeBoxH(Responsive.height * 3),
                                              const AddAddressContainer(),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              SizeBoxH(Responsive.height * 4),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    AppImages.checkoutLocation,
                                                    height:
                                                        Responsive.height * 3,
                                                    color: context
                                                            .read<
                                                                ThemeProvider>()
                                                            .isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                  Consumer<CartProvider>(
                                                      builder:
                                                          (context, obj, _) {
                                                    return SizedBox(
                                                      width:
                                                          Responsive.width * 60,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          CustomTextWidgets(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontSize: 13,
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  height: 0.15,
                                                                  letterSpacing:
                                                                      0.50,
                                                                ),
                                                            text:
                                                                obj.slectedAddressList
                                                                        .name ??
                                                                    '',
                                                          ),
                                                          SizeBoxH(Responsive
                                                                  .height *
                                                              1),
                                                          CustomTextWidgets(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  color: const Color(
                                                                      0xFF8390A1),
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                            text:
                                                                "${obj.slectedAddressList.address ?? ''}\n${obj.slectedAddressList.city ?? ''} ${obj.slectedAddressList.pincode ?? ''}  ${obj.slectedAddressList.state ?? ''}",
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                  CommonInkwell(
                                                    onTap: () {
                                                      context
                                                          .read<CartProvider>()
                                                          .getAllAddressFnc();
                                                      context
                                                          .read<CartProvider>()
                                                          .slectaddressIndex(
                                                              value: context
                                                                  .read<
                                                                      CartProvider>()
                                                                  .selectAddres);

                                                      context.pushNamed(
                                                          AppRouter
                                                              .delivertoscreen);
                                                    },
                                                    child: Container(
                                                      width:
                                                          Responsive.width * 18,
                                                      height: 26,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: const Color(
                                                            0xFF2F4EFF),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          CustomTextWidgets(
                                                            text: 'Change',
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color:
                                                                      AppConstants
                                                                          .white,
                                                                  height: 0.15,
                                                                  letterSpacing:
                                                                      0.50,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                    const SizeBoxH(20),
                                    Container(
                                      width: Responsive.width * 100,
                                      height: Responsive.height * 25,
                                      padding: const EdgeInsets.all(10),
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color:
                                                  AppConstants.appBorderColor),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextWidgets(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                            text: "Price Details",
                                          ),
                                          SizeBoxH(Responsive.height * 3),
                                          PriceDetailsRowWidget(
                                            title:
                                                "Items (${provider.getCartModel.cartData?.totalItem ?? 0})",
                                            price:
                                                " ${provider.getCartModel.cartData?.totalPrice?.toStringAsFixed(2) ?? 0} ${provider.getCartModel.currency}",
                                            titleColor:
                                                AppConstants.appMainGreyColor,
                                          ),
                                          SizeBoxH(Responsive.height * 2),
                                          PriceDetailsRowWidget(
                                            title: "Shipping",
                                            price:
                                                "${provider.getCartModel.cartData?.shippingCharge?.toStringAsFixed(2) ?? 0} ${provider.getCartModel.currency}",
                                            titleColor:
                                                AppConstants.appMainGreyColor,
                                          ),
                                          SizeBoxH(Responsive.height * 2),
                                          PriceDetailsRowWidget(
                                            title: "Discount charges",
                                            price:
                                                "${provider.getCartModel.cartData?.totalDiscount?.toStringAsFixed(2) ?? 0} ${provider.getCartModel.currency}",
                                            titleColor:
                                                AppConstants.appMainGreyColor,
                                          ),
                                          SizeBoxH(Responsive.height * 3),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTextWidgets(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'Plus Jakarta Sans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0.12,
                                                    ),
                                                text: "Total Price",
                                              ),
                                              CustomTextWidgets(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: const Color(
                                                          0xFF2F4EFF),
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'Plus Jakarta Sans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0.12,
                                                    ),
                                                text:
                                                    "${provider.getCartModel.cartData?.totalSubTotal?.toStringAsFixed(2) ?? 0} ${provider.getCartModel.currency}",
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizeBoxH(Responsive.height * 2),
                                    CommonButton(
                                      btnName: "Checkout",
                                      ontap: () {
                                        if (context
                                                    .read<CartProvider>()
                                                    .slectedAddressList
                                                    .id !=
                                                null &&
                                            context
                                                    .read<CartProvider>()
                                                    .slectedAddressList
                                                    .id !=
                                                '') {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                ),
                                                width: Responsive.width * 100,
                                                decoration: BoxDecoration(
                                                  color: AppPref.isDark == true
                                                      ? AppConstants
                                                          .containerColor
                                                      : AppConstants.white,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizeBoxH(
                                                        Responsive.height * 2),
                                                    CustomTextWidgets(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                height: 0,
                                                              ),
                                                      text: 'Payment',
                                                    ),
                                                    SizeBoxH(
                                                        Responsive.height * 1),
                                                    if ((provider.getCartModel
                                                                .walletAmount ??
                                                            0) >
                                                        0)
                                                      WalletCardWidget(
                                                        index: 0,
                                                        image: AppImages
                                                            .subWalletBlue,
                                                        title: "Wallet",
                                                        isFromWallet: true,
                                                        walletBalance: provider
                                                            .getCartModel
                                                            .walletAmount
                                                            ?.toInt(),
                                                        totalPrice: provider
                                                                .getCartModel
                                                                .cartData
                                                                ?.totalSubTotal
                                                                ?.toInt() ??
                                                            0,
                                                      ),
                                                    SizeBoxH(
                                                        Responsive.height * 1),
                                                    WalletCardWidget(
                                                      index: 1,
                                                      image: AppImages
                                                          .subPaypalBlue,
                                                      title: "Paypal",
                                                      walletBalance: provider
                                                          .getCartModel
                                                          .walletAmount
                                                          ?.toInt(),
                                                      totalPrice: provider
                                                              .getCartModel
                                                              .cartData
                                                              ?.totalSubTotal
                                                              ?.toInt() ??
                                                          0,
                                                    ),
                                                    SizeBoxH(
                                                        Responsive.height * 1),
                                                    WalletCardWidget(
                                                      index: 2,
                                                      image: AppImages
                                                          .subStripeBlue,
                                                      title: "Stripe",
                                                      walletBalance: provider
                                                          .getCartModel
                                                          .walletAmount
                                                          ?.toInt(),
                                                      totalPrice: provider
                                                              .getCartModel
                                                              .cartData
                                                              ?.totalSubTotal
                                                              ?.toInt() ??
                                                          0,
                                                    ),
                                                    SizeBoxH(
                                                        Responsive.height * 3),
                                                    CommonButton(
                                                      btnName: "Continue",
                                                      ontap: () {
                                                        if (provider.isWalletSelected ==
                                                                true &&
                                                            provider.selectedPaymentIndex ==
                                                                -1) {
                                                          // User selected wallet
                                                          // Check if wallet balance is sufficient
                                                          if ((provider
                                                                      .getCartModel
                                                                      .walletAmount ??
                                                                  0) >=
                                                              (provider
                                                                      .getCartModel
                                                                      .cartData
                                                                      ?.totalSubTotal ??
                                                                  0)) {
                                                            provider
                                                                .walletPaymentFn(
                                                              context: context,
                                                              amount: provider
                                                                      .getCartModel
                                                                      .cartData
                                                                      ?.totalSubTotal
                                                                      .toString() ??
                                                                  "",
                                                              cartId: provider
                                                                      .getCartModel
                                                                      .cartData
                                                                      ?.id
                                                                      .toString() ??
                                                                  "",
                                                            );

                                                            // Pay using wallet
                                                          } else {
                                                            Fluttertoast
                                                                .showToast(
                                                              msg:
                                                                  "Insufficient balance in wallet",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .TOP,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0,
                                                            );
                                                          }
                                                        } else if (provider
                                                                    .selectedPaymentIndex ==
                                                                2 &&
                                                            provider.isWalletSelected ==
                                                                false) {
                                                          provider
                                                              .createStripeFn(
                                                            isWalletApplied:
                                                                "false",
                                                            context: context,
                                                            amount: provider
                                                                    .getCartModel
                                                                    .cartData
                                                                    ?.totalSubTotal
                                                                    .toString() ??
                                                                "",
                                                            cartId: provider
                                                                    .getCartModel
                                                                    .cartData
                                                                    ?.id
                                                                    .toString() ??
                                                                "",
                                                          );
                                                        } else if (provider
                                                                    .selectedPaymentIndex ==
                                                                1 &&
                                                            provider.isWalletSelected ==
                                                                false) {
                                                          provider
                                                              .paypalAmountFn(
                                                            provider
                                                                    .getCartModel
                                                                    .cartData
                                                                    ?.totalSubTotal
                                                                    .toString() ??
                                                                "",
                                                          );

                                                          provider
                                                              .createPaypalFn(
                                                            isWalletApplied:
                                                                "false",
                                                            context: context,
                                                            cartId: provider
                                                                    .getCartModel
                                                                    .cartData
                                                                    ?.id
                                                                    .toString() ??
                                                                "",
                                                          );
                                                        } else if (provider
                                                                    .selectedPaymentIndex ==
                                                                1 &&
                                                            provider.isWalletSelected ==
                                                                true) {
                                                          provider
                                                              .paypalAmountFn(
                                                            provider
                                                                    .getCartModel
                                                                    .cartData
                                                                    ?.totalSubTotal
                                                                    .toString() ??
                                                                "",
                                                          );
                                                          provider
                                                              .createPaypalFn(
                                                            isWalletApplied:
                                                                "true",
                                                            context: context,
                                                            cartId: provider
                                                                    .getCartModel
                                                                    .cartData
                                                                    ?.id
                                                                    .toString() ??
                                                                "",
                                                          );
                                                        } else if (provider
                                                                    .selectedPaymentIndex ==
                                                                2 &&
                                                            provider.isWalletSelected ==
                                                                true) {
                                                          provider
                                                              .createStripeFn(
                                                            isWalletApplied:
                                                                "true",
                                                            context: context,
                                                            amount: provider
                                                                    .getCartModel
                                                                    .cartData
                                                                    ?.totalSubTotal
                                                                    .toString() ??
                                                                "",
                                                            cartId: provider
                                                                    .getCartModel
                                                                    .cartData
                                                                    ?.id
                                                                    .toString() ??
                                                                "",
                                                          );
                                                        } else if (provider
                                                                    .selectedPaymentIndex ==
                                                                -1 &&
                                                            provider.isWalletSelected ==
                                                                false) {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Select any payment method",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .TOP,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0,
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    SizeBoxH(
                                                        Responsive.height * 3),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          toast(context,
                                              backgroundColor: AppConstants.red,
                                              title: 'Please enter address');
                                        }
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                );
              },
            ),
          ),
          Visibility(
            visible: context.watch<CartProvider>().isLoading,
            child: const ViewCartShimmer(),
          ),
        ],
      ),
    );
  }
}

class ViewAvailableOfferWidget extends StatelessWidget {
  final CartData? cartData;
  const ViewAvailableOfferWidget({
    super.key,
    required this.cartData,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: () {
        context
            .pushNamed(
              AppRouter.couponsScreen,
            )
            .whenComplete(() => context.read<CartProvider>().justUpdate());
      },
      child: Container(
        height: Responsive.height * 5.5,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side:
                const BorderSide(width: 1, color: AppConstants.appBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Responsive.width * 60,
              child: Row(
                children: [
                  Image.asset(
                    AppImages.cartOfferIcon,
                    height: Responsive.height * 3.5,
                  ),
                  const SizeBoxV(20),
                  CustomTextWidgets(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w600,
                          height: 0.15,
                          letterSpacing: 0.50,
                        ),
                    text: "View Available Offers",
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF2F4EFF),
            )
          ],
        ),
      ),
    );
  }
}

class CouponTextFieldWidget extends StatelessWidget {
  const CouponTextFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: Responsive.width * 100,
      height: Responsive.height * 7,
      child: CustomTextFormFieldWidget(
        suffix: Container(
          margin: const EdgeInsets.only(right: 8, top: 3, bottom: 3),
          width: Responsive.width * 20,
          height: Responsive.height * 1,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFF2F4EFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextWidgets(
                text: 'Apply',
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppConstants.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 0.15,
                      letterSpacing: 0.50,
                    ),
              ),
            ],
          ),
        ),
        controller: Provider.of<CartProvider>(context, listen: false)
            .couponCodeController,
        hintText: 'Coupon Code',
      ),
    );
  }
}
