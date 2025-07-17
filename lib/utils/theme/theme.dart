import 'package:flutter/material.dart';
import 'package:loom_store/utils/theme/widget_themes/appbar_theme.dart';
import 'package:loom_store/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:loom_store/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:loom_store/utils/theme/widget_themes/chip_theme.dart';
import 'package:loom_store/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:loom_store/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:loom_store/utils/theme/widget_themes/text_field_theme.dart';
import 'package:loom_store/utils/theme/widget_themes/text_theme.dart';
import '../constants/colors.dart';

// C = Custom Widget """""
// ._ = private  

class CAppTheme {
  CAppTheme._(); 

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: CColors.grey,
    brightness: Brightness.light,
    primaryColor: const Color.fromARGB(255, 199, 51, 51),
    textTheme: CTextTheme.lightTextTheme,
    chipTheme: CChipTheme.lightChipTheme,
    scaffoldBackgroundColor: CColors.white,
    appBarTheme: CAppBarTheme.lightAppBarTheme,
    checkboxTheme: CCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: CBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: CElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: COutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: CColors.grey,
    brightness: Brightness.dark,
    primaryColor: CColors.primary,
    textTheme: CTextTheme.darkTextTheme,
    chipTheme: CChipTheme.darkChipTheme,
    scaffoldBackgroundColor: CColors.black,
    appBarTheme: CAppBarTheme.darkAppBarTheme,
    checkboxTheme: CCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: CBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: CElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: COutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.darkInputDecorationTheme,
  );
}
