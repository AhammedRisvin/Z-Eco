import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/utils/app_constants.dart';

import '../../../../helpers/router.dart';
import '../../../../helpers/sized_box.dart';
import '../../../../utils/app_images.dart';
import '../../view model/section_provider.dart';
import 'widgets/accessories_screen.dart';
import 'widgets/gadget_screen.dart';

class GadgetsAndAccessoriesHomeScreen extends StatefulWidget {
  final String? categoryid;
  final String? sectionName;
  const GadgetsAndAccessoriesHomeScreen(
      {super.key, this.categoryid, this.sectionName});

  @override
  State<GadgetsAndAccessoriesHomeScreen> createState() =>
      _GadgetsAndAccessoriesHomeScreenState();
}

class _GadgetsAndAccessoriesHomeScreenState
    extends State<GadgetsAndAccessoriesHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context
          .read<SectionProvider>()
          .getRecommendedProductsFn(catagoryId: widget.categoryid ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 1,
          leading: const SizedBox.shrink(),
          flexibleSpace: CustomAppBarWidget(
            onTap: () {
              context.read<SectionProvider>().selectCategoryFn(-1);
              context.pop();
            },
            isLeadingIconBorder: true,
            title: widget.sectionName ?? '',
            actions: [
              CommonInkwell(
                  onTap: () {
                    context.pushNamed(AppRouter.productSearchScreen,
                        queryParameters: {
                          'categoryid': widget.categoryid,
                        });
                    FocusScope.of(context).unfocus();
                  },
                  child: ImageIcon(AssetImage(AppImages.searchIcon))),
              const SizeBoxV(15)
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: Column(
              children: [
                const Divider(
                  height: 8,
                  thickness: .6,
                  color: AppConstants.appBorderColor,
                ),
                TabBar(
                  indicator: const BoxDecoration(
                    color: AppConstants.appPrimaryColor,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 6,
                  tabAlignment: TabAlignment.fill,
                  labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                  indicatorPadding: const EdgeInsets.only(top: 50),
                  tabs: const [
                    Tab(
                      text: 'Gadget',
                    ),
                    Tab(
                      text: 'Accessories',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            GadgetScreen(
              categoryid: widget.categoryid,
            ),
            AccessoriesScreen(
              categoryid: widget.categoryid,
            )
          ],
        ),
      ),
    );
  }
}
