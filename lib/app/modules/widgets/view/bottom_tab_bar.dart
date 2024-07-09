import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/flicks/view_model/flicks_controller.dart';
import 'package:zoco/app/theme/theme_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/prefferences.dart';
import '../../home/view_model/home_provider.dart';
import '../../vibes/view_model/vibes_provider.dart';
import '../view_model/bottom_nav_bar_provider.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  late bool isSignedIn;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<HomeProvider>().determinePosition(context: context);
    });

    isSignedIn = AppPref.isSignedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomBarProvider>(
        builder: (context, value, child) => Center(
          child: value.widgetOptions.elementAt(value.selectedIndex),
        ),
      ),
      bottomNavigationBar: Card(
        color: context.watch<ThemeProvider>().isDarkMode
            ? AppConstants.darkbg
            : AppConstants.white,
        margin: const EdgeInsets.all(0),
        surfaceTintColor: Colors.transparent,
        shadowColor: AppConstants.appBorderColor,
        elevation: 2,
        shape: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.zero)),
        child: Container(
            height: 80,
            width: Responsive.width * 100,
            decoration: const BoxDecoration(),
            child: Consumer<BottomBarProvider>(
              builder: (context, value, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      value.onItemTapped(index: 0);
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: value.selectedIndex == 0
                                  ? BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 4,
                                      style: BorderStyle.solid)
                                  : BorderSide.none)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          value.selectedIndex == 0
                              ? Image.asset(
                                  AppImages.homebold,
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  AppImages.homelinear,
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.fill,
                                ),
                          const SizeBoxH(5),
                          CustomTextWidgets(
                            text: 'Home',
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: value.selectedIndex == 0
                                      ? Theme.of(context).primaryColor
                                      : AppConstants.appMainGreyColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isSignedIn)
                    IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        value.onItemTapped(index: 1);
                        context.read<VibesProvider>().getVibesFn("", false);
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: value.selectedIndex == 1
                                    ? BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 4,
                                        style: BorderStyle.solid)
                                    : BorderSide.none)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            value.selectedIndex == 1
                                ? Image.asset(
                                    AppImages.cloudbold,
                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    AppImages.cloudlinear,
                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.fill,
                                  ),
                            const SizeBoxH(5),
                            CustomTextWidgets(
                              text: 'Vibes',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: value.selectedIndex == 1
                                        ? Theme.of(context).primaryColor
                                        : AppConstants.appMainGreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (isSignedIn)
                    IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        value.onItemTapped(index: 2);

                        context
                            .read<FlicksController>()
                            .getFlicksSubscriptionFn();
                        context
                            .read<FlicksController>()
                            .getFlicksHomeScreenFn();
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: value.selectedIndex == 2
                                    ? BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 4,
                                        style: BorderStyle.solid)
                                    : BorderSide.none)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            value.selectedIndex == 2
                                ? Image.asset(
                                    AppImages.boldvideo,
                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    AppImages.linearvideo,
                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.fill,
                                  ),
                            const SizeBoxH(5),
                            CustomTextWidgets(
                              text: 'Flicks',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: value.selectedIndex == 2
                                        ? Theme.of(context).primaryColor
                                        : AppConstants.appMainGreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (isSignedIn)
                    IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        value.onItemTapped(index: 3);
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: value.selectedIndex == 3
                                    ? BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 4,
                                        style: BorderStyle.solid)
                                    : BorderSide.none)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            value.selectedIndex == 3
                                ? Image.asset(
                                    AppImages.ordersbold,
                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    AppImages.orderslinear,
                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.fill,
                                  ),
                            const SizeBoxH(5),
                            CustomTextWidgets(
                              text: 'Orders',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: value.selectedIndex == 3
                                        ? Theme.of(context).primaryColor
                                        : AppConstants.appMainGreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (isSignedIn)
                    IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        value.onItemTapped(index: 4);
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: value.selectedIndex == 4
                                    ? BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 4,
                                        style: BorderStyle.solid)
                                    : BorderSide.none)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            value.selectedIndex == 4
                                ? Icon(
                                    Icons.settings,
                                    size: 22,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : const Icon(
                                    Icons.settings_outlined,
                                    size: 22,
                                    color: AppConstants.appMainGreyColor,
                                  ),
                            const SizeBoxH(5),
                            CustomTextWidgets(
                              text: 'Settings',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: value.selectedIndex == 4
                                        ? Theme.of(context).primaryColor
                                        : AppConstants.appMainGreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            )),
      ),
    );
  }
}

class ProfileAlertDialog extends StatelessWidget {
  const ProfileAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Complete Your Profile'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Please complete your profile to access all features.'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context); 
          },
          child: const Text('Complete Profile'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); 
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

void showProfileAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const ProfileAlertDialog();
    },
  );
}
