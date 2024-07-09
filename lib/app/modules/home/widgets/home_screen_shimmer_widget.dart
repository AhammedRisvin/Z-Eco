import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../helpers/sized_box.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../../../utils/prefferences.dart';
import '../view_model/home_provider.dart';

class HomeScreenShimmerWidget extends StatelessWidget {
  HomeScreenShimmerWidget({super.key});
  final baseColor = Colors.white;
  final highlightColor = Colors.grey.withOpacity(0.1);
  final darkbaseColor = const Color(0xff161616);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Selector<ThemeProvider, bool>(
            selector: (p0, p1) => p1.isDarkMode,
            builder: (context, isDarkMode, child) => Scaffold(
                    body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Column(
                            children: [
                              //AppBar First row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor:
                                        isDarkMode ? darkbaseColor : baseColor,
                                    highlightColor: highlightColor,
                                    child: Container(
                                      height: 35,
                                      width: 120,
                                      margin: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 12,
                                        bottom: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppConstants.black,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: isDarkMode
                                              ? darkbaseColor
                                              : baseColor,
                                          highlightColor: highlightColor,
                                          child: Container(
                                            height: 31,
                                            width: 31,
                                            decoration: BoxDecoration(
                                                color: AppPref.isDark == true
                                                    ? AppConstants
                                                        .containerColor
                                                    : AppConstants.white,
                                                border: Border.all(
                                                    color:
                                                        AppPref.isDark == true
                                                            ? Colors.transparent
                                                            : AppConstants
                                                                .appBorderColor,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                          ),
                                        ),
                                        const SizeBoxV(10),
                                        Shimmer.fromColors(
                                          baseColor: isDarkMode
                                              ? darkbaseColor
                                              : baseColor,
                                          highlightColor: highlightColor,
                                          child: Container(
                                            height: 31,
                                            width: 31,
                                            decoration: BoxDecoration(
                                                color: AppPref.isDark == true
                                                    ? AppConstants
                                                        .containerColor
                                                    : AppConstants.white,
                                                border: Border.all(
                                                    color:
                                                        AppPref.isDark == true
                                                            ? Colors.transparent
                                                            : AppConstants
                                                                .appBorderColor,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                          ),
                                        ),
                                        const SizeBoxV(10)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // //search
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor:
                                        isDarkMode ? darkbaseColor : baseColor,
                                    highlightColor: highlightColor,
                                    child: Container(
                                      width: Responsive.width * 78,
                                      height: 44,
                                      decoration: BoxDecoration(
                                          color: AppPref.isDark == true
                                              ? AppConstants.containerColor
                                              : AppConstants.white,
                                          border: Border.all(
                                              color: AppPref.isDark == true
                                                  ? Colors.transparent
                                                  : AppConstants.appBorderColor,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                  const SizeBoxV(10),
                                  Shimmer.fromColors(
                                    baseColor:
                                        isDarkMode ? darkbaseColor : baseColor,
                                    highlightColor: highlightColor,
                                    child: Container(
                                      height: 44,
                                      width: 44,
                                      decoration: ShapeDecoration(
                                        color: isDarkMode
                                            ? Colors.transparent
                                            : AppConstants.white,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFDCE4F2)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizeBoxH(8),
                              Shimmer.fromColors(
                                baseColor:
                                    isDarkMode ? darkbaseColor : baseColor,
                                highlightColor: highlightColor,
                                child: Container(
                                  width: Responsive.width * 100,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: AppPref.isDark == true
                                          ? AppConstants.containerColor
                                          : AppConstants.white,
                                      border: Border.all(
                                          color: AppPref.isDark == true
                                              ? Colors.transparent
                                              : AppConstants.appBorderColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizeBoxH(20),
                        Shimmer.fromColors(
                            baseColor: isDarkMode ? darkbaseColor : baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                color: AppPref.isDark == true
                                    ? AppConstants.containerColor
                                    : AppConstants.white,
                                border: Border.all(
                                    color: AppPref.isDark == true
                                        ? Colors.transparent
                                        : AppConstants.appBorderColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        const SizeBoxH(15),
                        Shimmer.fromColors(
                          baseColor: isDarkMode ? darkbaseColor : baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            width: Responsive.width * 30,
                            height: 15,
                            decoration: BoxDecoration(
                                color: isDarkMode == true
                                    ? AppConstants.containerColor
                                    : AppConstants.white,
                                border: Border.all(
                                    color: isDarkMode == true
                                        ? Colors.transparent
                                        : AppConstants.appBorderColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        const SizeBoxH(15),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: Responsive.height * 0.085,
                            crossAxisCount: 5,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Shimmer.fromColors(
                                  baseColor:
                                      isDarkMode ? darkbaseColor : baseColor,
                                  highlightColor: highlightColor,
                                  child: CircleAvatar(
                                    backgroundColor: isDarkMode
                                        ? Colors.transparent
                                        : AppConstants.white,
                                    radius: 30,
                                    child: Container(
                                      height: 57,
                                      width: 57,
                                      decoration: BoxDecoration(
                                          color: isDarkMode == true
                                              ? AppConstants.containerColor
                                              : AppConstants.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Shimmer.fromColors(
                                  baseColor:
                                      isDarkMode ? darkbaseColor : baseColor,
                                  highlightColor: highlightColor,
                                  child: Container(
                                    width: Responsive.width * 25,
                                    height: 7,
                                    decoration: BoxDecoration(
                                        color: isDarkMode == true
                                            ? AppConstants.containerColor
                                            : AppConstants.white,
                                        border: Border.all(
                                            color: isDarkMode == true
                                                ? Colors.transparent
                                                : AppConstants.appBorderColor,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        Shimmer.fromColors(
                          baseColor: isDarkMode ? darkbaseColor : baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            width: Responsive.width * 45,
                            height: 15,
                            decoration: BoxDecoration(
                                color: isDarkMode == true
                                    ? AppConstants.containerColor
                                    : AppConstants.white,
                                border: Border.all(
                                    color: isDarkMode == true
                                        ? Colors.transparent
                                        : AppConstants.appBorderColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Shimmer.fromColors(
                          baseColor: isDarkMode ? darkbaseColor : baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            width: Responsive.width * 30,
                            height: 8,
                            decoration: BoxDecoration(
                                color: isDarkMode == true
                                    ? AppConstants.containerColor
                                    : AppConstants.white,
                                border: Border.all(
                                    color: isDarkMode == true
                                        ? Colors.transparent
                                        : AppConstants.appBorderColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 250,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: const BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.transparent,
                                  )
                                ]),
                                width: Responsive.width * 44,
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: isDarkMode
                                              ? darkbaseColor
                                              : baseColor,
                                          highlightColor: highlightColor,
                                          child: Container(
                                            width: Responsive.width * 44,
                                            height: 112,
                                            decoration: BoxDecoration(
                                              color: isDarkMode == true
                                                  ? AppConstants.containerColor
                                                  : AppConstants.white,
                                              border: Border.all(
                                                  color: isDarkMode
                                                      ? AppConstants.white
                                                      : Colors.transparent,
                                                  width: 2),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                topRight: Radius.circular(6),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: Responsive.width * 44,
                                          height: 95,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: isDarkMode == true
                                                ? AppConstants.containerColor
                                                : const Color(0xFFF9F9FB),
                                            border: Border(
                                                bottom: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(.028),
                                            )),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Shimmer.fromColors(
                                                  baseColor: isDarkMode
                                                      ? darkbaseColor
                                                      : baseColor,
                                                  highlightColor:
                                                      highlightColor,
                                                  child: Container(
                                                    width:
                                                        Responsive.width * 44,
                                                    height: 14,
                                                    decoration: BoxDecoration(
                                                        color: isDarkMode ==
                                                                true
                                                            ? AppConstants
                                                                .containerColor
                                                            : AppConstants
                                                                .white,
                                                        border: Border.all(
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : AppConstants
                                                                    .appBorderColor,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                ),
                                                const SizeBoxH(8),
                                                Shimmer.fromColors(
                                                  baseColor: isDarkMode
                                                      ? darkbaseColor
                                                      : baseColor,
                                                  highlightColor:
                                                      highlightColor,
                                                  child: Container(
                                                    width:
                                                        Responsive.width * 35,
                                                    height: 8,
                                                    decoration: BoxDecoration(
                                                        color: isDarkMode ==
                                                                true
                                                            ? AppConstants
                                                                .containerColor
                                                            : AppConstants
                                                                .white,
                                                        border: Border.all(
                                                            color: isDarkMode ==
                                                                    true
                                                                ? Colors
                                                                    .transparent
                                                                : AppConstants
                                                                    .appBorderColor,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                  ),
                                                ),
                                                const SizeBoxH(8),
                                                Row(
                                                  children: [
                                                    Shimmer.fromColors(
                                                      baseColor: isDarkMode
                                                          ? darkbaseColor
                                                          : baseColor,
                                                      highlightColor:
                                                          highlightColor,
                                                      child: Container(
                                                        width:
                                                            Responsive.width *
                                                                30,
                                                        height: 10,
                                                        decoration: BoxDecoration(
                                                            color: isDarkMode ==
                                                                    true
                                                                ? AppConstants
                                                                    .containerColor
                                                                : AppConstants
                                                                    .white,
                                                            border: Border.all(
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .transparent
                                                                    : AppConstants
                                                                        .appBorderColor,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                      ),
                                                    ),
                                                    const SizeBoxV(10),
                                                    Expanded(
                                                      child: Shimmer.fromColors(
                                                        baseColor: isDarkMode
                                                            ? darkbaseColor
                                                            : baseColor,
                                                        highlightColor:
                                                            highlightColor,
                                                        child: Container(
                                                          width:
                                                              Responsive.width *
                                                                  30,
                                                          height: 10,
                                                          decoration: BoxDecoration(
                                                              color: isDarkMode ==
                                                                      true
                                                                  ? AppConstants
                                                                      .containerColor
                                                                  : AppConstants
                                                                      .white,
                                                              border: Border.all(
                                                                  color: isDarkMode ==
                                                                          true
                                                                      ? Colors
                                                                          .transparent
                                                                      : AppConstants
                                                                          .appBorderColor,
                                                                  width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizeBoxH(8),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: 18,
                                                      color: isDarkMode
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 0, 0, 0)
                                                          : const Color
                                                              .fromARGB(255,
                                                              155, 155, 155),
                                                    ),
                                                    const SizeBoxV(5),
                                                    Shimmer.fromColors(
                                                      baseColor: isDarkMode
                                                          ? darkbaseColor
                                                          : baseColor,
                                                      highlightColor:
                                                          highlightColor,
                                                      child: Container(
                                                        width:
                                                            Responsive.width *
                                                                10,
                                                        height: 10,
                                                        decoration: BoxDecoration(
                                                            color: isDarkMode ==
                                                                    true
                                                                ? AppConstants
                                                                    .containerColor
                                                                : AppConstants
                                                                    .white,
                                                            border: Border.all(
                                                                color: isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .transparent
                                                                    : AppConstants
                                                                        .appBorderColor,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      left: Responsive.width * 35,
                                      top: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Consumer<HomeProvider>(
                                          builder: (context, value, child) =>
                                              Shimmer.fromColors(
                                            baseColor: isDarkMode
                                                ? darkbaseColor
                                                : baseColor,
                                            highlightColor: highlightColor,
                                            child: Icon(
                                              Icons.favorite_outlined,
                                              size: 22,
                                              color: isDarkMode
                                                  ? const Color.fromARGB(
                                                      255, 0, 0, 0)
                                                  : const Color.fromARGB(
                                                      255, 155, 155, 155),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 5,
                                        child: Shimmer.fromColors(
                                          baseColor: isDarkMode
                                              ? darkbaseColor
                                              : baseColor,
                                          highlightColor: highlightColor,
                                          child: Container(
                                            width: 46,
                                            height: 24,
                                            decoration: ShapeDecoration(
                                              color: isDarkMode
                                                  ? const Color.fromARGB(
                                                      255, 0, 0, 0)
                                                  : const Color.fromARGB(
                                                      255, 155, 155, 155),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(30),
                                                  bottomRight:
                                                      Radius.circular(30),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                    //     : const SizedBox.shrink(),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizeBoxV(15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
