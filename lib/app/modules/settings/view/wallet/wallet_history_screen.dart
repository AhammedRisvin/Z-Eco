import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/settings/model/wallet_history_model.dart';
import 'package:zoco/app/modules/settings/view%20model/wallet_provider.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../../helpers/common_widgets.dart';
import '../../../../theme/theme_provider.dart';
import '../../../../utils/app_constants.dart';

class WalletHistoryScreen extends StatelessWidget {
  const WalletHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: const CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: 'Wallet History',
        ),
      ),
      body: Selector<WalletProvider, GetWalletHistoryModel>(
        selector: (p0, p1) => p1.getWalletHistoryModel,
        builder: (context, value, child) => value.walletData!.isEmpty
            ? Center(
                child: Image.asset(
                  AppImages.noProductImage,
                  fit: BoxFit.fill,
                  height: Responsive.height * 25,
                  width: Responsive.width * 40,
                ),
              )
            : ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                itemBuilder: (context, index) {
                  var history = value.walletData?[index];
                  return Container(
                    height: Responsive.height * 12,
                    width: Responsive.width * 100,
                    padding:
                        EdgeInsets.symmetric(horizontal: Responsive.width * 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: context.watch<ThemeProvider>().isDarkMode == true
                          ? AppConstants.containerColor
                          : const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color:
                              context.watch<ThemeProvider>().isDarkMode == true
                                  ? Colors.transparent
                                  : Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.historyBag,
                          height: Responsive.height * 8,
                        ),
                        SizeBoxV(Responsive.width * 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextWidgets(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                              text:
                                  'Order #${history?.id!.substring(history.id!.length - 6) ?? ''}',
                            ),
                            const SizeBoxH(6),
                            CustomTextWidgets(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                      color: const Color(0xff8391A1)),
                              text: context
                                  .watch<WalletProvider>()
                                  .convertUtcToLocalDateTime(
                                      history!.createdAt.toString()),
                            ),
                          ],
                        ),
                        const Spacer(),
                        CustomTextWidgets(
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                    color: history.method == "Recharge" ||
                                            history.method == "Refund"
                                        ? Colors.green
                                        : const Color(0xffDD4F4F),
                                  ),
                          text:
                              '${history.method == "Recharge" || history.method == "Refund" ? '+${history.currency}' : '-${history.currency}'}${history.amount?.toStringAsFixed(2) ?? 0}',
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizeBoxH(15),
                itemCount: value.walletData?.length ?? 0,
              ),
      ),
    );
  }
}
