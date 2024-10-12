// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bloodapp/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:bloodapp/utilis/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned( 
      top:TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child:
      TextButton(onPressed: (){
        OnBoardingController.instance.skipPage();
      }, 
      child: const Text('Skip')));
  }
}
