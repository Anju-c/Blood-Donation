// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Project imports:
import 'package:bloodapp/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:bloodapp/utilis/device/device_utility.dart';
import 'package:bloodapp/utilis/helpers/helper_functions.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight()+ 25,
      left:TSizes.defaultSpace,
      
      child: 
      SmoothPageIndicator(
        controller:controller.pageController,
        onDotClicked: controller.dotNavigationClick,
         count: 3,
         effect: ExpandingDotsEffect(
        activeDotColor: dark ? TColors.light : TColors.dark,
        dotHeight: 6, 
        
      ),
         ),
         );
  }
}

