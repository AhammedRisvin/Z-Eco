import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/modules/settings/view%20model/settings_provider.dart';
import 'package:zoco/app/utils/app_images.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import '../widgets/settingsCommonListTile.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: const CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: 'Profile settings',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizeBoxH(Responsive.height * 2),
            SettingsCommonListTile(
              image: AppImages.profileSettings,
              onTap: () {
                context.read<SettingsProvider>().isupdateProfileFn(true);
                context.pushNamed(AppRouter.createProfile);
              },
              title: "Profile Edit",
              isTrailingShow: true,
            ),
            SettingsCommonListTile(
              image: AppImages.changePassword,
              onTap: () {
                context.pushNamed(AppRouter.changePasswordScreen);
              },
              title: "Change password",
              isTrailingShow: true,
            ),
          ],
        ),
      ),
    );
  }
}
