import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:zoco/app/backend/urls.dart';
import 'package:zoco/app/helpers/router.dart';

import '../../../backend/server_client_services.dart';
import '../../../utils/enums.dart';
import '../model/notifiacation_model.dart';

class NotificationProvider extends ChangeNotifier {
  String convertUtcToLocalTime(String utcTime) {
    final utcFormat = DateFormat('HH:mm');
    DateTime utcDateTime = utcFormat.parseUtc(utcTime);
    utcDateTime = utcDateTime.toLocal();
    final localFormat = DateFormat('hh:mm a');
    return localFormat.format(utcDateTime);
  }

  /*....................Api interaion.................... */
  /*...........Get Notification.......... */
  NotificationModel notificationList = NotificationModel();

  NotificationStatus notifiacationStatus = NotificationStatus.initial;
  Future getNotificationFnc() async {
    notifiacationStatus = NotificationStatus.loading;

    try {
      List response = await ServerClient.get(
        Urls.getNotificationUrl,
      );

      if (response.first >= 200 && response.first < 300) {
        notificationList = NotificationModel.fromJson(response.last);

        notifiacationStatus = NotificationStatus.loaded;
      } else {
        notificationList = NotificationModel();
        notifiacationStatus = NotificationStatus.error;
      }
    } catch (e) {
      notificationList = NotificationModel();
      notifiacationStatus = NotificationStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /*...........Get Notification.......... */

  /*....................REMOVE TAPPED NOTIFICATION.................... */

  Future<void> removeNotificationFnc({
    required String id,
    required BuildContext context,
    required String productLink,
  }) async {
    try {
      var data = {
        'id': id,
      };
      List response = await ServerClient.post(
        Urls.removeNotificationUrl,
        data: data,
      );

      if (response.first >= 200 && response.first < 300) {
        context.pushNamed(AppRouter.productDetailsViewScreen, queryParameters: {
          "productLink": productLink,
        });
        notificationList.notifications?.removeWhere(
          (element) => element.id == id,
        );
        getNotificationFnc();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    }
  }
}
