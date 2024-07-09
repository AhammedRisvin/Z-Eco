import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../helpers/common_widgets.dart';
import '../../../../../helpers/sized_box.dart';
import '../../../../../theme/theme_provider.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/extentions.dart';
import '../../../../home/view_model/home_provider.dart';
import '../../../../widgets/view/category_circle_widget.dart';
import 'product_card_widgets.dart';

class DealsShimmerWidget extends StatelessWidget {
  const DealsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Responsive.height * 22,
                width: Responsive.width * 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.homebanner),
                        fit: BoxFit.fill)),

                // color: Colors.amber,
              ),
              SizeBoxH(Responsive.height * 2),
              CustomTextWidgets(
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                  text: 'Trendy Offers'),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: context.read<ThemeProvider>().isDarkMode == true
                          ? const Color(0xff72787e)
                          : const Color(0x99000000),
                      fontSize: 12,
                      fontFamily: AppConstants.fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                text: 'Super summer sale',
              ),
              SizeBoxH(Responsive.height * 2),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 11 / 16,
                    crossAxisCount: 5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return CategoryCircleTabWidget(
                    name: context.read<HomeProvider>().categoryNames[index],
                    radius: 30,
                    onTap: () {},
                  );
                },
              ),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 20,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                text: 'Recommended',
              ),
              const SizeBoxH(5),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: context.read<ThemeProvider>().isDarkMode == true
                          ? const Color(0xff72787e)
                          : const Color(0x99000000),
                      fontSize: 12,
                      fontFamily: AppConstants.fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                text: 'Recommended deals for you',
              ),
              SizeBoxH(Responsive.height * 2),
              SizedBox(
                height: 250,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return DealsProductWidget(
                      width: Responsive.width * 44,
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => const SizeBoxV(15),
                ),
              ),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 20,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                text: 'Maga Savings',
              ),
              const SizeBoxH(5),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: context.read<ThemeProvider>().isDarkMode == true
                          ? const Color(0xff72787e)
                          : const Color(0x99000000),
                      fontSize: 12,
                      fontFamily: AppConstants.fontFamily,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                text: 'Get the biggest discount',
              ),
              const SizeBoxH(27),
              SizedBox(
                height: Responsive.height * 12,
                child: Row(
                  children: [
                    megaOffer(context),
                    const SizeBoxV(10),
                    megaOffer(context),
                    const SizeBoxV(10),
                    megaOffer(context),
                  ],
                ),
              ),
              SizeBoxH(Responsive.height * 3),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 20,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                text: 'Special Deals',
              ),
              SizeBoxH(Responsive.height * 2),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return DealsProductWidget(
                      isSpecialDeal: true,
                      width: Responsive.width * 44,
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => const SizeBoxV(15),
                ),
              ),
              SizeBoxH(Responsive.height * 1),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 20,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                text: ' Big Saving For You',
              ),
              SizeBoxH(Responsive.height * 2),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 11 / 12.8,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const DealsProductWidget(
                    bigsavingyou: true,
                    index: 0,
                  );
                },
              ),
            ],
          ),
        ));
  }

  Expanded megaOffer(context) {
    return Expanded(
      child: Container(
        width: Responsive.width * 30,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF61B9EB),
              Color(0xFF4C7DC8),
            ],
            stops: [0.0, 1.0],
            transform: GradientRotation(49.14 * 3.141592653589793 / 180),
          ),
        ),
        child: Column(
          children: [
            CustomTextWidgets(
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: AppConstants.fontFamily,
                    fontWeight: FontWeight.w800,
                    height: 0,
                  ),
              text: '20%',
            ),
            CustomTextWidgets(
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: AppConstants.fontFamily,
                    fontWeight: FontWeight.w900,
                    height: 0,
                  ),
              text: 'OFF',
            ),
            SizeBoxH(Responsive.height * 1),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 10,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
