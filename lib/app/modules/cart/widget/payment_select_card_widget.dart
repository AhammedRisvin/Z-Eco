import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/extentions.dart';
import '../view model/cart_provider.dart';

class WalletCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final int? walletBalance;
  final int? totalPrice;
  final bool isFromWallet;

  final int index;
  const WalletCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.index,
    this.walletBalance,
    this.isFromWallet = false,
    this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return ListTile(
      splashColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Image.asset(
        image,
        height: 30,
      ),
      title: Row(
        children: [
          CustomTextWidgets(
            text: title,
            textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 18,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizeBoxV(20),
          isFromWallet
              ? CustomTextWidgets(
                  text: "Balance : ${walletBalance ?? ""}",
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 12,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w500,
                      ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      trailing: CircleAvatar(
        backgroundColor: const Color(0xff2F4EFF),
        radius: Responsive.height * 1.3,
        child: CircleAvatar(
          backgroundColor: const Color(0xffffffff),
          radius: Responsive.height * 1,
          child: CircleAvatar(
            backgroundColor: isFromWallet
                ? cartProvider.isWalletSelected
                    ? const Color(0xff2F4EFF)
                    : const Color(0xffffffff)
                : cartProvider.selectedPaymentIndexList.contains(index)
                    ? const Color(0xff2F4EFF)
                    : const Color(0xffffffff),
            radius: Responsive.height * 0.7,
          ),
        ),
      ),
      onTap: isFromWallet
          ? () {
              cartProvider.selectWalletFn(
                index,
                walletBalance: walletBalance ?? 0,
                totalPrice: totalPrice ?? 0,
              );
            }
          : (walletBalance ?? 0) < (totalPrice ?? 0)
              ? () {
                  cartProvider.setSelectedIndex(
                    index,
                    walletAmount: walletBalance ?? 0,
                    totalPrice: totalPrice ?? 0,
                  );
                }
              : () {
                  cartProvider.setSelectedIndex(
                    index,
                    walletAmount: walletBalance ?? 0,
                    totalPrice: totalPrice ?? 0,
                  );
                },
    );
  }
}
