import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/app_constants.dart';
import '../view_model/flicks_controller.dart';

class SubscriptionPaymentSelectListTileWidget extends StatelessWidget {
  final String image;
  final String title;
  final int index;
  final bool isFromWallet;
  final num walletBalance;
  final num amount;

  const SubscriptionPaymentSelectListTileWidget({
    super.key,
    required this.image,
    required this.title,
    required this.index,
    this.isFromWallet = false,
    required this.walletBalance,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final flicksProvider = Provider.of<FlicksController>(context);

    return ListTile(
      leading: Image.asset(
        image,
        height: 30,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
            ),
          ),
        ],
      ),
      trailing: CircleAvatar(
        backgroundColor: AppConstants.appPrimaryColor,
        radius: 12,
        child: CircleAvatar(
          backgroundColor: AppConstants.white,
          radius: 9,
          child: CircleAvatar(
            backgroundColor: isFromWallet
                ? flicksProvider.isWalletSelected
                    ? const Color(0xff2F4EFF)
                    : const Color(0xffffffff)
                : flicksProvider.selectedPaymentIndex == index
                    ? const Color(0xff2F4EFF)
                    : const Color(0xffffffff),
            radius: 7,
          ),
        ),
      ),
      onTap: () {
        if (isFromWallet) {
          flicksProvider.selectWalletFn();
        } else if (walletBalance >= amount) {
          toast(
            context,
            title:
                "You have enough balance in wallet alone, pay with your wallet",
            backgroundColor: Colors.red,
          );
        } else {
          flicksProvider.setSelectedPaymentIndex(index);
        }
      },
    );
  }
}
