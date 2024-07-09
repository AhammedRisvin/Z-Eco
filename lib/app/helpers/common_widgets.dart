import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../theme/theme_provider.dart';
import '../utils/app_constants.dart';
import '../utils/prefferences.dart';
import 'dotted_border_widget.dart';
import 'sized_box.dart';

class CustomTextWidgets extends StatelessWidget {
  final TextStyle? textStyle;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLines;

  final String text;

  const CustomTextWidgets({
    super.key,
    required this.textStyle,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.textAlign = TextAlign.start,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
        text,
        style: textStyle);
  }
}

class CommonButton extends StatelessWidget {
  final void Function()? ontap;
  final String btnName;
  final double horizontal;
  final Color bgColor;
  final double? width;
  final double? fontSize;
  const CommonButton(
      {super.key,
      required this.btnName,
      required this.ontap,
      this.horizontal = 0.0,
      this.bgColor = AppConstants.appPrimaryColor,
      this.fontSize,
      this.width});

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        width: width ?? Responsive.width * 100,
        height: 53,
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            btnName,
            style: TextStyle(
              color: AppConstants.white,
              fontSize: fontSize ?? 18,
              fontWeight: FontWeight.w600,
              height: 0.08,
              letterSpacing: 0.72,
            ),
          ),
        ),
      ),
    );
  }
}

class CommonButtonWithIcon extends StatelessWidget {
  final void Function()? ontap;
  final Widget widget;
  final double horizontal;
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  const CommonButtonWithIcon({
    super.key,
    required this.ontap,
    this.horizontal = 0.0,
    required this.widget,
    required this.height,
    required this.width,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: widget,
              ),
              const SizedBox(
                width: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonInkwell extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final double? borderRadius;
  final Color? splashColor;
  const CommonInkwell(
      {super.key,
      required this.child,
      required this.onTap,
      this.borderRadius,
      this.splashColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      splashColor: splashColor ?? Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      focusColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}

class CustomAppBarWidget extends StatelessWidget {
  final String title;
  final bool isLeadingIconBorder;
  final List<Widget>? actions;

  final AssetImage? appBarIcon;
  final Function()? onTap;

  const CustomAppBarWidget({
    this.isLeadingIconBorder = false,
    this.appBarIcon,
    this.actions,
    this.title = "",
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) => AppBar(
          actions: actions,
          leading: isLeadingIconBorder == true
              ? IconButton(
                  onPressed: onTap ??
                      () {
                        context.pop();
                      },
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 12),
                  child: CommonInkwell(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      width: 51,
                      height: 41,
                      decoration: ShapeDecoration(
                        color: AppPref.isDark == true
                            ? AppConstants.containerColor
                            : AppConstants.white,
                        shape: RoundedRectangleBorder(
                          side: AppPref.isDark == true
                              ? BorderSide.none
                              : const BorderSide(
                                  width: 1,
                                  color: Color(0xFFDCE4F2),
                                ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
          leadingWidth: isLeadingIconBorder == true ? 35 : 55,
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
          )),
    );
  }
}

class CustomTextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final bool isobsecureTrue;
  final bool isSuffixShow;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  const CustomTextFormFieldWidget(
      {super.key,
      required this.controller,
      this.maxLines = 1,
      this.keyboardType,
      required this.hintText,
      this.prefix,
      this.suffix,
      this.validator,
      this.textInputAction,
      this.isobsecureTrue = false,
      this.readOnly = false,
      this.isSuffixShow = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      textInputAction: textInputAction,
      obscureText: isobsecureTrue,
      keyboardType: keyboardType,
      validator: validator,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        prefixIcon: prefix,
        hintText: hintText,
        suffixIcon: suffix,
      ),
    );
  }
}

class AddAddressContainer extends StatelessWidget {
  const AddAddressContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: () {
        context.pushNamed(AppRouter.addaddressscreen);
      },
      child: DottedBorder(
        gap: 5.0,
        radius: 7,
        color: const Color(0xFF2F4EFF),
        strokeWidth: 1.4,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: Responsive.width * 100,
          height: Responsive.height * 7,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Image.asset(AppImages.checkoutAddAddress),
              ),
              const SizedBox(width: 10),
              CustomTextWidgets(
                text: 'Add address',
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFF2F4EFF),
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w500,
                      height: 0.11,
                      letterSpacing: 0.50,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BorderRadiusGeometry? borderRadius;
  const CachedImageWidget(
      {super.key,
      required this.imageUrl,
      this.height = 0,
      this.width = 0,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Center(
        child: SizedBox(
          height: height > Responsive.height * 50 ? 35 : height,
          width: width > Responsive.height * 50 ? 35 : width,
          child: const Center(
            child: CircularProgressIndicator(
              color: AppConstants.appPrimaryColor,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        return Image.asset(AppImages.paymentFailed404, fit: BoxFit.cover);
      },
    );
  }
}

bool _isToastShowing = false;
void toast(
  BuildContext context, {
  String? title,
  int duration = 2,
  Color? backgroundColor,
}) {
  if (_isToastShowing) return;

  _isToastShowing = true;

  final scaffold = ScaffoldMessenger.of(context);
  final mediaQuery = MediaQuery.of(context);
  final bool isKeyboardOpen = mediaQuery.viewInsets.bottom > 0.0;

  scaffold
      .showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          duration: Duration(seconds: duration),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Container(
            height: Responsive.height * 3,
            width: Responsive.width * 90,
            alignment: Alignment.center,
            child: Text(
              title ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: isKeyboardOpen ? mediaQuery.viewInsets.bottom : 15.0,
            left: 8.0,
            right: 8.0,
          ),
        ),
      )
      .closed
      .then((reason) {
    _isToastShowing = false;
  });
}

Future<dynamic> successPopUp({
  required BuildContext context,
  required String title,
  required String content,
  required void Function()? ontap,
  required String image,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          height: Responsive.height * 50,
          width: Responsive.width * 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 100,
                width: 100,
              ),
              const SizeBoxH(20),
              CustomTextWidgets(
                text: title,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      height: 0.05,
                    ),
              ),
              const SizeBoxH(20),
              CustomTextWidgets(
                text: content,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color(0xFF8390A1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizeBoxH(20),
              CommonButton(
                btnName: "Back",
                ontap: ontap,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void navigateToCategoryScreenBasedOnSectionFn(
    {required String sectionName,
    required BuildContext context,
    required sectionId}) {
  if (sectionName == "Furniture") {
    context.pushNamed(AppRouter.furnitureCategoryScreen,
        queryParameters: {'categoryid': sectionId, 'sectionName': sectionName});
  } else if (sectionName == 'Deals') {
    context.pushNamed(AppRouter.dealsScreen,
        queryParameters: {'categoryid': sectionId, 'sectionName': sectionName});
  } else if (sectionName == "Mobiles") {
    context.pushNamed(AppRouter.mobileCategoryScreen,
        queryParameters: {'categoryid': sectionId, 'sectionName': sectionName});
  } else if (sectionName == "Gadget & Accessories") {
    context.pushNamed(AppRouter.gadgetsAndAccessoriesHomeScreen,
        queryParameters: {'categoryid': sectionId, 'sectionName': sectionName});
  } else {
    context.pushNamed(AppRouter.sectionHomeScreen,
        queryParameters: {'categoryid': sectionId, 'sectionName': sectionName});
  }
}

class NoProductWidget extends StatelessWidget {
  const NoProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.height * 70,
      width: Responsive.width * 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.noProductImage,
            height: 150,
          ),
          const SizeBoxH(10),
          Text(
            textAlign: TextAlign.center,
            'OOPS!! No \nProduct Found',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 24,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
