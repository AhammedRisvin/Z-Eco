import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/cart/view%20model/cart_provider.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../widget/address_container.dart';

class DeliverToScreen extends StatelessWidget {
  const DeliverToScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        flexibleSpace: CustomAppBarWidget(
          title: "Deliver to",
          isLeadingIconBorder: true,
          onTap: () {
            context.pushNamed(AppRouter.yourcartscreen);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Column(
                children: [
                  const AddAddressContainer(),
                  const SizeBoxH(10),
                  Consumer<CartProvider>(builder: (context, obj, _) {
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CommonInkwell(
                            onTap: () => obj.selectAddressFnc(
                                value: index,
                                id: obj.addressList[index].id.toString()),
                            child: AddressConatiner(
                              name: obj.addressList[index].name,
                              address:
                                  '${obj.addressList[index].address}\n ${obj.addressList[index].city}   ${obj.addressList[index].pincode}  ${obj.addressList[index].state}',
                              phoneNumber: obj.addressList[index].phone,
                              addressType: obj.addressList[index].addressType,
                              index: index,
                              addressId: obj.addressList[index].id.toString(),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizeBoxH(Responsive.height * 2);
                        },
                        itemCount: obj.addressList.length);
                  })
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: Responsive.width * 100,
        height: Responsive.height * 10,
        padding: const EdgeInsets.only(
          top: 14,
          left: 16,
          right: 14,
          bottom: 16,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().isDarkMode == true
              ? AppConstants.black
              : Colors.transparent,
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F9D9D9D),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: CommonButton(
          btnName: "Set as default",
          ontap: () {
            if (context
                    .read<CartProvider>()
                    .slectedAddressList
                    .id
                    ?.isNotEmpty ==
                true) {
              context.pushNamed(AppRouter.yourcartscreen);
            } else {
              toast(context,
                  title: 'please select any one address',
                  backgroundColor: Colors.red);
            }
          },
        ),
      ),
    );
  }
}
