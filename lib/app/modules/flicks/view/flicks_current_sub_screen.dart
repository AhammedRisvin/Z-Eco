import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/flicks/view_model/flicks_controller.dart';
import 'package:zoco/app/utils/enums.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extentions.dart';
import '../widgets/current_sub_shimmer.dart';

class FlicksCurrentSubScreen extends StatefulWidget {
  const FlicksCurrentSubScreen({super.key});

  @override
  State<FlicksCurrentSubScreen> createState() => _FlicksCurrentSubScreenState();
}

class _FlicksCurrentSubScreenState extends State<FlicksCurrentSubScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FlicksController>().getFlicksActiveSubFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizeBoxH(Responsive.height * 2),
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
                    'Current Subscription ',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            SizeBoxV(Responsive.width * 4),
            Container(
              width: Responsive.width * 100,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              // color: Colors.amber,
              child: Consumer<FlicksController>(
                builder: (context, provider, child) {
                  return provider.getFlicksActiveSubStatus ==
                          GetFlicksActiveSubStatus.loading
                      ? const ActiveSubShimmer()
                      : provider.getFlicksActiveSubStatus ==
                              GetFlicksActiveSubStatus.loaded
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizeBoxV(Responsive.width * 2),
                                Text(
                                  'Current Plan',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                SizeBoxV(Responsive.width * 2),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  width: Responsive.width * 100,
                                  height: Responsive.height * 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/darkBlueRectangle.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizeBoxH(30),
                                      CustomTextWidgets(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: 25,
                                              color: AppConstants.white,
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                            ),
                                        text: provider
                                                .getFlicksActiveSubscriptionModel
                                                .activePlan
                                                ?.name ??
                                            '',
                                      ),
                                      Container(
                                        width: Responsive.width * 45,
                                        height: Responsive.height * 4,
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: ShapeDecoration(
                                          color: AppConstants.appPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Expiring Date : ${provider.formatDate(
                                              provider
                                                      .getFlicksActiveSubscriptionModel
                                                      .activePlan
                                                      ?.expiringDate ??
                                                  DateTime.now(),
                                            )}",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 12.5,
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                      ),
                                      const SizeBoxH(20),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Responsive.width * 12),
                                        child: const Divider(
                                          thickness: 1,
                                          color: Color(0xff172159),
                                        ),
                                      ),
                                      const SizeBoxH(10),
                                      ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: provider
                                                .getFlicksActiveSubscriptionModel
                                                .activePlan
                                                ?.description
                                                ?.length ??
                                            0,
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) =>
                                            SizeBoxH(Responsive.height * 1),
                                        itemBuilder: (context, index2) {
                                          var descriptionData = provider
                                              .getFlicksActiveSubscriptionModel
                                              .activePlan
                                              ?.description?[index2];
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                AppImages.tickImage,
                                                height: 30,
                                              ),
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
                                                        fontSize: 11,
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 0,
                                                      ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : const Text("Something  Went Wrong");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
