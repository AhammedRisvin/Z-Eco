import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/flicks/view_model/flicks_controller.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/app_images.dart';
import '../../../utils/prefferences.dart';
import '../widgets/sub_payment_select_widget.dart';

class FlicksPaymentScreen extends StatefulWidget {
  const FlicksPaymentScreen({super.key});

  @override
  State<FlicksPaymentScreen> createState() => _FlicksPaymentScreenState();
}

class _FlicksPaymentScreenState extends State<FlicksPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: const CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: 'Payment Method',
        ),
      ),
      body: Container(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        padding: const EdgeInsets.all(20),
        child: Consumer<FlicksController>(
          builder: (context, provider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                text: 'Plan',
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                width: Responsive.width * 100,
                height: Responsive.height * 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/darkBlueRectangle.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: Responsive.width * 10,
                      height: Responsive.height * 3,
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      decoration: ShapeDecoration(
                        color: AppConstants.appPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          provider.membershipPlan?.offer.toString() ?? '',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                        ),
                      ),
                    ),
                    CustomTextWidgets(
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 25,
                                color: AppConstants.white,
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                      text: provider.membershipPlan?.name ?? '',
                    ),
                    const SizeBoxH(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${provider.membershipPlan?.currency ?? ''} ${provider.membershipPlan?.amount ?? ''}',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                        ),
                        const SizedBox(width: 3),
                        Opacity(
                          opacity: 0.80,
                          child: Text(
                            '/ user',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizeBoxH(15),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width * 12),
                      child: const Divider(
                        thickness: 1,
                        color: Color(0xff172159),
                      ),
                    ),
                    const SizeBoxH(10),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          provider.membershipPlan?.description?.length ?? 0,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          SizeBoxH(Responsive.height * 1),
                      itemBuilder: (context, index2) {
                        var descriptionData =
                            provider.membershipPlan?.description?[index2];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.tickImage,
                              height: 30,
                            ),
                            const SizeBoxV(8),
                            SizedBox(
                              width: Responsive.width * 60,
                              child: Text(
                                descriptionData ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                text: 'Payment Methods',
              ),
              const SizeBoxH(20),
              Container(
                height: Responsive.height * 25,
                width: Responsive.width * 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppPref.isDark == true
                      ? AppConstants.containerColor
                      : AppConstants.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SubscriptionPaymentSelectListTileWidget(
                      image: AppImages.subWalletBlue,
                      title:
                          'Wallet  balance ${provider.getFlicksSubscriptionModel.walletAmount?.toStringAsFixed(2)}',
                      isFromWallet: true,
                      index: 0,
                      walletBalance:
                          provider.getFlicksSubscriptionModel.walletAmount ?? 0,
                      amount: provider.membershipPlan?.amount ?? 0,
                    ),
                    SubscriptionPaymentSelectListTileWidget(
                      image: AppImages.subPaypalBlue,
                      title: 'Paypal',
                      index: 1,
                      walletBalance:
                          provider.getFlicksSubscriptionModel.walletAmount ?? 0,
                      amount: provider.membershipPlan?.amount ?? 0,
                    ),
                    SubscriptionPaymentSelectListTileWidget(
                      image: AppImages.subStripeBlue,
                      title: 'Stripe',
                      index: 2,
                      walletBalance:
                          provider.getFlicksSubscriptionModel.walletAmount ?? 0,
                      amount: provider.membershipPlan?.amount ?? 0,
                    ),
                  ],
                ),
              ),
              const SizeBoxH(20),
              CommonButton(
                btnName: "Place Order",
                ontap: () {
                  if (provider.selectedPaymentIndex == -1 &&
                      provider.isWalletSelected == true) {
                    if ((provider.getFlicksSubscriptionModel.walletAmount ??
                            0) >=
                        (provider.membershipPlan?.amount ?? 0)) {
                      provider.flicksWalletPaymentFn(
                          context: context,
                          isDownloadable:
                              provider.membershipPlan?.isDownloadable,
                          amount:
                              provider.membershipPlan?.amount.toString() ?? "",
                          plan: provider.membershipPlan?.id ?? "");
                      // Pay using wallet
                    } else {
                      toast(
                        context,
                        title: "Insufficient balance in wallet",
                        backgroundColor: Colors.red,
                      );
                    }
                  } else if (provider.selectedPaymentIndex == 1 &&
                      provider.isWalletSelected == false) {
                    provider.amountAndPlanIdFn(
                      amount: provider.membershipPlan?.amount.toString() ?? "",
                      planId: provider.membershipPlan?.id ?? "",
                    );
                    provider.createPaypalFn(
                      isWalletApplied: "false",
                      context: context,
                      amount: provider.membershipPlan?.amount.toString() ?? "",
                    );
                  } else if (provider.selectedPaymentIndex == 1 &&
                      provider.isWalletSelected == true) {
                    provider.amountAndPlanIdFn(
                      amount: provider.membershipPlan?.amount.toString() ?? "",
                      planId: provider.membershipPlan?.id ?? "",
                    );
                    provider.createPaypalFn(
                      isWalletApplied: "true",
                      context: context,
                      amount: provider.membershipPlan?.amount.toString() ?? "",
                    );
                  } else if (provider.selectedPaymentIndex == 2 &&
                      provider.isWalletSelected == false) {
                    provider.amountAndPlanIdFn(
                      amount: provider.membershipPlan?.amount.toString() ?? "",
                      planId: provider.membershipPlan?.id ?? "",
                    );
                    provider.createStripeFn(
                      isWalletApplied: "false",
                      context: context,
                      amount: provider.membershipPlan?.amount.toString() ?? "",
                    );
                  } else if (provider.selectedPaymentIndex == 2 &&
                      provider.isWalletSelected == true) {
                    provider.amountAndPlanIdFn(
                      amount: provider.membershipPlan?.amount.toString() ?? "",
                      planId: provider.membershipPlan?.id ?? "",
                    );
                    provider.createStripeFn(
                      isWalletApplied: "true",
                      context: context,
                      amount: provider.membershipPlan?.amount.toString() ?? "",
                    );
                  } else if (provider.selectedPaymentIndex == -1 &&
                      provider.isWalletSelected == false) {
                    toast(
                      context,
                      title: "Select any payment option",
                      backgroundColor: Colors.red,
                    );
                  } else if ((provider.getFlicksSubscriptionModel
                                      .walletAmount ??
                                  0) >=
                              (provider.membershipPlan?.amount ?? 0) &&
                          provider.selectedPaymentIndex == 2 ||
                      provider.selectedPaymentIndex == 1) {
                    toast(
                      context,
                      title:
                          "you have enough balance in wallet alone no need to select another payment option",
                      backgroundColor: Colors.red,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
