import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/settings/view%20model/wallet_provider.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../../helpers/common_widgets.dart';
import '../../../../helpers/router.dart';
import '../../../../theme/theme_provider.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../model/wallet_history_model.dart';

class WalletAddScreen extends StatefulWidget {
  const WalletAddScreen({super.key});

  @override
  State<WalletAddScreen> createState() => _WalletAddScreenState();
}

class _WalletAddScreenState extends State<WalletAddScreen> {
  WalletProvider? walletProvider;
  @override
  void initState() {
    super.initState();
    walletProvider = context.read<WalletProvider>();
    walletProvider?.getWalletHistoryFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(AppRouter.walletHistoryScreen);
              context.read<WalletProvider>().getWalletHistoryFn();
            },
            icon: Icon(
              Icons.history_toggle_off,
              size: 26,
              color: context.watch<ThemeProvider>().isDarkMode == true
                  ? AppConstants.white
                  : AppConstants.black,
            ),
          ),
          const SizeBoxV(5)
        ],
        flexibleSpace: CustomAppBarWidget(
          isLeadingIconBorder: true,
          onTap: () {
            walletProvider?.setSelectedIndex(-1);
            context.pop();
          },
          title: 'Wallet',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeBoxH(Responsive.height * 2),
              Selector<WalletProvider, GetWalletHistoryModel>(
                selector: (p0, p1) => p1.getWalletHistoryModel,
                builder: (context, value, child) => CustomTextWidgets(
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                  text:
                      'Balance :  ${value.currencyCode} ${value.walletAmount?.toStringAsFixed(2)}',
                ),
              ),
              SizeBoxH(Responsive.height * 4),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                text: 'Amount',
              ),
              SizeBoxH(Responsive.height * 2),
              CustomTextFormFieldWidget(
                keyboardType: TextInputType.number,
                controller: walletProvider?.enterAmountController,
                hintText: "Enter Amount",
              ),
              SizeBoxH(Responsive.height * 4),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                text: 'Pay with',
              ),
              SizeBoxH(Responsive.height * 4),
              walletProvider?.addAmountToWallet == false
                  ? WalletCardWidget(
                      index: 0,
                      image: AppImages.blueWallet,
                      title: "Wallet",
                    )
                  : const SizedBox.shrink(),
              walletProvider?.addAmountToWallet == false
                  ? SizeBoxH(Responsive.height * 3)
                  : const SizedBox.shrink(),
              WalletCardWidget(
                index: 1,
                image: AppImages.bluePaypal,
                title: "Paypal",
              ),
              SizeBoxH(Responsive.height * 3),
              WalletCardWidget(
                index: 2,
                image: AppImages.blueStripe,
                title: "Stripe",
              ),
              SizeBoxH(Responsive.height * 3),
              CommonButton(
                btnName: "Continue",
                ontap: () {
                  if (walletProvider?.selectedPaymentIndex == 2 &&
                      (walletProvider?.enterAmountController.text.isNotEmpty ??
                          false)) {
                    walletProvider?.createStripeFn(context: context);
                  } else if (walletProvider?.selectedPaymentIndex == 1 &&
                      (walletProvider?.enterAmountController.text.isNotEmpty ??
                          false)) {
                    walletProvider?.createPaypalFn(context: context);
                  } else if (walletProvider
                          ?.enterAmountController.text.isEmpty ??
                      true) {
                    toast(context,
                        title: 'Please enter amount',
                        backgroundColor: Colors.red);
                  } else if (walletProvider?.selectedPaymentIndex == -1) {
                    toast(context,
                        title: 'Choose any payment method',
                        backgroundColor: Colors.red);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WalletCardWidget extends StatelessWidget {
  final String image;
  final String title;

  final int index;
  const WalletCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: context.watch<ThemeProvider>().isDarkMode == true
            ? AppConstants.containerColor
            : const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: context.watch<ThemeProvider>().isDarkMode == true
                ? Colors.transparent
                : Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        splashColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: Image.asset(
          image,
          height: 20,
        ),
        title: CustomTextWidgets(
          text: title,
          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 18,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w500,
              ),
        ),
        trailing: CircleAvatar(
          backgroundColor: const Color(0xff2F4EFF),
          radius: Responsive.height * 1.3,
          child: CircleAvatar(
            backgroundColor: const Color(0xffffffff),
            radius: Responsive.height * 1,
            child: CircleAvatar(
              backgroundColor: walletProvider.selectedPaymentIndex == index
                  ? const Color(0xff2F4EFF)
                  : const Color(0xffffffff),
              radius: Responsive.height * 0.7,
            ),
          ),
        ),
        onTap: () {
          walletProvider.setSelectedIndex(index);
        },
      ),
    );
  }
}
