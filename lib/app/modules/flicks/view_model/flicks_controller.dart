import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoco/app/modules/flicks/widgets/flicks_memebership_success_screen.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/prefferences.dart';

import '../../../backend/server_client_services.dart';
import '../../../backend/urls.dart';
import '../../../env.dart';
import '../../../helpers/common_widgets.dart';
import '../../../helpers/loading_overlay.dart';
import '../../../helpers/router.dart';
import '../../../utils/enums.dart';
import '../model/active_sub_model.dart';
import '../model/downloads_model.dart';
import '../model/get_flicks_catagory_model.dart';
import '../model/get_flicks_detailed_view_model.dart';
import '../model/get_flicks_home_screen_model.dart';
import '../model/get_slicks_library_model.dart';
import '../model/subscription_model.dart';
import '../widgets/flicks_paypal_screen.dart';

class FlicksController with ChangeNotifier {
  List<String> textListoftevView = [
    'Trending',
    'Movies',
    'Series',
    'Documentries',
  ];

  List<String> textListforSeasons = [
    'Season 1',
    'Season 2',
    'Season 3',
    'Season 4',
  ];

  List<String> imageList = [
    AppImages.moviePosterOne,
    AppImages.moviePosterTwo,
    AppImages.moviePosterThree
  ];

  //GET SUBSCRIPTION START

  GetFlicksSubscriptionStatus getFlicksSubscriptionStatus =
      GetFlicksSubscriptionStatus.initial;
  GetFlicksSubscriptionModel getFlicksSubscriptionModel =
      GetFlicksSubscriptionModel();

  Future<void> getFlicksSubscriptionFn() async {
    try {
      getFlicksSubscriptionStatus = GetFlicksSubscriptionStatus.loading;
      List response = await ServerClient.get(
        Urls.getFlicksSubscriptionUrl,
      );

      log("response ${response.last}");
      log("response ${response.first}");

      if (response.first >= 200 && response.first < 300) {
        getFlicksSubscriptionModel =
            GetFlicksSubscriptionModel.fromJson(response.last);

        getFlicksSubscriptionStatus = GetFlicksSubscriptionStatus.loaded;
        notifyListeners();
      } else {
        getFlicksSubscriptionStatus = GetFlicksSubscriptionStatus.error;
        getFlicksSubscriptionModel = GetFlicksSubscriptionModel();
      }
    } catch (e) {
      getFlicksSubscriptionModel = GetFlicksSubscriptionModel();
      getFlicksSubscriptionStatus = GetFlicksSubscriptionStatus.error;
    }
    notifyListeners();
  }

  //GET SUBSCRIPTION END

  // single sub details list start

  Membership? membershipPlan = Membership();

  void selectedSubPlan(Membership? newPlan) {
    membershipPlan = newPlan;
    notifyListeners();
  }

  // end single sub list

  //GET FLICKS LIBRARY START

  GetFlicksLibraryStatus getFlicksLibraryStatus =
      GetFlicksLibraryStatus.initial;
  GetFlicksLibraryModel getFlicksLibraryModel = GetFlicksLibraryModel();

  Future<void> getFlicksLibraryFn() async {
    getFlicksLibraryStatus = GetFlicksLibraryStatus.loading;
    List response = await ServerClient.get(
      Urls.getFlicksLibraryUrl,
    );

    if (response.first >= 200 && response.first < 300) {
      getFlicksLibraryModel = GetFlicksLibraryModel.fromJson(response.last);

      getFlicksLibraryStatus = GetFlicksLibraryStatus.loaded;
      notifyListeners();
    } else {
      getFlicksLibraryStatus = GetFlicksLibraryStatus.error;
      getFlicksLibraryModel = GetFlicksLibraryModel();
    }

    notifyListeners();
  }

  //GET FLICKS LIBRARY END

  //GET FLICKS ACTIVE SUB START

  // dateTime into date

  String formatDate(DateTime dateTime) {
    // Use the DateFormat class from intl package to format the date
    DateFormat formatter =
        DateFormat('yyyy-MM-dd'); // Change the format as needed
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  GetFlicksActiveSubStatus getFlicksActiveSubStatus =
      GetFlicksActiveSubStatus.initial;
  GetFlicksActiveSubscriptionModel getFlicksActiveSubscriptionModel =
      GetFlicksActiveSubscriptionModel();

  Future<void> getFlicksActiveSubFn() async {
    try {
      getFlicksActiveSubStatus = GetFlicksActiveSubStatus.loading;
      List response = await ServerClient.get(
        Urls.getFlicksActivesSubUrl,
      );

      if (response.first >= 200 && response.first < 300) {
        getFlicksActiveSubscriptionModel =
            GetFlicksActiveSubscriptionModel.fromJson(response.last);

        getFlicksActiveSubStatus = GetFlicksActiveSubStatus.loaded;
        notifyListeners();
      } else {
        getFlicksActiveSubscriptionModel = GetFlicksActiveSubscriptionModel();
        getFlicksActiveSubStatus = GetFlicksActiveSubStatus.error;
      }
    } catch (e) {
      getFlicksActiveSubscriptionModel = GetFlicksActiveSubscriptionModel();
      getFlicksActiveSubStatus = GetFlicksActiveSubStatus.error;
    } finally {
      notifyListeners();
    }
  }

  //GET FLICKS ACTIVE SUB END

  //GET FLICKS HOME SCREEN START

  GetFlicksHomeScreenStatus getFlicksHomeScreenStatus =
      GetFlicksHomeScreenStatus.initial;
  GetFlicksHomeScreenModel getFlicksHomeScreenModel =
      GetFlicksHomeScreenModel();

  Future<void> getFlicksHomeScreenFn() async {
    getFlicksHomeScreenStatus = GetFlicksHomeScreenStatus.loading;
    List response = await ServerClient.get(
      Urls.getFlicksHomeScreenUrl,
    );

    if (response.first >= 200 && response.first < 300) {
      getFlicksHomeScreenModel =
          GetFlicksHomeScreenModel.fromJson(response.last);

      getFlicksHomeScreenStatus = GetFlicksHomeScreenStatus.loaded;
      notifyListeners();
    } else {
      getFlicksHomeScreenModel = GetFlicksHomeScreenModel();
      getFlicksHomeScreenStatus = GetFlicksHomeScreenStatus.error;
      notifyListeners();
    }
  }

  //GET FLICKS  HOME SCREEN END

  //GET FLICKS detailed view START

  GetFlicksDetailedViewStatus getFlicksDetailedViewStatus =
      GetFlicksDetailedViewStatus.initial;
  GetFlicksDetailedViewModel getFlicksDetailedViewModel =
      GetFlicksDetailedViewModel();

  List<Episode> flicksEpisodeList = [];

  Future<void> getFlicksDetailedViewFn({required String flicksId}) async {
    try {
      getFlicksDetailedViewStatus = GetFlicksDetailedViewStatus.loading;
      List response = await ServerClient.get(
        Urls.getFlicksDetailedViewUrl + flicksId,
      );
      log("response detailed  ${response.last}");
      log("response  detailed ${response.first}");

      if (response.first >= 200 && response.first < 300) {
        getFlicksDetailedViewModel =
            GetFlicksDetailedViewModel.fromJson(response.last);
        if (getFlicksDetailedViewModel.flick?.seasons?.isNotEmpty == true) {
          flicksEpisodeList.clear();
          flicksEpisodeList.addAll(
              getFlicksDetailedViewModel.flick?.seasons?[0].episodes ?? []);
        }

        getFlicksDetailedViewStatus = GetFlicksDetailedViewStatus.loaded;
        notifyListeners();
      } else {
        flicksEpisodeList.clear();
        getFlicksDetailedViewModel = GetFlicksDetailedViewModel();
        getFlicksDetailedViewStatus = GetFlicksDetailedViewStatus.error;
      }
    } catch (e) {
      flicksEpisodeList.clear();
      getFlicksDetailedViewModel = GetFlicksDetailedViewModel();
      getFlicksDetailedViewStatus = GetFlicksDetailedViewStatus.error;
    } finally {
      notifyListeners();
    }
  }

  //GET FLICKS  detailed view END

  //handle library

  Future handleLibraryFn({
    required String flicksId,
    required BuildContext context,
    String? isFrom,
    int? index,
  }) async {
    try {
      List response = await ServerClient.post(
        Urls.handleFlicksLibraryUrl,
        data: {
          "id": flicksId,
        },
      );
      toast(
        title: "${response.last['message']}",
        backgroundColor: Colors.green,
        context,
      );

      if (response.first >= 200 && response.first < 300) {
        if (isFrom == "Details") {
          getFlicksDetailedViewModel.flick?.saved == true
              ? getFlicksDetailedViewModel.flick?.saved = false
              : getFlicksDetailedViewModel.flick?.saved = true;
        }

        getFlicksLibraryFn();
        getFlicksHomeScreenFn();

        notifyListeners();
      } else {}
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  // handle library end

  bool isExpanded = false;

  void toggleExpand() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  int? selectedSeasonIndex;

  void selectSeason(int index) {
    selectedSeasonIndex = index;

    notifyListeners();
  }

  void changeSeasonFn(int index) {
    flicksEpisodeList.clear();
    final newFlicks =
        getFlicksDetailedViewModel.flick?.seasons?[index].episodes;
    flicksEpisodeList.addAll(newFlicks ?? []);
    notifyListeners();
  }

  //SUBSCRIPTION PURCHASING START

  int selectedPaymentIndex = -1;

  void setSelectedPaymentIndex(int index) {
    selectedPaymentIndex = index;
    notifyListeners();
  }

  bool isWalletSelected = false;
  void selectWalletFn() {
    isWalletSelected = !isWalletSelected;
    notifyListeners();
  }

  //SUBSCRIPTION PURCHASING END

  // is date expired

  bool isDateExpiredToday(DateTime date) {
    final currentDate = DateTime.now();
    final midnight =
        DateTime(currentDate.year, currentDate.month, currentDate.day);

    final endOfCurrentDay = midnight.add(const Duration(days: 1));

    return date.isBefore(endOfCurrentDay);
  }

  // is date expired end

  // wallet payment fn start

  Future flicksWalletPaymentFn({
    required BuildContext context,
    required String amount,
    required String plan,
    bool? isDownloadable,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.flicksWalletPayUrl,
        data: {
          "amount": amount,
          "plan": plan,
        },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        LoadingOverlay.of(context).hide();

        isWalletSelected = false;
        selectedPaymentIndex = -1;
        AppPref.flicksDownloadable = membershipPlan?.isDownloadable ?? false;
        getFlicksSubscriptionFn();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const FlicksSubSuccessScreen(),
        ));
      } else {
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: response.last,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
    } finally {
      notifyListeners();
    }
  }

  // wallet payment end

  //** Paypal Payment Start */

  String paypalUrl = '';
  String paypalSuccessUrl = '';
  String paypalCancelUrl = '';
  String subscriptionAmount = "";
  String subscriptionPlanId = "";
  amountAndPlanIdFn({required String amount, required String planId}) {
    subscriptionAmount = amount;
    subscriptionPlanId = planId;
    notifyListeners();
  }

  Future createPaypalFn({
    required BuildContext context,
    required String isWalletApplied,
    required String amount,
    bool? isDownloadable,
  }) async {
    LoadingOverlay.of(context).show();
    List response = await ServerClient.post(
      Urls.flicksPaypalUrl + isWalletApplied,
      data: {
        "amount": amount,
      },
      post: true,
    );
    if (response.first >= 200 && response.first < 300) {
      LoadingOverlay.of(context).hide();
      paypalUrl = response.last['url'];
      paypalSuccessUrl = response.last['successUrl'];
      paypalCancelUrl = response.last['cancelUrl'];
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const FlicksPaypalScreen(),
      ));
    } else {
      LoadingOverlay.of(context).hide();
      toast(context, title: response.last, backgroundColor: Colors.red);
    }
  }

  //validate payment
  Future paypalPaymentValidationFn({
    required String paymentId,
    required String payerID,
    required BuildContext context,
    required WebViewController controller,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.flicksPaypalValidation,
        data: {
          "payerId": payerID,
          "paymentId": paymentId,
          "payAmount": subscriptionAmount,
          "plan": subscriptionPlanId,
        },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        LoadingOverlay.of(context).hide();
        getFlicksSubscriptionFn();
        isWalletSelected = false;
        selectedPaymentIndex = -1;
        AppPref.flicksDownloadable = membershipPlan?.isDownloadable ?? false;
        successPopUp(
          image: AppImages.successmark,
          context: context,
          content: '''Payment has been \n successfully completed .''',
          title: 'Payment Success',
          ontap: () async {
            controller.clearCache();
            controller.clearLocalStorage();
            bool value = await controller.canGoBack();

            if (value) {
              controller.goBack();
            } else {
              context.pushNamed(AppRouter.tab);
            }
          },
        );
      } else {
        LoadingOverlay.of(context).hide();
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
    }

    notifyListeners();
  }
//**End */

  //**Stripe Payment Start */

  String paymentIntentId = '';

  Future createStripeFn({
    required BuildContext context,
    required String amount,
    required String isWalletApplied,
    bool? isDownloadable,
  }) async {
    LoadingOverlay.of(context).show();
    List response = await ServerClient.post(
      Urls.flicksStripeUrl + isWalletApplied,
      data: {
        "amount": 100,
      },
      post: true,
    );

    if (response.first >= 200 && response.first < 300) {
      paymentIntentId = response.last['clientSecret'];

      makeStripePayment(
        context: context,
      );
    } else {
      toast(context, title: response.last, backgroundColor: Colors.red);
    }
  }

  Future<void> makeStripePayment({
    required BuildContext context,
  }) async {
    try {
      try {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                merchantDisplayName: "prospect",
                paymentIntentClientSecret: paymentIntentId));
      } catch (e) {
        LoadingOverlay.of(context).hide();
      }
      //STEP 3: Display Payment sheet
      try {
        LoadingOverlay.of(context).hide();

        await Stripe.instance.presentPaymentSheet().then((value) async {
          await paymentValidationFn(
            clintId: paymentIntentId,
            context: context,
          );
        });
      } on Exception catch (e) {
        LoadingOverlay.of(context).hide();

        if (e is StripeException) {
          debugPrint('Error occurred during upload: $e ');
        } else {
          debugPrint('Error occurred during upload: $e ');
        }
      } catch (e) {
        LoadingOverlay.of(context).hide();
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    }
  }

  //validate payment
  Future paymentValidationFn({
    required clintId,
    required BuildContext context,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.flicksStripeValidation,
        data: {
          "clientSecret": clintId,
          "plan": subscriptionPlanId,
        },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        getFlicksSubscriptionFn();
        isWalletSelected = false;
        selectedPaymentIndex = -1;
        AppPref.flicksDownloadable = membershipPlan?.isDownloadable ?? false;
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: response.last['message'],
          duration: 2,
          backgroundColor: Colors.green,
        );
        notifyListeners();
      } else {
        LoadingOverlay.of(context).hide();
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

//**End */

// SECONDS INTO HOURS AND MINUTES

  String formatSeconds(int seconds) {
    int hours = seconds ~/ 3600; // 3600 seconds in an hour
    int remainingSeconds = seconds % 3600;
    int minutes =
        remainingSeconds ~/ 60; // Remaining seconds divided by 60 gives minutes
    int remainingSecondsAfterMinutes =
        remainingSeconds % 60; // Remaining seconds after minutes

    String hoursString = hours < 10 ? '0$hours' : '$hours';
    String minutesString = minutes < 10 ? '0$minutes' : '$minutes';
    String secondsString = remainingSecondsAfterMinutes < 10
        ? '0$remainingSecondsAfterMinutes'
        : '$remainingSecondsAfterMinutes';

    return '${hoursString}H:${minutesString}m:${secondsString}s';
  }
// SECONDS INTO HOURS AND MINUTES END

//GET FLICKS LIBRARY START

  GetFlicksWatchHistoryStatus getFlicksWatchHistoryStatus =
      GetFlicksWatchHistoryStatus.initial;
  GetFlicksLibraryModel getFlicksWatchHistoryModel = GetFlicksLibraryModel();
  List<dynamic>? watchHistory = [];

  Future<void> getFlicksWatchHistoryFn() async {
    try {
      getFlicksWatchHistoryStatus = GetFlicksWatchHistoryStatus.loading;
      List response = await ServerClient.get(
        Urls.getFlicksWatchHistoryUrl,
      );

      if (response.first >= 200 && response.first < 300) {
        getFlicksWatchHistoryModel =
            GetFlicksLibraryModel.fromJson(response.last);

        getFlicksWatchHistoryStatus = GetFlicksWatchHistoryStatus.loaded;
        notifyListeners();
      } else {
        getFlicksWatchHistoryModel = GetFlicksLibraryModel();
        getFlicksWatchHistoryStatus = GetFlicksWatchHistoryStatus.error;
      }
    } catch (e) {
      getFlicksWatchHistoryModel = GetFlicksLibraryModel();
      getFlicksWatchHistoryStatus = GetFlicksWatchHistoryStatus.error;
    } finally {
      notifyListeners();
    }
  }

  //GET FLICKS LIBRARY END

  clearHistory({
    required BuildContext context,
  }) async {
    List<String> ids = [];

    for (var element in getFlicksWatchHistoryModel.flicks ?? []) {
      ids.add(element.id ?? "");
    }

    await deleteFlicksWatchHistoryFn(context: context, ids: ids);
  }

  // DELETE FLICKS FUNCTION START

  Future deleteFlicksWatchHistoryFn({
    required BuildContext context,
    required List<String> ids,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.delete(
        Urls.flicksDeleteFromWatchHistoryUrl,
        data: {
          "flicks": ids,
        },
      );

      if (response.first >= 200 && response.first < 300) {
        getFlicksWatchHistoryFn();
        context.pop();

        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: response.last['message'],
          backgroundColor: Colors.red,
        );
      } else {
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: response.last['message'],
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
    } finally {
      notifyListeners();
    }
  }
  // DELETE FLICKS FUNCTION END

  // DELETE FLICKS FROM LIBRARY START

  Future deleteFlicksFromLibrary({
    required BuildContext context,
    required String id,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.delete(
        Urls.flicksDeleteFromLibraryUrl,
        data: {
          "flick": id,
        },
      );

      if (response.first >= 200 && response.first < 300) {
        getFlicksLibraryFn();
        getFlicksHomeScreenFn();

        context.pop();

        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: response.last['message'],
          backgroundColor: Colors.red,
        );
      } else {
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: response.last['message'],
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
    } finally {
      notifyListeners();
    }
  }
  // DELETE FLICKS FROM LIBRARY END

  // WATCH HISTORY POST START

  Future isWatchHistoryClickedFn({
    required BuildContext context,
    required String id,
  }) async {
    try {
      List response = await ServerClient.post(
        Urls.isWatchHistoryClickedUrl,
        data: {
          "flick": id,
        },
      );

      if (response.first >= 200 && response.first < 300) {
      } else {}
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  // WATCH HISTORY POST END

  // share video url start

  void shareVideoUrl({required String videoUrl, required String subject}) {
    Share.share(
      "${Environments.baseUrl}$videoUrl",
      subject: subject,
    );
  }

  // share video url end

  //GET FLICKS HOME SCREEN START

  GetFlicksCatagoryScreenStatus getFlicksCatagoryScreenStatus =
      GetFlicksCatagoryScreenStatus.initial;
  FlicksCatagoryModel flicksCatagoryModel = FlicksCatagoryModel();

  Future<void> getFlicksCatagoryWiseFn({required String catagory}) async {
    try {
      getFlicksCatagoryScreenStatus = GetFlicksCatagoryScreenStatus.loading;
      List response = await ServerClient.get(
        Urls.getFlicksCatagoryScreenUrl + catagory,
      );

      if (response.first >= 200 && response.first < 300) {
        flicksCatagoryModel = FlicksCatagoryModel.fromJson(response.last);
        getFlicksCatagoryScreenStatus = GetFlicksCatagoryScreenStatus.loaded;

        notifyListeners();
      } else {
        getFlicksCatagoryScreenStatus = GetFlicksCatagoryScreenStatus.error;
        flicksCatagoryModel = FlicksCatagoryModel();
      }
    } catch (e) {
      getFlicksCatagoryScreenStatus = GetFlicksCatagoryScreenStatus.error;
      flicksCatagoryModel = FlicksCatagoryModel();
    } finally {
      notifyListeners();
    }
  }

  //GET FLICKS  CATAGORY WISE END

  /*............. Serch api ............. */
  GetFlicksLibraryModel searchModel = GetFlicksLibraryModel();

  TextEditingController flicksSearchEditingController = TextEditingController();
  List<dynamic>? searchFlicksList = [];
  String query = "";

  FlicksSearchStatus flicksSearchStatus = FlicksSearchStatus.initial;
  Future getSerchProductFnc({required String query}) async {
    this.query = query;
    flicksSearchStatus = FlicksSearchStatus.loading;

    try {
      List response = await ServerClient.get(Urls.flicksSearchUrl + query);
      if (response.first >= 200 && response.first < 300) {
        searchModel = GetFlicksLibraryModel.fromJson(response.last);
        searchFlicksList?.clear();
        searchFlicksList?.addAll(searchModel.flicks ?? []);

        flicksSearchStatus = FlicksSearchStatus.loaded;
      } else {
        searchFlicksList = [];
        searchModel = GetFlicksLibraryModel();
        flicksSearchStatus = FlicksSearchStatus.error;
      }
    } catch (e) {
      searchFlicksList = [];
      searchModel = GetFlicksLibraryModel();
      flicksSearchStatus = FlicksSearchStatus.error;
    } finally {
      notifyListeners();
    }
  }

  ValueNotifier<bool> isDownloadingNotifier = ValueNotifier<bool>(false);

  ValueNotifier<double> progressNotifier = ValueNotifier<double>(0);

  Future<void> videoDownload({
    required String url,
    required String img,
    required String duration,
    required BuildContext context,
    required String id,
    required String name,
    required String fileSize,
  }) async {
    String extName = url.split('.').last;
    var tempDir = await getExternalStorageDirectory();
    String fullPath =
        "${tempDir?.path}/${DateTime.now().millisecondsSinceEpoch}.$extName";
    try {
      isDownloadingNotifier.value = true;
      notifyListeners();
      Dio dio = Dio();
      dio.options.followRedirects = false;
      dio.options.validateStatus = (status) {
        return status! < 500;
      };
      Response response = await dio.get(url);
      if (response.isRedirect == true) {
        String? redirectUrl = response.headers.value("location") ?? "";
        response = await Dio().get(
          redirectUrl,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              debugPrint("${(received / total * 100) / 100}%  $id");
              progressNotifier.value = (received / total * 100) / 100;
              notifyListeners();
            }
          },
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return (status ?? 0) < 500;
            },
          ),
        );
        File file = File(fullPath);
        var raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();
      } else {
        response = await Dio().get(
          url,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              debugPrint("${received / total * 100}%  $id");
              progressNotifier.value = (received / total * 100) / 100;
              notifyListeners();
            }
          },
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return (status ?? 0) < 500;
            },
          ),
        );
        File file = File(fullPath);
        var raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();
      }

      Box<DownloadModel> obj = await Hive.openBox<DownloadModel>("abc");
      await obj.add(DownloadModel(
        path: fullPath,
        image: img,
        duration: duration,
        videoId: id,
        name: name,
        fileSize: fileSize,
      ));
      downloadList.add(DownloadModel(
        path: fullPath,
        image: img,
        duration: duration,
        videoId: id,
        name: name,
        fileSize: fileSize,
      ));
      isDownloadingNotifier.value = false;
    } catch (e) {
      return;
    } finally {
      isDownloadingNotifier.value = false;
      notifyListeners();
      progressNotifier.value = 0;
    }
  }

  // bool downloadListLoading = false;
  List<DownloadModel> downloadList = [];
  Future<void> createList() async {
    downloadList.clear();
    Box<DownloadModel> obj = await Hive.openBox<DownloadModel>("abc");
    downloadList = obj.values.toList();
    log("downloadList ${downloadList.length}");
    notifyListeners();
  }
}
