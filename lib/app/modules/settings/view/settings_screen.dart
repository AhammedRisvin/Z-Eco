import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/settings/view%20model/settings_provider.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/extentions.dart';
import 'package:zoco/app/utils/prefferences.dart';

import '../../../helpers/common_widgets.dart';
import '../../../theme/theme_provider.dart';
import '../../widgets/view_model/bottom_nav_bar_provider.dart';
import '../model/get_profile_model.dart';
import '../view model/wallet_provider.dart';
import '../widgets/settingsCommonListTile.dart';
import '../widgets/settings_wishlist_common_container.dart';
import 'change_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsProvider? settingsProvider;
  @override
  void initState() {
    super.initState();
    settingsProvider = context.read<SettingsProvider>();
    settingsProvider?.getProfileFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: Responsive.width * 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizeBoxH(60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidgets(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                    text: 'Settings',
                  ),
                  Consumer<ThemeProvider>(
                    builder: (context, valueP, child) => SizedBox(
                      height: 10,
                      child: Switch(
                        value: valueP.isDarkMode,
                        onChanged: (value) {
                          valueP.toggleTheme(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizeBoxH(Responsive.height * 4),
              Selector<SettingsProvider, GetProfileModel>(
                selector: (p0, p1) => p1.getProfileData,
                builder: (context, profileData, child) => Container(
                  height: Responsive.height * 10,
                  width: Responsive.height * 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xffDCE5F2),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizeBoxV(Responsive.width * 2),
                      CachedImageWidget(
                        imageUrl: profileData.profile?.profilePicture ?? '',
                        height: 63,
                        width: 63,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      SizeBoxV(Responsive.width * 2),
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidgets(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                              text: profileData.profile?.name ?? '',
                            ),
                            CustomTextWidgets(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                              text: profileData.profile?.email ?? '',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizeBoxH(Responsive.height * 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SettingsWishlistCommonContainer(
                    width: Responsive.width * 45.5,
                    image: AppImages.wishlist,
                    title: 'Wishlist',
                    onTap: () {
                      settingsProvider?.getWishlistFn();
                      context.pushNamed(AppRouter.wishlistScreen);
                    },
                  ),
                  SettingsWishlistCommonContainer(
                    width: Responsive.width * 45.5,
                    image: AppImages.wallet,
                    title: 'Wallet',
                    onTap: () {
                      context.read<WalletProvider>().addAmountToWalletFn(true);
                      context.pushNamed(AppRouter.walletAddScreen);
                    },
                  ),
                ],
              ),
              SizeBoxH(Responsive.height * 1),
              SettingsWishlistCommonContainer(
                width: Responsive.width * 100,
                image: AppImages.helpCentre,
                title: 'Help center',
                onTap: () {},
                mainAxis: MainAxisAlignment.center,
              ),
              SizeBoxH(Responsive.height * 4),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                text: 'Account settings',
              ),
              SizeBoxH(Responsive.height * 2),
              SettingsCommonListTile(
                image: AppImages.profileSettings,
                title: 'Profile settings',
                onTap: () {
                  context.pushNamed(AppRouter.profileSettingsScreen);
                },
              ),
              SizeBoxH(Responsive.height * 2),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                text: 'Contact us',
              ),
              SizeBoxH(Responsive.height * 2),
              CommonInkwell(
                onTap: () {
                  settingsProvider?.makePhoneCall();
                },
                child: SizedBox(
                  height: Responsive.height * 6,
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.callPhone,
                        height: 20,
                        color: context.watch<ThemeProvider>().isDarkMode == true
                            ? const Color(0xffffffff)
                            : const Color.fromARGB(190, 3, 3, 3),
                      ),
                      SizeBoxV(Responsive.width * 2),
                      Selector<SettingsProvider, GetProfileModel>(
                        selector: (p0, p1) => p1.getProfileData,
                        builder: (context, value, child) => CustomTextWidgets(
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                          text: "+918921633521",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CommonInkwell(
                onTap: () {
                  settingsProvider?.makeEmail();
                },
                child: SizedBox(
                  height: Responsive.height * 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppImages.mailExample,
                        height: 20,
                        color: context.watch<ThemeProvider>().isDarkMode == true
                            ? const Color(0xffffffff)
                            : const Color.fromARGB(220, 0, 0, 0),
                      ),
                      SizeBoxV(Responsive.width * 2),
                      Selector<SettingsProvider, GetProfileModel>(
                        selector: (p0, p1) => p1.getProfileData,
                        builder: (context, value, child) => CustomTextWidgets(
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                          text: "contact@zoco.com",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizeBoxH(Responsive.height * 4),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                text: 'Feedback & information',
              ),
              SizeBoxH(Responsive.height * 2),
              SettingsCommonListTile(
                image: AppImages.termsAndConditions,
                title: 'Terms & Conditions',
                onTap: () {},
                imageHeight: 22,
                isTrailingShow: false,
              ),
              SettingsCommonListTile(
                image: AppImages.browseFAQs,
                title: 'Browse FAQ’s',
                onTap: () {},
                imageHeight: 22,
                isTrailingShow: false,
              ),
              SettingsCommonListTile(
                image: AppImages.deleteAccount,
                title: 'Delete Account',
                isDeleteAccount: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        cancel: () => context.pop(),
                        ok: () {
                          settingsProvider?.deleteAccountFn(context);
                        },
                        heading: 'Delete Account?',
                        bodyText:
                            'Are you sure want to delete your Account?\nThis action cannot be undone.',
                        isOkButtonColorRed: true,
                      );
                    },
                  );
                },
                imageHeight: 22,
                isTrailingShow: false,
              ),
              SizeBoxH(Responsive.height * 2),
              Align(
                alignment: Alignment.center,
                child: CustomTextWidgets(
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                  text: 'About app',
                ),
              ),
              SizeBoxH(Responsive.height * 2),
              Align(
                alignment: Alignment.center,
                child: FutureBuilder<String>(
                  future: Provider.of<SettingsProvider>(context, listen: false)
                      .getAppVersion(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return CustomTextWidgets(
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                          text: '',
                        );
                      }
                      return CustomTextWidgets(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                        text: snapshot.data!,
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
              SizeBoxH(Responsive.height * 4),
              CommonButton(
                btnName: "Logout",
                ontap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        cancel: () => context.pop(),
                        ok: () {
                          AppPref.isSignedIn = false;
                          AppPref.userToken = '';
                          context.read<BottomBarProvider>().selectedIndex = 0;
                          context.goNamed(AppRouter.login);
                        },
                        heading: 'Logout?',
                        bodyText:
                            'Are you sure want to Logout\nfrom your Account?',
                        isOkButtonColorRed: true,
                      );
                    },
                  );
                },
                bgColor: const Color(0xffEB000E),
              ),
              SizeBoxH(Responsive.height * 4),
            ],
          ),
        ),
      ),
    );
  }
}
