import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../view_model/auth_provider.dart';

class AuthUsingPhoneWidget extends StatelessWidget {
  const AuthUsingPhoneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizeBoxH(20),
          SizedBox(
            height: 74,
            child: Center(
                child: Selector<AuthProviders, String>(
              selector: (p0, p1) => p1.dialCountryForProfile,
              builder: (context, dialCountryForProfile, child) =>
                  IntlPhoneField(
                onCountryChanged: (value) {
                  context.read<AuthProviders>().getPhoneNumberFromCountryCodeFn(
                      countryCode: value.code, dialCode: "+${value.dialCode}");
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Phone number',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      borderSide: BorderSide(
                          color: AppConstants.appBorderColor, width: 1)),
                  disabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppConstants.appBorderColor, width: 1),
                  ),
                ),

                initialCountryCode: dialCountryForProfile,

                onChanged: (phone) {
                  context.read<AuthProviders>().getPhoneNumberFn(
                      countryCode: phone.countryISOCode,
                      phone: phone.number,
                      dialCode: phone.countryCode);
                },
              ),
            )),
          ),
          SizeBoxH(Responsive.height * 10),
        ],
      ),
    );
  }
}
