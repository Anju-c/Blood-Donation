// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bloodapp/utilis/theme/custom_themes/appbar_theme.dart';
import 'package:bloodapp/utilis/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:bloodapp/utilis/theme/custom_themes/checkbox_theme.dart';
import 'package:bloodapp/utilis/theme/custom_themes/chip_theme.dart';
import 'package:bloodapp/utilis/theme/custom_themes/elevated_buttom_theme.dart';
import 'package:bloodapp/utilis/theme/custom_themes/outlined_button_theme.dart';
import 'package:bloodapp/utilis/theme/custom_themes/text_field_theme.dart';
import 'package:bloodapp/utilis/theme/custom_themes/text_theme.dart';

// import 'package:store/utilis/theme/custom_themes/appbar_theme.dart';
// import 'package:store/utilis/theme/custom_themes/bottom_sheet_theme.dart';
// import 'package:store/utilis/theme/custom_themes/checkbox_theme.dart';
// import 'package:store/utilis/theme/custom_themes/chip_theme.dart';
// import 'package:store/utilis/theme/custom_themes/elevated_buttom_theme.dart';
// import 'package:store/utilis/theme/custom_themes/outlined_button_theme.dart';
// import 'package:store/utilis/theme/custom_themes/text_field_theme.dart';
// import 'package:store/utilis/theme/custom_themes/text_theme.dart';
// Add this import

// import 'package:store/utilis/theme/custom_themes/checkbox_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme =ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme:TTextTheme.lightTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    chipTheme: TChipTheme.lightChipTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme
  );
  static ThemeData darkTheme = ThemeData(
     useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.red[400],
    scaffoldBackgroundColor: Colors.black,
    textTheme:TTextTheme.darkTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    chipTheme: TChipTheme.darkChipTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme
  );
  
}
