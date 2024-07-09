import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/orders/view%20model/order_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/router.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/enums.dart';
import '../../cart/widget/checkout_productdetails_container.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Active'),
    Tab(text: 'Completed'),
    Tab(text: 'Cancelled'),
    Tab(text: 'Returned'),
  ];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _handleTabSelection();
    });
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.index == 0) {
      log('Active');
      context
          .read<OrderProvider>()
          .getOrdersf(ordersMode: 'Placed', context: context);
    } else if (_tabController.index == 1) {
      context.read<OrderProvider>().getOrdersf(
            ordersMode: 'Delivered',
            context: context,
          );
    } else if (_tabController.index == 2) {
      context
          .read<OrderProvider>()
          .getOrdersf(ordersMode: 'Cancelled', context: context);
    } else if (_tabController.index == 3) {
      context
          .read<OrderProvider>()
          .getOrdersf(ordersMode: 'Returned', context: context);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CustomTextWidgets(
            textStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
            text: "Orders",
          ),
          bottom: TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorColor: AppConstants.appPrimaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: AppConstants.appMainGreyColor,
            labelColor: context.watch<ThemeProvider>().isDarkMode == true
                ? const Color(0xffffffff)
                : AppConstants.black,
            labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            ActiveOrdersTab(),
            CompletedOrdersTab(),
            CancelledOrdersTab(),
            ReturndOrdersTab()
          ],
        ),
      ),
    );
  }
}

class ActiveOrdersTab extends StatefulWidget {
  const ActiveOrdersTab({super.key});

  @override
  State<ActiveOrdersTab> createState() => _ActiveOrdersTabState();
}

class _ActiveOrdersTabState extends State<ActiveOrdersTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, obj, _) {
      return obj.getCartStatus == GetCartStatus.loading
          ? const OrderShimmers()
          : obj.ordersModel.response.isListNullOrEmpty()
              ? const EmptySCreen()
              : Container(
                  padding: const EdgeInsets.all(15),
                  height: Responsive.height * 100,
                  width: Responsive.width * 100,
                  child: ListView.separated(
                      itemBuilder: ((context, index) {
                        obj.itemLengthFnc(value: index);
                        var orders = obj.ordersModel.response?[index];
                        return CheckoutProductDetailsContainer(
                            isFromOrders: true,
                            isFromCompleted: false,
                            isACtive: true,
                            checkoUtData: orders,
                            currency: obj.ordersModel.currency,
                            currencyIcon: obj.ordersModel.currencySymbol,
                            titleFromOrders: orders!.returnInfo == null ||
                                    orders.returnInfo!.isNotEmpty
                                ? '${orders.returnInfo?.last.status} ${obj.convertUtcToLocalDeliveryDate('${orders.returnInfo?.last.date}')}'
                                : '${orders.shippingInfo?.last.status} ${obj.convertUtcToLocalDeliveryDate('${orders.shippingInfo?.last.date}')}');
                      }),
                      separatorBuilder: ((context, index) {
                        return SizeBoxH(Responsive.height * 2);
                      }),
                      itemCount: obj.ordersModel.response?.length ?? 0),
                );
    });
  }
}

class CompletedOrdersTab extends StatefulWidget {
  const CompletedOrdersTab({super.key});

  @override
  State<CompletedOrdersTab> createState() => _CompletedOrdersTabState();
}

class _CompletedOrdersTabState extends State<CompletedOrdersTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, obj, _) {
        return obj.getCartStatus == GetCartStatus.loading
            ? const OrderShimmers()
            : obj.ordersModel.response.isListNullOrEmpty()
                ? const EmptySCreen()
                : Container(
                    padding: const EdgeInsets.all(15),
                    height: Responsive.height * 100,
                    width: Responsive.width * 100,
                    child: ListView.separated(
                        itemBuilder: ((context, index) {
                          var orders = obj.ordersModel.response?[index];
                          return CommonInkwell(
                            onTap: () {
                              context
                                  .read<OrderProvider>()
                                  .getOrderProductDetailFnc(
                                      context: context,
                                      bookingId: orders?.bookingId ?? '',
                                      sizeId: orders?.sizeId ?? '');
                              context.pushNamed(AppRouter.orderDetailsScreen,
                                  queryParameters: {'isACtive': 'isDeliverd'});
                            },
                            child: CheckoutProductDetailsContainer(
                              isFromOrders: true,
                              isFromCompleted: true,
                              currency: obj.ordersModel.currency,
                              currencyIcon: obj.ordersModel.currencySymbol,
                              titleColor:
                                  context.watch<ThemeProvider>().isDarkMode ==
                                          true
                                      ? const Color(0xffffffff)
                                      : AppConstants.black,
                              titleFromOrders:
                                  '${orders?.shippingInfo?.last.status} ${obj.convertUtcToLocalDeliveryDate('${orders?.shippingInfo?.last.date}')}',
                              checkoUtData: orders,
                            ),
                          );
                        }),
                        separatorBuilder: ((context, index) {
                          return SizeBoxH(Responsive.height * 2);
                        }),
                        itemCount: obj.ordersModel.response?.length ?? 0),
                  );
      },
    );
  }
}

class CancelledOrdersTab extends StatefulWidget {
  const CancelledOrdersTab({super.key});

  @override
  State<CancelledOrdersTab> createState() => _CancelledOrdersTabState();
}

class _CancelledOrdersTabState extends State<CancelledOrdersTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, obj, _) {
        log("caneclled calling and loading is ${obj.getCartStatus}");
        return obj.getCartStatus == GetCartStatus.loading
            ? const OrderShimmers()
            : obj.ordersModel.response.isListNullOrEmpty()
                ? const EmptySCreen()
                : Container(
                    padding: const EdgeInsets.all(15),
                    height: Responsive.height * 100,
                    width: Responsive.width * 100,
                    child: ListView.separated(
                        itemBuilder: ((context, index) {
                          var orders = obj.ordersModel.response?[index];
                          return CommonInkwell(
                            onTap: () {
                              context
                                  .read<OrderProvider>()
                                  .getOrderProductDetailFnc(
                                    context: context,
                                    bookingId: orders?.bookingId ?? '',
                                    sizeId: orders?.sizeId ?? '',
                                  );
                              context.pushNamed(
                                AppRouter.orderDetailsScreen,
                                queryParameters: {'isACtive': 'isCancelled'},
                              );
                            },
                            child: CheckoutProductDetailsContainer(
                              isFromOrders: true,
                              isFromCompleted: false,
                              currency: obj.ordersModel.currency,
                              currencyIcon: obj.ordersModel.currencySymbol,
                              titleColor:
                                  context.watch<ThemeProvider>().isDarkMode ==
                                          true
                                      ? const Color(0xffffffff)
                                      : AppConstants.black,
                              titleFromOrders:
                                  '${orders?.shippingInfo?.last.status} ${obj.convertUtcToLocalDeliveryDate('${orders?.shippingInfo?.last.date}')}',
                              checkoUtData: orders,
                            ),
                          );
                        }),
                        separatorBuilder: ((context, index) {
                          return SizeBoxH(Responsive.height * 2);
                        }),
                        itemCount: obj.ordersModel.response?.length ?? 0),
                  );
      },
    );
  }
}

class ReturndOrdersTab extends StatefulWidget {
  const ReturndOrdersTab({super.key});

  @override
  State<ReturndOrdersTab> createState() => _ReturndOrdersTabState();
}

class _ReturndOrdersTabState extends State<ReturndOrdersTab> {
  @override
  void initState() {
    super.initState();
    // context
    //     .read<OrderProvider>()
    //     .getOrdersfn(ordersMode: 'Cancelled', context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, obj, _) {
        return obj.getCartStatus == GetCartStatus.loading
            ? const OrderShimmers()
            : obj.ordersModel.response.isListNullOrEmpty()
                ? const EmptySCreen()
                : Container(
                    padding: const EdgeInsets.all(15),
                    height: Responsive.height * 100,
                    width: Responsive.width * 100,
                    child: ListView.separated(
                        itemBuilder: ((context, index) {
                          var orders = obj.ordersModel.response?[index];
                          return CommonInkwell(
                            onTap: () {
                              context
                                  .read<OrderProvider>()
                                  .getOrderProductDetailFnc(
                                      context: context,
                                      bookingId: orders?.bookingId ?? '',
                                      sizeId: orders?.sizeId ?? '');
                              context.pushNamed(AppRouter.orderDetailsScreen,
                                  queryParameters: {'isACtive': 'isReturned'});
                            },
                            child: CheckoutProductDetailsContainer(
                              isFromOrders: true,
                              isFromCompleted: false,
                              currency: obj.ordersModel.currency,
                              currencyIcon: obj.ordersModel.currencySymbol,
                              titleColor:
                                  context.watch<ThemeProvider>().isDarkMode ==
                                          true
                                      ? const Color(0xffffffff)
                                      : AppConstants.black,
                              titleFromOrders:
                                  '${orders?.shippingInfo?.last.status} ${obj.convertUtcToLocalDeliveryDate('${orders?.shippingInfo?.last.date}')}',
                              checkoUtData: orders,
                            ),
                          );
                        }),
                        separatorBuilder: ((context, index) {
                          return SizeBoxH(Responsive.height * 2);
                        }),
                        itemCount: obj.ordersModel.response?.length ?? 0),
                  );
      },
    );
  }
}

class OrderShimmers extends StatelessWidget {
  const OrderShimmers({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      direction: ShimmerDirection.ttb,
      child: ListView.separated(
        itemCount: 3,
        separatorBuilder: (context, index) => SizeBoxH(Responsive.height * 2),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: Responsive.width * 100,
            height: Responsive.height * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
          ),
        ),
      ),
    );
  }
}

class EmptySCreen extends StatelessWidget {
  const EmptySCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: Responsive.height * 100,
      width: Responsive.width * 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.oopsDataImage),
          SizeBoxH(Responsive.height * 4),
          CustomTextWidgets(
              textAlign: TextAlign.center,
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  fontFamily: 'Plus Jakarta Sans'),
              text: 'OOPS!! No \n Order Found'),
          SizeBoxH(Responsive.height * 1.8),
          CustomTextWidgets(
              textAlign: TextAlign.center,
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: 'Plus Jakarta Sans'),
              text: 'You dont have any order')
        ],
      ),
    );
  }
}
