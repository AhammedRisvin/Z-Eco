import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/utils/app_constants.dart';

import '../../../helpers/sized_box.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extentions.dart';

class FlicksSettingsScreen extends StatefulWidget {
  const FlicksSettingsScreen({super.key});

  @override
  State<FlicksSettingsScreen> createState() => _FlicksSettingsScreenState();
}

class _FlicksSettingsScreenState extends State<FlicksSettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizeBoxH(Responsive.height * 4),
          SizedBox(
            width: Responsive.width * 100,
            height: Responsive.height * 6,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                  ),
                ),
                SizeBoxV(Responsive.width * 2),
                Text(
                  'Flicks settings',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          SizeBoxH(Responsive.height * 1),
          FlicksSettingsCommonTile(
            image: AppImages.currentSubIcon,
            title: "Current Subscription ",
            onTap: () {
              context.pushNamed(AppRouter.flicksCurrentSubScreen);
            },
          ),
          FlicksSettingsCommonTile(
            image: AppImages.watchHistoryIcon,
            title: "Watch History",
            onTap: () {
              context.pushNamed(AppRouter.flicksWatchHistoryScreen);
            },
          ),
          FlicksSettingsCommonTile(
            image: AppImages.flicksDownloadsIcon,
            title: "Downloads",
            onTap: () {
              context.pushNamed(AppRouter.flicksDownloadsScreen);
            },
          ),
          FlicksSettingsCommonTile(
            image: AppImages.flicksSaveButton,
            title: "Saved",
            onTap: () {
              context.pushNamed(AppRouter.libraryScreen);
            },
          ),
        ],
      ),
    );
  }
}

class FlicksSettingsCommonTile extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final String image;
  const FlicksSettingsCommonTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: Colors.transparent,
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
        color: Color(0xff8391A1),
      ),
      title: Row(
        children: [
          Image.asset(
            image,
            color: AppConstants.black,
            height: 20,
          ),
          const SizeBoxV(15),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      onTap: onTap,
    );
  }
}
