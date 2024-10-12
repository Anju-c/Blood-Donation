// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// Project imports:
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/helpers/helper_functions.dart';

class TLoaders  {
  static hideSnackBar() {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  }
  static void warningSnackBar({required String title, String message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(20),
    icon: const Icon(Iconsax.warning_2, color: Colors.white,),
      backgroundColor: Colors.orange,
     
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  static void successSnackBar({required  title,  message = '',duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
    duration:  Duration(seconds: duration),
    margin: const EdgeInsets.all(10),
    icon: const Icon(Iconsax.check, color: Colors.white,),
      backgroundColor: Colors.orange,
     
      snackPosition: SnackPosition.BOTTOM,
    );
  }
   static void errorSnackBar({required  title, String message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(20),
    icon: const Icon(Iconsax.warning_2, color: Colors.white,),
      backgroundColor: Colors.orange,
     
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  static  customToast({required String message}) { 
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      content: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: THelperFunctions.isDarkMode(Get.context!) ? TColors.darkGrey.withOpacity(0.9) : TColors.grey.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            message,style: Theme.of(Get.context!).textTheme.labelLarge,),
        ),
      ),
      
    ),
  );
  }
}
