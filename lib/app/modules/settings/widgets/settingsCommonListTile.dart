import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/utils/app_constants.dart';

import '../../../helpers/common_widgets.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/extentions.dart';

class SettingsCommonListTile extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final String image;
  final bool isTrailingShow;
  final isFromSocialMedia;
  final double imageHeight;
  final bool isDeleteAccount;
  const SettingsCommonListTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.image,
    this.isTrailingShow = true,
    this.isFromSocialMedia = false,
    this.imageHeight = 26,
    this.isDeleteAccount = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        image,
        height: imageHeight,
        color: context.watch<ThemeProvider>().isDarkMode == true
            ? isDeleteAccount
                ? AppConstants.red
                : const Color(0xffffffff)
            : isDeleteAccount
                ? AppConstants.red
                : const Color.fromARGB(188, 0, 0, 0),
      ),
      title: CustomTextWidgets(
        text: title,
        textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 16,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w500,
            ),
      ),
      trailing: isFromSocialMedia
          ? Container(
              height: Responsive.height * 4.5,
              width: Responsive.width * 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffE6F6FF),
              ),
              child: Center(
                child: CustomTextWidgets(
                  text: "Connect",
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                        fontFamily: 'Plus Jakarta Sans',
                        color: const Color(0xff2F4EFF),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            )
          : isTrailingShow
              ? const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 18,
                )
              : const SizedBox.shrink(),
      onTap: onTap,
    );
  }
}
