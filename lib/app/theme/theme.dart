import 'package:flutter/material.dart';
import 'package:zoco/app/utils/app_constants.dart';

class MyTheme {
  //Theme Dark
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    hintColor: AppConstants.darkapphintGreyColor,
    dividerColor: AppConstants.appBorderColor,
    indicatorColor: AppConstants.darkappPrimaryColor,
    primaryColorDark: AppConstants.white,
    primaryColorLight: AppConstants.appMainGreyColor,
    scaffoldBackgroundColor: AppConstants.darkbg,
    primaryColor: AppConstants.darkappPrimaryColor,
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(AppConstants.white))),
    iconTheme: const IconThemeData(color: AppConstants.white),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppConstants.darkbg,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
    ),
//AppBar Theme
    appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.darkbg,
        surfaceTintColor: Colors.transparent),
//check box
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(AppConstants.white),
      fillColor: WidgetStateProperty.all(AppConstants.darkappPrimaryColor),
    ),
//divider
    dividerTheme: const DividerThemeData(
        color: AppConstants.appBorderColor, thickness: 1),
//textformfield input decoration
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: AppConstants.appBorderColor, width: 1)),
      hintStyle: TextStyle(
        color: AppConstants.darkapphintGreyColor,
        fontSize: 16,
        fontFamily: AppConstants.fontFamily,
        fontWeight: FontWeight.w500,
        height: 0,
      ),
      contentPadding: EdgeInsets.all(12),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
              color: Color(0xFF44484E),
              width: 1)), // AppConstants.appBorderColor
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: Color(0xFF44484E), width: 1)),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF44484E), width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        borderSide: BorderSide(width: 1),
      ),
    ),

    // cardColor: const Color.fromRGBO(21, 21, 37, 1),

    // secondaryHeaderColor: const Color.fromRGBO(253, 253, 253, 1),
    splashColor: AppConstants.darkbg,
//Text theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          height: 1.2,
          fontSize: 34,
          fontWeight: FontWeight.w700,
          fontFamily: AppConstants.fontFamily,
          fontStyle: FontStyle.normal,
          color: AppConstants.white),
      displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      displaySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      headlineMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      headlineSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.white),
      titleLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontFamily: AppConstants.fontFamily,
        color: AppConstants.white,
      ),
    ),

  );


  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: AppConstants.white,
    hintColor: AppConstants.appMainGreyColor,
    dividerColor: AppConstants.appBorderColor,
    indicatorColor: AppConstants.appPrimaryColor,
    primaryColorDark: AppConstants.black,
    primaryColorLight: AppConstants.appMainGreyColor,
    primaryColor: const Color(0xFF2F4EFF),
    splashColor: AppConstants.appPrimaryColor,
    secondaryHeaderColor: Colors.black,
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(AppConstants.black))),
    iconTheme: const IconThemeData(color: AppConstants.black),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppConstants.white,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.white,
        surfaceTintColor: Colors.transparent),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(AppConstants.white),
      fillColor: WidgetStateProperty.all(AppConstants.appPrimaryColor),
    ),
    dividerTheme: const DividerThemeData(
        color: AppConstants.appBorderColor, thickness: 1),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(12),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: AppConstants.appBorderColor, width: 1)),
      hintStyle: TextStyle(
        color: AppConstants.appMainGreyColor,
        fontSize: 16,
        fontFamily: AppConstants.fontFamily,
        fontWeight: FontWeight.w500,
        height: 0,
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: AppConstants.appBorderColor, width: 1)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: AppConstants.appBorderColor, width: 1)),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppConstants.appBorderColor, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        borderSide: BorderSide(width: 1),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
          height: 1.2,
          fontSize: 34,
          fontWeight: FontWeight.w700,
          fontFamily: AppConstants.fontFamily,
          fontStyle: FontStyle.normal,
          color: AppConstants.black),
      displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      displaySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      headlineMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      headlineSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: AppConstants.fontFamily,
          color: AppConstants.black),
      titleLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontFamily: AppConstants.fontFamily,
        color: Color(0xff181C1F),
      ),
    ),
    buttonTheme: const ButtonThemeData(
        buttonColor: AppConstants.appPrimaryColor, height: 50),

  );
}
