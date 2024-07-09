import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../widgets/view/empty_screen.dart';
import '../view_model/flicks_controller.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizeBoxH(Responsive.height * 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Subscription',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 26,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: -0.52,
                  ),
            ),
          ),
          SizeBoxH(Responsive.height * 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Benefits include',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppConstants.appPrimaryColor,
                    fontSize: 14,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: -0.28,
                  ),
            ),
          ),
          SizeBoxH(Responsive.height * 12),
          SizeBoxH(Responsive.height * 5),
          Consumer<FlicksController>(
            builder: (context, provider, child) {
              return provider.getFlicksSubscriptionModel.memberships?.isEmpty ==
                          true ||
                      provider.getFlicksSubscriptionModel.memberships == null
                  ? EmptyScreenWidget(
                      text: "No Subscription Available",
                      height: Responsive.height * 50,
                      image: AppImages.fashionNodata,
                    )
                  : CarouselSlider.builder(
                      itemCount: provider
                              .getFlicksSubscriptionModel.memberships?.length ??
                          0,
                      options: CarouselOptions(
                          height: Responsive.height * 55,
                          aspectRatio: 16 / 9,
                          enableInfiniteScroll: true,
                          reverse: false,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: .8),
                      itemBuilder: (context, index, realIndex) {
                        var planData = provider
                            .getFlicksSubscriptionModel.memberships?[index];
                        return Container(
                          height: Responsive.height * 55,
                          width: Responsive.width * 80,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF030C40,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: Responsive.width * 15,
                                height: Responsive.height * 4.5,
                                padding: const EdgeInsets.all(5),
                                decoration: ShapeDecoration(
                                  color: AppConstants.appPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "${planData?.offer.toString()} %",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                ),
                              ),
                              Text(
                                planData?.name ?? "",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                              ),
                              SizedBox(
                                height: Responsive.height * 4,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 3),
                                    Text(
                                      '${planData?.currency} ${planData?.amount?.toStringAsFixed(2)}',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                    ),
                                    const SizedBox(width: 3),
                                    Opacity(
                                      opacity: 0.80,
                                      child: Text(
                                        '/ user',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Plus Jakarta Sans',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.separated(
                                itemCount: planData?.description?.length ?? 0,
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    SizeBoxH(Responsive.height * 4),
                                itemBuilder: (context, index2) {
                                  var descriptionData =
                                      planData?.description?[index2];
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(AppImages.tickImage),
                                      const SizeBoxV(8),
                                      SizedBox(
                                        width: Responsive.width * 60,
                                        child: Text(
                                          descriptionData ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontFamily: 'Plus Jakarta Sans',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                              CommonInkwell(
                                onTap: () {
                                  context.push(AppRouter.flicksPaymentScreen);
                                  provider.selectedSubPlan(planData);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Responsive.width * 55,
                                  height: Responsive.height * 6,
                                  decoration: ShapeDecoration(
                                    color: AppConstants.appPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Choose this plan',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: 'Plus Jakarta Sans',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        const SizedBox(
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: AppConstants.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
