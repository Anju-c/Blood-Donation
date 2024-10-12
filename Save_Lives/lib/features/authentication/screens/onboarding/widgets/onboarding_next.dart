// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:iconsax/iconsax.dart';

// Project imports:
import 'package:bloodapp/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:bloodapp/utilis/device/device_utility.dart';
import 'package:bloodapp/utilis/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      right: TSizes.defaultSpace,
      child: ElevatedButton(
        onPressed: (){
          OnBoardingController.instance.nextPage();
        },      
        style: ElevatedButton.styleFrom(
          backgroundColor: dark ? TColors.primaryColor : Colors.black,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
        ),
        child: const Icon(Iconsax.arrow_right_3,),
      ),
    );
  }
}
