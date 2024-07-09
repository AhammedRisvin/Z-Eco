import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/modules/home/view_model/home_provider.dart';
import 'package:zoco/app/modules/notification/view%20model/notificaion_provider.dart';
import 'package:zoco/app/modules/settings/view%20model/wallet_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extentions.dart';
import '../../../utils/prefferences.dart';
import 'product_search_and_cart_widget.dart';

class HomeScreenAppBarWidget extends StatelessWidget {
  final bool isSignedIn;
  const HomeScreenAppBarWidget({
    super.key,
    required this.isSignedIn,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<HomeProvider>(builder: (context, obj, _) {
        return Column(
          children: [
            //AppBar First row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 35,
                  width: 120,
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    left: 12,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: AssetImage(
                        AppPref.isDark
                            ? AppImages.blackzoco
                            : AppImages.appLogo,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),

                ),
                SizedBox(
                  child: Row(
                    children: [
                      if (isSignedIn)
                        IconButton(
                            onPressed: () {
                              context
                                  .read<WalletProvider>()
                                  .addAmountToWalletFn(true);
                              context.pushNamed(
                                AppRouter.walletAddScreen,
                              );
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                  color: AppPref.isDark == true
                                      ? AppConstants.containerColor
                                      : AppConstants.white,
                                  border: Border.all(
                                      color: AppPref.isDark == true
                                          ? Colors.transparent
                                          : AppConstants.appBorderColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  AppImages.walletAdd,
                                  color: Theme.of(context).primaryColorDark,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            )),
                      IconButton(
                          onPressed: () {
                            context
                                .read<NotificationProvider>()
                                .getNotificationFnc();
                            context.pushNamed(AppRouter.notification);
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                                color: AppPref.isDark == true
                                    ? AppConstants.containerColor
                                    : AppConstants.white,
                                border: Border.all(
                                    color: AppPref.isDark == true
                                        ? Colors.transparent
                                        : AppConstants.appBorderColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                AppImages.bell,
                                height: 24,
                                color: Theme.of(context).primaryColorDark,
                                width: 24,
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
            //search
            ProductSearchAndCartWidget(
              readOnly: true,
              isSignedIn: isSignedIn,
              width: Responsive.width * 78,
              onTap: () {
                context.pushNamed(
                  AppRouter.productSearchScreen,
                );
                FocusScope.of(context).unfocus();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFDCE4F2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  width: Responsive.width * 100,
                  height: 32,
                  child: CommonInkwell(
                    onTap: () => bottomSheet(context: context),
                  child: Row(
                      children: [
                        const SizeBoxV(10),
                        Image.asset(
                          AppImages.locationIcon,
                          height: 18,
                          fit: BoxFit.fill,
                          width: 18,
                        ),
                        const SizeBoxV(10),
                        Expanded(
                        child: CustomTextWidgets(
                            overflow: TextOverflow.ellipsis,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: const Color(0xFF8390A1),
                                  fontSize: 12,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                            text:
                                '${obj.subLocality}${obj.street} ${obj.state}',
                          ),
                        ),
                        const SizeBoxV(20),
                        Image.asset(
                          AppImages.arrowDownIcon,
                          height: 18,
                          width: 18,
                        ),
                        const SizeBoxV(10),
                      ],
                    ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

Future bottomSheet({required BuildContext context}) async {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizeBoxH(Responsive.height * 3),
            CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w500,
                    ),
                text: 'Choose your Location'),
            SizeBoxH(Responsive.height * 0.8),
            CustomTextWidgets(
                overflow: TextOverflow.clip,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 13,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w400,
                    ),
                text:
                    'Select a Delivery location to see product availability and delivery options'),
            SizeBoxH(Responsive.height * 2.8),
            CommonInkwell(
              onTap: () => bottomSheetTwo(context: context),
              child: Row(
                children: [
                  Image.asset(
                    AppImages.locationIcon,
                    height: 18,
                    fit: BoxFit.fill,
                    width: 18,
                    color: const Color(0xff2F4EFF),
                  ),
                  SizeBoxV(Responsive.width * 1),
                  CustomTextWidgets(
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 17,
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w400,
                              ),
                      text: 'Enter a Zipcode'),
                ],
              ),
            ),
            SizeBoxH(Responsive.height * 2.8),
            CommonInkwell(
              onTap: () {
                context.read<HomeProvider>().getLocation();
                context.pop();
              },
              child: Row(
                children: [
                  Image.asset(
                    AppImages.currentLocationImage,
                    height: 18,
                    fit: BoxFit.fill,
                    width: 18,
                  ),
                  SizeBoxV(Responsive.width * 1),
                  CustomTextWidgets(
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 17,
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w400,
                              ),
                      text: 'Use my current location'),
                ],
              ),
            ),
            SizeBoxH(Responsive.height * 3.8),
          ],
        ),
      );
    },
  );
}

Future bottomSheetTwo({required BuildContext context}) async {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(
            right: 16,
            left: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizeBoxH(Responsive.height * 7),
            TextField(
              controller: context.read<HomeProvider>().zipcodeController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImageIcon(
                    AssetImage(AppImages.locationIcon),
                    color: const Color(0xff2F4EFF),
                    size: 1,
                  ),
                ),
                hintText: 'Enter a Zipcode',
              ),
            ),
            SizeBoxH(Responsive.height * 1.4),
            CommonInkwell(
              onTap: () {
                context.read<HomeProvider>().getZipCodeLocation();
                context.pop();
                context.pop();
              },
              child: Container(
                width: Responsive.width * 100,
                height: Responsive.height * 6,
                decoration: const BoxDecoration(
                  color: Color(0xff2F4EFF),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: CustomTextWidgets(
                  text: 'Apply',
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans'),
                ),
              ),
            ),
            SizeBoxH(Responsive.height * 3.8),
          ],
        ),
      );
    },
  );
}
