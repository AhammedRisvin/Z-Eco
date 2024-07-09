// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/modules/settings/view%20model/settings_provider.dart';
import 'package:zoco/app/utils/prefferences.dart';
import 'package:zoco/background_nt.dart';

import '../../../backend/server_client_services.dart';
import '../../../backend/urls.dart';
import '../../../helpers/common_widgets.dart';
import '../../../helpers/loading_overlay.dart';
import '../../../utils/app_constants.dart';

class AuthProviders extends ChangeNotifier {
  TextEditingController signupPhoneNumberTextEditingController =
      TextEditingController();
  TextEditingController tempSignupPhoneNumberTextEditingController =
      TextEditingController();
  bool isSignUnhiddenConfirmPassword = true;
  bool isSignUnhiddenPassword = true;
  bool isForgotPasswordOtp = false;

  signConfirmPasswordVisibility() {
    isSignUnhiddenConfirmPassword = !isSignUnhiddenConfirmPassword;
    notifyListeners();
  }

  signPasswordVisibility() {
    isSignUnhiddenPassword = !isSignUnhiddenPassword;
    notifyListeners();
  }

  bool isAuthUsingEmail = true;
  changeSignupTypeFn(bool value) {
    isAuthUsingEmail = value;
    if (isAuthUsingEmail == true) {
      signupEmailTextEditingController.clear();
      signupPasswordTextEditingController.clear();
      signupConfirmPasswordTextEditingController.clear();
    } else {
      signupPhoneNumberTextEditingController.clear();
    }
    notifyListeners();
  }

  ///check Which scenario for otp verification
  String otpVerificationScenario = 'email';
  checkovVerificationScenarioFn(String value) {
    otpVerificationScenario = value;
    notifyListeners();
  }

  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut(); // Google sign out
    await auth.signOut(); // Firebase sign out
  }

  String? userEmail;

  Future<void> signInWithGoogle({required BuildContext context}) async {
    try {
      await signOutGoogle();

      LoadingOverlay.of(context).show();
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Proceed with Firebase sign in
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        User? user = userCredential.user;

        var params = {
          "firebaseToken": AppPref.fcmToken,
          "email": user?.email,
        };

        List response = await ServerClient.post(
          Urls.googleAuth,
          data: params,
          post: true,
        );

        if (response.first >= 200 && response.first < 300) {
          AppPref.userToken = response.last["token"];

          if (response.last["isProfileCompleted"] ?? false) {
            context.pushNamed(AppRouter.tab);
            AppPref.isSignedIn = true;
            toast(
              context,
              title: response.last["message"],
              backgroundColor: Colors.green,
            );
          } else {
            isAuthUsingEmail = false;

            signingEmailTextEditingController.text =
                FirebaseAuth.instance.currentUser?.email ?? "";

            context.pushNamed(AppRouter.createProfile);
          }

          if (Navigator.of(context).canPop()) {
            LoadingOverlay.of(context).hide();
          }
        }
        notifyListeners();
      } else {
        if (Navigator.of(context).canPop()) {
          LoadingOverlay.of(context).hide();
        }
      }
    } catch (error) {
      if (Navigator.of(context).canPop()) {
        LoadingOverlay.of(context).hide();
      }
    } finally {
      notifyListeners();
      if (Navigator.of(context).canPop()) {
        LoadingOverlay.of(context).hide();
      }
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
      userEmail = auth.currentUser?.email;
    }
  }

//** Email Signup  Fun start  */
  TextEditingController signupEmailTextEditingController =
      TextEditingController();
  TextEditingController signupPasswordTextEditingController =
      TextEditingController();
  TextEditingController signupConfirmPasswordTextEditingController =
      TextEditingController();

  Future<void> emailSignupFun({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      var params = {
        "email": signupEmailTextEditingController.text.trim(),
        "password": signupConfirmPasswordTextEditingController.text.trim(),
      };
      List response =
          await ServerClient.post(Urls.emailSignup, data: params, post: true);

      if (response.first >= 200 && response.first < 300) {
        context.pushNamed(AppRouter.otpVerification);
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
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

//**end */
//** Email OTP Verify  Fun start  */
  String? otpController;

  Future<void> validateOtpFun({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      String token = await BackgroundNt.getToken() ?? "";

      var params = {
        "phone": otpVerificationScenario == 'email'
            ? ''
            : otpVerificationScenario == 'phone'
                ? signupPhoneNumberTextEditingController.text.trim()
                : '',
        "dialCode": otpVerificationScenario == 'email'
            ? ''
            : otpVerificationScenario == 'phone'
                ? dialCodeForProfile.trim()
                : '',
        "countryCode": otpVerificationScenario == 'email'
            ? ''
            : otpVerificationScenario == 'phone'
                ? dialCountryForProfile.trim()
                : '',
        "otp": otpController,
        "firebaseId": token,
        "email": otpVerificationScenario == 'email'
            ? isLoginResendOtp == false
                ? signupEmailTextEditingController.text.trim()
                : signingEmailTextEditingController.text.trim()
            : otpVerificationScenario == 'phone'
                ? ''
                : forgotEmailTextEditingController.text.trim(),
      };

      List response =
          await ServerClient.post(Urls.verifyOtp, data: params, post: true);

      if (response.first >= 200 && response.first < 300) {
        AppPref.userToken = response.last['token'];

        if (otpVerificationScenario == 'email') {
          if (response.last['isProfileCompleted'] == true) {
            AppPref.userToken = response.last['token'];
            AppPref.isSignedIn = true;
            clearController(context);
            context.goNamed(AppRouter.tab);
          } else {
            context.goNamed(AppRouter.createProfile);
          }
        } else if (otpVerificationScenario == 'phone') {
          if (response.last['isProfileCompleted'] == true) {
            AppPref.userToken = response.last['token'];
            AppPref.isSignedIn = true;
            clearController(context);
            context.goNamed(AppRouter.tab);
          } else {
            context.goNamed(AppRouter.createProfile);
          }
        } else {
          context.goNamed(AppRouter.createNewPassword);
        }

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
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
//**end */

//** Create Profile  Fun start  */

  TextEditingController profileFilenameController = TextEditingController();
  TextEditingController profileUserNameController = TextEditingController();
  TextEditingController profileAddressController = TextEditingController();
  TextEditingController profileCityController = TextEditingController();
  TextEditingController profileStateController = TextEditingController();

  TextEditingController profilePinoleController = TextEditingController();

  Future<void> createProfileFun({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      var params = {
        "profile": context.read<SettingsProvider>().imageUrlForUpload,
        "name": profileFilenameController.text.trim(),
        "username": profileUserNameController.text.trim(),
        "email": isLoginResendOtp == false
            ? signupEmailTextEditingController.text.trim()
            : signingEmailTextEditingController.text.trim(),
        "phoneNumber": signupPhoneNumberTextEditingController.text.trim(),
        "address": profileAddressController.text.trim(),
        "city": profileCityController.text.trim(),
        "dialCode": dialCodeForProfile.trim(),
        "countryCode": dialCountryForProfile.trim(),
        "state": profileStateController.text.trim(),
        "pincode": profilePinoleController.text.trim(),
        "password": isAuthUsingEmail
            ? ''
            : signupConfirmPasswordTextEditingController.text.trim(),
      };
      List response =
          await ServerClient.post(Urls.addDetails, data: params, post: true);

      if (response.first >= 200 && response.first < 300) {
        clearController(context);

        AppPref.isSignedIn = true;
        context.goNamed(AppRouter.tab);
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
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

//**end */

  String dialCountryForProfile = 'IN';
  String dialCodeForProfile = '+91';
  void getPhoneNumberFromCountryCodeFn(
      {required String dialCode, required String countryCode}) {
    dialCountryForProfile = countryCode;
    dialCodeForProfile = dialCode;
    notifyListeners();

  }

//**Sign in with Email Start Fun */
  void getPhoneNumberFn(
      {required String phone,
      required String dialCode,
    required String countryCode,
  }) {
    signupPhoneNumberTextEditingController.clear();
    signupPhoneNumberTextEditingController.text = phone;
    dialCountryForProfile = countryCode;
    dialCodeForProfile = dialCode;
    notifyListeners();
  }

  TextEditingController signingEmailTextEditingController =
      TextEditingController();
  TextEditingController signingPasswordTextEditingController =
      TextEditingController();
  Future<void> signin({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      var params = {
        "email": isAuthUsingEmail
            ? signingEmailTextEditingController.text.trim()
            : '',
        "password": isAuthUsingEmail
            ? signingPasswordTextEditingController.text.trim()
            : '',
        "phone": isAuthUsingEmail == false
            ? signupPhoneNumberTextEditingController.text.trim()
            : '',
        "dialCode": isAuthUsingEmail == false ? dialCodeForProfile.trim() : '',
      };

      List response =
          await ServerClient.post(Urls.login, data: params, post: true);

      if (response.first >= 200 && response.first < 300) {
        if (isAuthUsingEmail == true) {
          if (response.last['isOtpVerified'] == false) {
            checkovVerificationScenarioFn('email');
            checksLoginResendOtp(true);
            context.pushNamed(AppRouter.otpVerification);
          } else {
            if (response.last['isProfileCompleted'] == false) {
              checkovVerificationScenarioFn('email');
              checksLoginResendOtp(true);
              context.goNamed(AppRouter.createProfile);
            } else {
              AppPref.userToken = response.last['token'];
              AppPref.isSignedIn = true;
              clearController(context);
              context.goNamed(AppRouter.tab);
            }
          }
        } else {
          checkovVerificationScenarioFn('phone');
          context.pushNamed(AppRouter.otpVerification);
        }
      } else {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
        toast(
          context,
          title: response.last,
          duration: 2,
          backgroundColor: AppConstants.red,
        );
      }
      log('${response.last}');
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      LoadingOverlay.of(context).hide();
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
  TextEditingController forgotEmailTextEditingController =
      TextEditingController();
  Future<void> forgotPasswordFn({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      var params = {
        "email": forgotEmailTextEditingController.text.trim(),
      };
      List response =
          await ServerClient.post(Urls.forgotPssword, data: params, post: true);

      if (response.first >= 200 && response.first < 300) {
        checkovVerificationScenarioFn('forgotPassword');
        context.goNamed(AppRouter.otpVerification);
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
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  TextEditingController forgotPasswordTextEditingController =
      TextEditingController();
  TextEditingController forgotConfirmPasswordTextEditingController =
      TextEditingController();
  Future<void> createNewPasswordFn({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      var params = {
        "email": forgotEmailTextEditingController.text.trim(),
        'password': forgotConfirmPasswordTextEditingController.text.trim()
      };
      List response = await ServerClient.post(Urls.createNewPassword,
          data: params, post: true);

      if (response.first >= 200 && response.first < 300) {
        checkovVerificationScenarioFn('email');
        context.goNamed(AppRouter.passwordChangeSuccessScreen);
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
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

//**End */

//**Resend Otp Fn start */

  bool isLoginResendOtp = false;
  void checksLoginResendOtp(bool value) {
    isLoginResendOtp = value;
    notifyListeners();
  }

  Future<void> resendOtpFun({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      var params = {
        "phone": otpVerificationScenario == 'email'
            ? ''
            : otpVerificationScenario == 'phone'
                ? signupPhoneNumberTextEditingController.text.trim()
                : '',
        "email": otpVerificationScenario == 'email'
            ? isLoginResendOtp == false
                ? signupEmailTextEditingController.text.trim()
                : signingEmailTextEditingController.text.trim()
            : otpVerificationScenario == 'phone'
                ? ''
                : forgotEmailTextEditingController.text.trim(),
      };

      List response =
          await ServerClient.post(Urls.resentOtp, data: params, post: true);

      if (response.first >= 200 && response.first < 300) {
        toast(
          context,
          title: response.last,
          duration: 2,
          backgroundColor: AppConstants.red,
        );
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
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

//**End */

  void clearController(BuildContext context) {
    context.read<SettingsProvider>().imageUrlForUpload = '';
    context.read<SettingsProvider>().thumbnailImage = null;
    profileFilenameController.clear();
    profileUserNameController.clear();
    signupEmailTextEditingController.clear();
    signupPhoneNumberTextEditingController.clear();
    profileAddressController.clear();
    profileCityController.clear();
    profileStateController.clear();
    profilePinoleController.clear();
    signupConfirmPasswordTextEditingController.clear();
    otpController = '';
    signupPasswordTextEditingController.clear();
    signingPasswordTextEditingController.clear();
    signingEmailTextEditingController.clear();
    notifyListeners();
  }
}
