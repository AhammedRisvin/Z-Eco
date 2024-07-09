import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/notification/view%20model/notificaion_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../utils/enums.dart';
import '../../../utils/prefferences.dart';
import 'no_notification_widget.dart';

class ScreenNotification extends StatefulWidget {
  const ScreenNotification({super.key});

  @override
  State<ScreenNotification> createState() => _ScreenNotificationState();
}

class _ScreenNotificationState extends State<ScreenNotification> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NotificationProvider>(context, listen: false)
          .getNotificationFnc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        flexibleSpace: const CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: "Notifications",
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<NotificationProvider>(builder: (context, obj, _) {
          return Column(
            children: [
              const SizeBoxH(5),
              obj.notifiacationStatus == NotificationStatus.loading
                  ? const NotificationShimmer()
                  : obj.notificationList.notifications.isListNullOrEmpty()
                      ? const NoNotificationWidget()
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              obj.notificationList.notifications?.length ?? 0,
                          separatorBuilder: (context, index) {
                            return const SizeBoxH(10);
                          },
                          itemBuilder: (context, index) {
                            final data = obj.notificationList.notifications?[
                                (obj.notificationList.notifications?.length ??
                                        0) -
                                    1 -
                                    index];
                            return CommonInkwell(
                              onTap: () {
                                Provider.of<NotificationProvider>(context,
                                        listen: false)
                                    .removeNotificationFnc(
                                  id: data?.id ?? '',
                                  context: context,
                                  productLink: data?.shortId ?? "",
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppPref.isDark == true
                                      ? AppConstants.containerColor
                                      : const Color(0xffF3F9FF),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: ListTile(
                                  leading: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Image.asset(
                                      AppImages.appLogo,
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: SizedBox(
                                    width: 100,
                                    child: Text(
                                      ' ${data?.message} ',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 14,
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontWeight: FontWeight.w500,
                                          ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CustomTextWidgets(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 14,
                                                fontFamily: 'Plus Jakarta Sans',
                                                fontWeight: FontWeight.w500,
                                              ),
                                          text: DateFormat("h:mm a").format(
                                            data?.createdAt?.toLocal() ??
                                                DateTime.now(),
                                          )),
                                      const SizeBoxH(10),
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ],
          );
        }),
      ),
    );
  }
}

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // Set the number of shimmering items
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              title: Container(
                width: 100,
                height: 20,
                color: Colors.grey[300],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 50,
                    height: 20,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
