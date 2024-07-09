import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../view model/cart_provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        flexibleSpace: CustomAppBarWidget(
          title: context.read<CartProvider>().isEditedAddress
              ? "Edit Address"
              : "Add Address",
          isLeadingIconBorder: true,
          onTap: () {
            Navigator.pop(context);
            context.read<CartProvider>().isEdittedAddressFnc(false);
            context.read<CartProvider>().addressClearFnc();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          width: Responsive.width * 100,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidgets(
                  text: 'Full name',
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                ),
                SizeBoxH(Responsive.height * 2),
                CustomTextFormFieldWidget(
                  controller: Provider.of<CartProvider>(context, listen: false)
                      .firstNameController,
                  hintText: 'Full name',
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return 'Name is required*';
                    }
                    return null;
                  },
                ),
                SizeBoxH(Responsive.height * 2),
                CustomTextWidgets(
                  text: 'Phone number',
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                ),
                SizeBoxH(Responsive.height * 2),
                Selector<CartProvider, String>(
                  selector: (p0, p1) => p1.dialCountryForAddress,
                  builder: (context, dialCountryForAddress, child) {
                    return IntlPhoneField(
                      controller:
                          Provider.of<CartProvider>(context, listen: false)
                              .phoneNumberController,
                      onCountryChanged: (value) {
                        context
                            .read<CartProvider>()
                            .getPhoneNumberFromCountryCodeAddressFn(
                                countryCode: value.code,
                                dialCode: "+${value.dialCode}");
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Phone number',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderSide: BorderSide(
                            color: AppConstants.appBorderColor,
                            width: 1,
                          ),
                        ),
                        disabledBorder: InputBorder.none,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppConstants.appBorderColor,
                            width: 1,
                          ),
                        ),
                      ),
                      initialCountryCode: dialCountryForAddress,
                      onChanged: (phone) {
                        context.read<CartProvider>().getPhoneNumberAddressFn(
                              countryCode: phone.countryISOCode,
                              phone: phone.number,
                              dialCode: phone.countryCode,
                            );
                      },
                      validator: (p0) {
                        if (p0.toString().trim().isEmpty) {
                          return 'Address is required*';
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizeBoxH(Responsive.height * 2),
                CustomTextWidgets(
                  text: 'Address type',
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                ),
                SizeBoxH(Responsive.height * 2),
                Consumer<CartProvider>(
                  builder: (context, obj, _) {
                    return Row(
                      children: [
                        CommonInkwell(
                          onTap: () => obj.addressTypeFnc(type: 1),
                          child: Row(
                            children: [
                              Icon(
                                obj.isSelected == 1
                                    ? Icons.radio_button_on
                                    : Icons.radio_button_off,
                                color: AppConstants.appPrimaryColor,
                                size: 30,
                              ),
                              SizeBoxV(Responsive.width * 2),
                              CustomTextWidgets(
                                text: 'Home',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizeBoxV(Responsive.width * 3),
                        CommonInkwell(
                          onTap: () => obj.addressTypeFnc(type: 2),
                          child: Row(
                            children: [
                              Icon(
                                obj.isSelected == 2
                                    ? Icons.radio_button_on
                                    : Icons.radio_button_off,
                                color: AppConstants.appPrimaryColor,
                                size: 30,
                              ),
                              SizeBoxV(Responsive.width * 2),
                              CustomTextWidgets(
                                text: 'Work',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
                SizeBoxH(Responsive.height * 2),
                CustomTextWidgets(
                  text: 'Address',
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                ),
                SizeBoxH(Responsive.height * 2),
                CustomTextFormFieldWidget(
                  controller: Provider.of<CartProvider>(context, listen: false)
                      .addressController,
                  hintText: 'Address',
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return 'Address is required*';
                    }
                    return null;
                  },
                ),
                SizeBoxH(Responsive.height * 2),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidgets(
                          text: 'City',
                          textStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                        ),
                        SizeBoxH(Responsive.height * 2),
                        SizedBox(
                          width: Responsive.width * 44,
                          child: CustomTextFormFieldWidget(
                            controller: Provider.of<CartProvider>(context,
                                    listen: false)
                                .cityController,
                            hintText: 'City',
                            keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value.toString().trim().isEmpty) {
                                return 'City is required*';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    SizeBoxV(Responsive.width * 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidgets(
                          text: 'State',
                          textStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                        ),
                        SizeBoxH(Responsive.height * 2),
                        SizedBox(
                          width: Responsive.width * 44,
                          child: CustomTextFormFieldWidget(
                            controller: Provider.of<CartProvider>(context,
                                    listen: false)
                                .stateController,
                            hintText: 'State',
                            keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value.toString().trim().isEmpty) {
                                return 'State is required*';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizeBoxH(Responsive.height * 2),
                CustomTextWidgets(
                  text: 'Pincode/Zip',
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                ),
                SizeBoxH(Responsive.height * 2),
                CustomTextFormFieldWidget(
                  controller: Provider.of<CartProvider>(context, listen: false)
                      .zipCodeController,
                  hintText: 'Pincode/Zip',
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return 'Zipcode is required*';
                    }
                    return null;
                  },
                ),
              ],
            ),
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
          btnName: "Save",
          ontap: () {
            if (_formKey.currentState!.validate()) {
              if (context.read<CartProvider>().isSelected == 0) {
                toast(context,
                    title: 'Please select Address Type ',
                    backgroundColor: Colors.red);
              } else if (context
                  .read<CartProvider>()
                  .phoneNumberController
                  .text
                  .isEmpty) {
                toast(context,
                    title: 'Please enrter  Phone Number ',
                    backgroundColor: Colors.red);
              } else {
                if (context.read<CartProvider>().isEditedAddress == true) {
                  context.read<CartProvider>().editAddressFnc(
                      context: context,
                      addressId: context.read<CartProvider>().addressId);
                } else {
                  context.read<CartProvider>().postAddressFnc(context: context);
                }
              }
            }
          },
        ),
      ),
    );
  }
}
