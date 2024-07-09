import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/modules/cart/view%20model/cart_provider.dart';
import 'package:zoco/app/theme/theme_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';

class AddressConatiner extends StatelessWidget {
  final String? name;
  final String? addressType;

  final String? phoneNumber;

  final String? address;
  final int index;
  final String addressId;

  const AddressConatiner({
    this.address,
    this.addressType,
    this.name,
    this.phoneNumber,
    required this.index,
    required this.addressId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: index == context.read<CartProvider>().selectAddres
              ? const BorderSide(width: 1, color: Color(0xFF2F4EFF))
              : BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                text: name ?? "Priscekila",
              ),
              Container(
                width: Responsive.width * 15,
                height: Responsive.height * 3,
                decoration: BoxDecoration(
                    color: const Color(0xff2f4eff).withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(40))),
                alignment: Alignment.center,
                child: CustomTextWidgets(
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                  text: addressType ?? "Home",
                ),
              )
            ],
          ),
          SizeBoxH(Responsive.height * 3),
          CustomTextWidgets(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8390A1),
                ),
            text: address ??
                "3711 Spring Hill Rd undefined Tallahassee,\n Nevada 52874 United States",
          ),
          SizeBoxH(Responsive.height * 3),
          CustomTextWidgets(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8390A1),
                ),
            text: phoneNumber ?? "+99 1234567890",
          ),
          SizeBoxH(Responsive.height * 3),
          Row(
            children: [
              CommonInkwell(
                onTap: () {
                  context
                      .read<CartProvider>()
                      .selectAddressFnc(value: index, id: addressId);
                  context.read<CartProvider>().addAddresstextfield();
                  context.read<CartProvider>().isEdittedAddressFnc(true);
                  context.pushNamed(AppRouter.addaddressscreen);
                },
                child: Container(
                  width: 77,
                  height: 41,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF2F4EFF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x2B0074DF),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextWidgets(
                        text: 'Edit',
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: AppConstants.white,
                                  fontSize: 14,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w500,
                                  height: 0.13,
                                  letterSpacing: 0.50,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
              SizeBoxV(Responsive.width * 6),
              CommonInkwell(
                onTap: () {
                  context.read<CartProvider>().deleteAddressFnc(
                        addressId: addressId,
                      );
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: context.watch<ThemeProvider>().isDarkMode == true
                        ? AppConstants.black
                        : Colors.transparent,
                    shape: const OvalBorder(),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.delete_outline),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
