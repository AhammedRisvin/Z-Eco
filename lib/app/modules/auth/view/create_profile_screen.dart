import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/auth/view_model/auth_provider.dart';
import 'package:zoco/app/modules/settings/view%20model/settings_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../utils/app_images.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({
    super.key,
  });

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  SettingsProvider? settingsProvider;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    settingsProvider = context.read<SettingsProvider>();

    if (settingsProvider?.isUpdateProfile == true) {
      setState(() {
        context.read<AuthProviders>().dialCountryForProfile =
            settingsProvider?.getProfileData.profile?.countryCode ?? 'IN';
        context.read<AuthProviders>().dialCodeForProfile =
            settingsProvider?.getProfileData.profile?.dialCode ?? '+91';
        context.read<AuthProviders>().profileFilenameController.text =
            settingsProvider?.getProfileData.profile?.name ?? '';
        context.read<AuthProviders>().profileUserNameController.text =
            settingsProvider?.getProfileData.profile?.userName ?? '';
        context.read<AuthProviders>().signupEmailTextEditingController.text =
            settingsProvider?.getProfileData.profile?.email ?? '';
        context
            .read<AuthProviders>()
            .signupPhoneNumberTextEditingController
            .text = settingsProvider?.getProfileData.profile?.phone ?? '';
        context.read<AuthProviders>().profileAddressController.text =
            settingsProvider?.getProfileData.profile?.adderss ?? '';
        context.read<AuthProviders>().profileCityController.text =
            settingsProvider?.getProfileData.profile?.city ?? '';
        context.read<AuthProviders>().profileStateController.text =
            settingsProvider?.getProfileData.profile?.state ?? '';
        context.read<AuthProviders>().profilePinoleController.text =
            settingsProvider?.getProfileData.profile?.pincode.toString() ?? '';
        settingsProvider?.imageUrlForUpload =
            settingsProvider?.getProfileData.profile?.profilePicture ?? '';
      });
    }
  }

  String removeCountryCode(String phoneNumber, String countryCode) {
    return phoneNumber.replaceFirst(countryCode, '');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        settingsProvider?.isupdateProfileFn(false);

        context.read<AuthProviders>().clearController(context);
        context.pop();
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: settingsProvider?.isUpdateProfile == true
                ? CustomAppBarWidget(
                    onTap: () {
                      context.read<AuthProviders>().clearController(context);
                      context.pop();
                    },
                  )
                : const SizedBox.shrink()),
        body: Consumer<AuthProviders>(
          builder: (context, authProvider, child) {
            String? email = FirebaseAuth.instance.currentUser?.email;
            if (email != null) {
              authProvider.isAuthUsingEmail = false;
            }

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizeBoxH(60),
                      SizedBox(
                        child: Selector<SettingsProvider, bool>(
                          selector: (p0, p1) => p1.isUpdateProfile,
                          builder: (context, isUpdateProfile, child) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidgets(
                                text: isUpdateProfile
                                    ? 'Edit your Profile'
                                    : 'Set your Profile',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 24,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                              ),
                              const SizeBoxH(10),
                              CustomTextWidgets(
                                text: isUpdateProfile
                                    ? 'Edit your Profile as follows'
                                    : 'set your profile as follows',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontSize: 14,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                              ),
                              const SizeBoxH(30),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Responsive.width * 32.0),
                        child: CommonInkwell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: Responsive.height * 20,
                                    width: Responsive.width * 100,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                      color: AppConstants.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomTextWidgets(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                              text: 'Open with',
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.pop();
                                              },
                                              child: CustomTextWidgets(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.red,
                                                      height: 0,
                                                    ),
                                                text: 'Cancel',
                                              ),
                                            )
                                          ],
                                        ),
                                        SizeBoxH(Responsive.height * 1.5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GalleryOrCameraWidget(
                                              icon: AppImages.cameraIcon,
                                              title: "Camera",
                                              onTap: () {
                                                settingsProvider
                                                    ?.changeProfilePhoto(
                                                        false, context);
                                              },
                                            ),
                                            GalleryOrCameraWidget(
                                              icon: AppImages.galleryIcon,
                                              title: "Gallery",
                                              onTap: () {
                                                settingsProvider
                                                    ?.changeProfilePhoto(
                                                        true, context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Consumer<SettingsProvider>(
                                  builder: (context, settingsProvider, _) {
                                    return settingsProvider.isUpdateProfile &&
                                            settingsProvider.thumbnailImage ==
                                                null
                                        ? CachedImageWidget(
                                            imageUrl: settingsProvider
                                                    .getProfileData
                                                    .profile
                                                    ?.profilePicture ??
                                                '',
                                            height: Responsive.height * 12,
                                            width: Responsive.height * 12,
                                          )
                                        : settingsProvider.thumbnailImage ==
                                                null
                                            ? Image.asset(
                                                AppImages.avathar,
                                                height: 110,
                                              )
                                            : settingsProvider
                                                        .imageUrlForUpload ==
                                                    ''
                                                ? const SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                  )
                                                : Image.network(
                                                    settingsProvider
                                                        .imageUrlForUpload,
                                                    fit: BoxFit.cover,
                                                    width:
                                                        Responsive.width * 24.5,
                                                    height:
                                                        Responsive.height * 12,
                                                  );
                                  },
                                ),
                              ),
                              Positioned(
                                right: 8,
                                bottom: 4,
                                child: CircleAvatar(
                                  radius: 18,
                                  child: Image.asset(
                                    AppImages.profileAddImageIcon,
                                    height: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizeBoxH(30),
                      CustomTextWidgets(
                        text: 'First name',
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                      ),
                      const SizeBoxH(10),
                      CustomTextFormFieldWidget(
                        controller: authProvider.profileFilenameController,
                        hintText: 'First name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the First name';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizeBoxH(20),
                      CustomTextWidgets(
                        text: 'User name',
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                      ),
                      const SizeBoxH(10),
                      CustomTextFormFieldWidget(
                        controller: authProvider.profileUserNameController,
                        hintText: 'username(unique)',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizeBoxH(20),
                      CustomTextWidgets(
                        text: 'Email Address',
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                      ),
                      const SizeBoxH(10),
                      Consumer<AuthProviders>(
                        builder: (context, authProvider, child) {
                          return CustomTextFormFieldWidget(
                            readOnly: settingsProvider?.isUpdateProfile == true
                                ? false
                                : authProvider.isAuthUsingEmail == true
                                    ? true
                                    : false,
                            controller: authProvider.isLoginResendOtp == false
                                ? authProvider.signupEmailTextEditingController
                                : authProvider
                                    .signingEmailTextEditingController,
                            validator: (value) {
                              if (settingsProvider?.isUpdateProfile == true) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a email';
                                } else {
                                  return null;
                                }
                              }
                              return null;
                            },
                            hintText: email ??
                                (authProvider.isLoginResendOtp == false
                                    ? authProvider
                                            .signupEmailTextEditingController
                                            .text
                                            .isNotEmpty
                                        ? authProvider
                                            .signupEmailTextEditingController
                                            .text
                                        : "Enter your email"
                                    : authProvider
                                            .signingEmailTextEditingController
                                            .text
                                            .isNotEmpty
                                        ? authProvider
                                            .signingEmailTextEditingController
                                            .text
                                        : "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          );
                        },
                      ),
                      const SizeBoxH(20),
                      CustomTextWidgets(
                        text: 'Phone number',
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                      ),
                      const SizeBoxH(10),
                      Consumer<AuthProviders>(
                        // selector: (p0, p1) => p1.dialCodeForProfile,
                        builder: (context, provider, child) => SizedBox(
                          height: 80,
                          child: Center(
                            child: IntlPhoneField(
                              readOnly:
                                  settingsProvider?.isUpdateProfile == true
                                      ? false
                                      : authProvider.isAuthUsingEmail == true
                                          ? false
                                          : authProvider.isAuthUsingEmail ==
                                                      false &&
                                                  email?.isNotEmpty == true
                                              ? false
                                              : true,
                              keyboardType: TextInputType.number,
                              controller: authProvider
                                  .signupPhoneNumberTextEditingController,
                              decoration: InputDecoration(
                                hintText: context
                                        .read<AuthProviders>()
                                        .signupPhoneNumberTextEditingController
                                        .text
                                        .isEmpty
                                    ? 'Enter your phone'
                                    : context
                                        .read<AuthProviders>()
                                        .signupPhoneNumberTextEditingController
                                        .text,
                                // : context
                                //     .read<AuthProviders>()
                                //     .signupPhoneNumberTextEditingController
                                //     .text,
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(
                                        color: AppConstants.appBorderColor,
                                        width: 1)),
                                disabledBorder: InputBorder.none,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppConstants.appBorderColor,
                                      width: 1),
                                ),
                              ),
                              initialCountryCode:
                                  provider.dialCountryForProfile,
                              onCountryChanged: (value) {
                                if (authProvider.isAuthUsingEmail == true ||
                                    settingsProvider?.isUpdateProfile == true) {
                                  context
                                      .read<AuthProviders>()
                                      .getPhoneNumberFromCountryCodeFn(
                                          countryCode: value.code,
                                          dialCode: "+${value.dialCode}");
                                }
                              },
                              onSubmitted: (p0) {
                              },
                              onChanged: (phone) {
                                if (authProvider.isAuthUsingEmail == true ||
                                    settingsProvider?.isUpdateProfile == true) {
                                  context
                                      .read<AuthProviders>()
                                      .getPhoneNumberFn(
                                          countryCode: phone.countryISOCode,
                                          phone: phone.number,
                                          dialCode: phone.countryCode);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizeBoxH(20),
                      CustomTextWidgets(
                        text: 'Address',
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                      ),
                      const SizeBoxH(10),
                      CustomTextFormFieldWidget(
                        controller: authProvider.profileAddressController,
                        hintText: 'Address',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an Address';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizeBoxH(20),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Responsive.width * 45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextWidgets(
                                    text: 'City',
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                  ),
                                  const SizeBoxH(10),
                                  CustomTextFormFieldWidget(
                                    keyboardType: TextInputType.text,
                                    controller:
                                        authProvider.profileCityController,
                                    hintText: 'City',
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a City';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Responsive.width * 45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextWidgets(
                                    text: 'State',
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                  ),
                                  const SizeBoxH(10),
                                  CustomTextFormFieldWidget(
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    controller:
                                        authProvider.profileStateController,
                                    hintText: 'State',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a State';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizeBoxH(20),
                      CustomTextWidgets(
                        text: 'Pincode/Zip',
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                      ),
                      const SizeBoxH(10),
                      CustomTextFormFieldWidget(
                        controller: authProvider.profilePinoleController,
                        hintText: 'Pincode/Zip',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Pincode/Zip';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizeBoxH(20),
                      authProvider.isAuthUsingEmail == false
                          ? SizedBox(
                              child: Selector<SettingsProvider, bool>(
                              selector: (p0, p1) => p1.isUpdateProfile,
                              builder: (context, value, child) => value
                                  ? const SizedBox.shrink()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextWidgets(
                                          text: 'Password',
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                        ),
                                        const SizeBoxH(10),
                                        CustomTextFormFieldWidget(
                                          controller: authProvider
                                              .signupPasswordTextEditingController,
                                          hintText: 'Password',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a Password';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        const SizeBoxH(20),
                                        CustomTextWidgets(
                                          text: 'Confirm Password',
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                height: 0,
                                              ),
                                        ),
                                        const SizeBoxH(10),
                                        CustomTextFormFieldWidget(
                                          controller: authProvider
                                              .signupConfirmPasswordTextEditingController,
                                          hintText: 'Confirm Password',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your confirm password';
                                            } else if (value !=
                                                authProvider
                                                    .signupPasswordTextEditingController
                                                    .text) {
                                              return 'Passwords do not match';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        const SizeBoxH(20),
                                      ],
                                    ),
                            ))
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Consumer<AuthProviders>(
          builder: (context, authProvider, child) => Card(
            shadowColor: AppConstants.appMainGreyColor,
            margin: const EdgeInsets.only(
              bottom: 0,
            ),
            // shadowColor: Colors.grey,
            shape: const RoundedRectangleBorder(),
            elevation: 0,
            child: SizedBox(
              width: Responsive.width * 100,
              height: 70,
              // decoration: const BoxDecoration(
              //     border: Border(
              //         top: BorderSide(
              //             color: AppConstants.appBorderColor, width: .5))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CommonButton(
                  btnName: settingsProvider?.isUpdateProfile == true
                      ? 'Submit'
                      : "Next",
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      if (settingsProvider?.imageUrlForUpload == '') {
                        toast(
                          context,
                          title: 'Please add your profile photo',
                          duration: 2,
                          backgroundColor: AppConstants.red,
                        );
                      } else if (authProvider
                          .signupPhoneNumberTextEditingController
                          .text
                          .isEmpty) {
                        toast(context,
                            backgroundColor: Colors.red,
                            title: 'Please add your number');
                      } else {
                        if (settingsProvider?.isUpdateProfile == true) {
                          settingsProvider?.updateProfileFun(context: context);
                        } else {
                          String? email =
                              FirebaseAuth.instance.currentUser?.email;
                          if (email != null) {
                            context
                                .read<AuthProviders>()
                                .signupEmailTextEditingController
                                .text = email;
                          }
                          authProvider.createProfileFun(context: context);
                        }
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GalleryOrCameraWidget extends StatelessWidget {
  final String icon;
  final String title;
  final void Function() onTap;
  const GalleryOrCameraWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 50,
          ),
          const SizeBoxH(10),
          CustomTextWidgets(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
            text: title,
          ),
        ],
      ),
    );
  }
}
