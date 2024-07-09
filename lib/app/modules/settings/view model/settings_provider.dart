import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoco/app/modules/auth/view_model/auth_provider.dart';
import 'package:zoco/app/modules/home/view_model/home_provider.dart';

import '../../../backend/server_client_services.dart';
import '../../../backend/urls.dart';
import '../../../helpers/common_widgets.dart';
import '../../../helpers/loading_overlay.dart';
import '../../../helpers/router.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/enums.dart';
import '../../../utils/prefferences.dart';
import '../../cart/model/get_cart_model.dart';
import '../../cart/view model/cart_provider.dart';
import '../../widgets/view_model/bottom_nav_bar_provider.dart';
import '../model/coupons_model.dart';
import '../model/favourites_model.dart';
import '../model/get_profile_model.dart';
import '../view/change_password_screen.dart';

class SettingsProvider extends ChangeNotifier {
  //CHANGE PASSWORD
  TextEditingController currentpasswordTextEditingController =
      TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  bool isCurrentiddenPassword = true;
  currentpasswordVisibility() {
    isCurrentiddenPassword = !isCurrentiddenPassword;
    notifyListeners();
  }

  bool isSignUnhiddenConfirmPassword = true;
  signConfirmPasswordVisibility() {
    isSignUnhiddenConfirmPassword = !isSignUnhiddenConfirmPassword;
    notifyListeners();
  }

  bool isSignUnhiddenPassword = true;
  signPasswordVisibility() {
    isSignUnhiddenPassword = !isSignUnhiddenPassword;
    notifyListeners();
  }

  Future<void> changePasswordFn({required BuildContext context}) async {
    try {
      var params = {
        "oldPassword": currentpasswordTextEditingController.text.trim(),
        "newPassword": confirmPasswordTextEditingController.text.trim()
      };

      List response = await ServerClient.post(Urls.changePassword,
          data: params, post: true);

      if (response.first >= 200 && response.first < 300) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              isOkButtonColorRed: false,
              cancel: () {
                context.pop();
                context.pop();
                context.pop();
              },
              ok: () {
                context.pop();
                context.pop();
                context.pop();
              },
              heading: "Password Changed successfully",
              bodyText: "You have changed the password",
            );
          },
        );
        currentpasswordTextEditingController.clear();
        confirmPasswordTextEditingController.clear();
        passwordTextEditingController.clear();
      } else {
        context.pop();
        toast(
          context,
          title: response.last,
          duration: 2,
          backgroundColor: AppConstants.red,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    }
  }

  //PROFILE PICTURE START
  File? thumbnailImage;
  Future changeProfilePhoto(bool isGallery, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera,
      );
      if (image == null) return;
      final imageTemporary = File(image.path);
      thumbnailImage = imageTemporary;

      notifyListeners();

      if (thumbnailImage != null) {
        context.pop();

        uploadSingleImage(context);
      }
    } on PlatformException catch (e) {
      debugPrint('Error occurred during upload: $e ');
    }
  }

//**Image Upload Fun */
  String imageUrlForUpload = '';
  // Function to upload image to the API
  String? imageTitlee;
  int uploadSingleImgLoading = 0;
  Future<void> uploadSingleImage(BuildContext context) async {
    uploadSingleImgLoading = 1;
    LoadingOverlay.of(context).show();
    imageUrlForUpload = '';

    imageTitlee = thumbnailImage?.path.split('/').last;

    final fileType = getMimeType(thumbnailImage?.path ?? '');

    const url = 'https://api.dev.test.image.theowpc.com/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image_mushthak',
        thumbnailImage?.path ?? '',
        contentType: MediaType.parse(fileType),
      ),
    );
    request.headers['Content-Type'] = fileType;
    LoadingOverlay.of(context).hide();
    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var data = json.decode(responseBody);

        imageUrlForUpload = data['images'][0]["imageUrl"];
      } else {
        // Error uploading image
      }
    } catch (e) {
      // Error occurred during upload
      debugPrint('Error occurred during upload: $e ');
    } finally {
      uploadSingleImgLoading = 2;
      notifyListeners();
    }
  }

  String getMimeType(String filePath) {
    final file = File(filePath);
    final fileType = file.path.split('.').last.toLowerCase();
    switch (fileType) {
      case 'jpg':
        return 'image/jpg';
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'mp4':
        return 'video/mp4';
      case 'webm':
        return 'video/webm';
      case 'mov':
        return 'video/quicktime';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'xls':
        return 'application/vnd.ms-excel';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'mkv':
        return 'video/x-matroska';
      case 'avi':
        return 'video/x-msvideo';
      case 'mp3':
        return 'audio/mpeg';
      case 'wav':
        return 'audio/wav';
      case 'flac':
        return 'audio/flac';
      default:
        return 'application/octet-stream';
    }
  }

  //get profile
  GetProfileModel getProfileData = GetProfileModel();

  Future<void> getProfileFn() async {
    try {
      getProfileData = GetProfileModel();
      List response = await ServerClient.get(
        Urls.profile,
      );

      if (response.first >= 200 && response.first < 300) {
        getProfileData = GetProfileModel.fromJson(response.last);
        notifyListeners();
      } else {
        getProfileData = GetProfileModel();
      }
    } catch (e) {
      getProfileData = GetProfileModel();
    }
    notifyListeners();
  }

// single image picker end
  bool isUpdateProfile = false;
  isupdateProfileFn(bool value) {
    isUpdateProfile = value;

    notifyListeners();
  }

  //PROFILE PIC END

  Future<void> updateProfileFun({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      var params = {
        "image": imageUrlForUpload,
        "firstName":
            context.read<AuthProviders>().profileFilenameController.text.trim(),
        "userName":
            context.read<AuthProviders>().profileUserNameController.text.trim(),
        "userEmail": context
            .read<AuthProviders>()
            .signupEmailTextEditingController
            .text
            .trim(),
        "phone": context
            .read<AuthProviders>()
            .signupPhoneNumberTextEditingController
            .text
            .trim(),
        "adress":
            context.read<AuthProviders>().profileAddressController.text.trim(),
        "city": context.read<AuthProviders>().profileCityController.text.trim(),
        "state":
            context.read<AuthProviders>().profileStateController.text.trim(),
        "pincode":
            context.read<AuthProviders>().profilePinoleController.text.trim(),
        "dialCode": context.read<AuthProviders>().dialCodeForProfile.trim(),
        "countryCode":
            context.read<AuthProviders>().dialCountryForProfile.trim(),
      };
      List response =
          await ServerClient.post(Urls.updateProfile, data: params, post: true);

      if (response.first >= 200 && response.first < 300) {
        getProfileFn();
        context.pop();
        toast(
          context,
          title: response.last,
          duration: 2,
          backgroundColor: AppConstants.red,
        );
        context.read<AuthProviders>().clearController(context);
        notifyListeners();
      } else {
        toast(
          context,
          title: response.last,
          duration: 2,
          backgroundColor: AppConstants.red,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      LoadingOverlay.of(context).hide();
    }
  }

  //launch url

  Future<void> makePhoneCall() async {
    String phoneNumber = "+918921633521";
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> makeEmail() async {
    String email = 'support@zoco.com';
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }

  //GET COUPONS START

  GetCouponsStatus getCouponsStatus = GetCouponsStatus.initial;
  GetCouponsModel getCouponsData = GetCouponsModel();

  Future<void> getCouponsFn(
      {required BuildContext context, required String cartId}) async {
    try {
      getCouponsData = GetCouponsModel();
      getCouponsStatus = GetCouponsStatus.loading;
      List response = await ServerClient.get(
        Urls.getCouponsUrl + cartId,
      );

      if (response.first >= 200 && response.first < 300) {
        getCouponsData = GetCouponsModel.fromJson(response.last);
        getCouponsStatus = GetCouponsStatus.loaded;
        notifyListeners();
      } else {
        getCouponsStatus = GetCouponsStatus.error;
        getCouponsData = GetCouponsModel();
      }
    } catch (e) {
      getCouponsStatus = GetCouponsStatus.error;
      getCouponsData = GetCouponsModel();
    } finally {
      notifyListeners();
    }
  }

  // GET COUPONS END

  // GET WISHLIST START

  GetWishlistStatus getWishlistStatus = GetWishlistStatus.initial;
  GetFavouritesModel wishlistData = GetFavouritesModel();

  Future<void> getWishlistFn() async {
    try {
      wishlistData = GetFavouritesModel();
      getWishlistStatus = GetWishlistStatus.loading;
      List response = await ServerClient.get(
        Urls.getWishlistUrl,
      );

      if (response.first >= 200 && response.first < 300) {
        wishlistData = GetFavouritesModel.fromJson(response.last);

        getWishlistStatus = GetWishlistStatus.loaded;
        notifyListeners();
      } else {
        getWishlistStatus = GetWishlistStatus.error;
        wishlistData = GetFavouritesModel();
      }
    } catch (e) {
      getWishlistStatus = GetWishlistStatus.error;
      wishlistData = GetFavouritesModel();
    } finally {
      notifyListeners();
    }
  }

  // GET WISHLIST END

  String returnOfferPercentageFn(
      {required int discountPrice, required int totalPrice}) {
    double percentage = (discountPrice * 100) / totalPrice;
    int integerPercentage = percentage.toInt();
    return integerPercentage.toString();
  }

  Future applyCouponCodeFn({
    required BuildContext context,
    required String cartId,
    required String couponId,
  }) async {
    LoadingOverlay.of(context).show();
    try {
      List response = await ServerClient.post(
        Urls.applyCouponUrl,
        data: {
          "cartId": cartId,
          "couponId": couponId,
        },
      );
      print(response.last['message']);
      if (response.first >= 200 && response.first < 300) {
        context.read<CartProvider>().getCartModel =
            GetCartModel.fromJson(response.last);
        context.read<CartProvider>().selectedCouponId = couponId;
        context.read<CartProvider>().isCouponApplied = true;

        notifyListeners();
        LoadingOverlay.of(context).hide();
        context.pop();
        toast(
          context,
          title: response.last['message'],
          backgroundColor: Colors.green,
        );
      } else {
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: "Something ent wrong.Please try again later",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  //copy code end

  Future removeFromWishlistFn({
    required String productId,
    required BuildContext context,
    int? index,
  }) async {
    try {
      List response = await ServerClient.post(
        Urls.addOrRemoveFromWishlistUrl,
        data: {
          "id": productId, //"660a4905cda459e72dad3f79"
        },
      );

      if (response.first >= 200 && response.first < 300) {
        SettingsProvider settingsProvider = context.read<SettingsProvider>();
        settingsProvider.getWishlistFn();
        context.read<HomeProvider>().fetchHomeData();
        toast(
          title: "${response.last['message']}",
          backgroundColor: Colors.red,
          context,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return "Version $version ($buildNumber)";
  }

  // delete account fn start

  Future<void> deleteAccountFn(BuildContext context) async {
    LoadingOverlay.of(context).show();
    try {
      List response = await ServerClient.delete(
        Urls.deleteAccountUrl,
        data: {},
      );
      if (response.first >= 200 && response.first < 300) {
        AppPref.isSignedIn = false;
        AppPref.userToken = '';
        context.read<BottomBarProvider>().selectedIndex = 0;
        context.pop();
        context.goNamed(AppRouter.initial);
      } else {
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: response.last,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      LoadingOverlay.of(context).hide();
    }
  }
}
