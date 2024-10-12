// Flutter imports:

import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_navigation/src/root/get_material_app.dart';

// Project imports:
import 'package:bloodapp/bindings/general_bindings.dart';
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/theme/theme.dart';

// import 'package:store/bindings/general_bindings.dart';
// import 'package:store/features/authentication/screens/onboarding/onboarding.dart';
// import 'package:store/utilis/constants/colors.dart';
// import 'package:store/utilis/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: const Scaffold(
        backgroundColor: TColors.primaryBackground,
        body: Center(
          // child: OnBoardingScreen(),
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
