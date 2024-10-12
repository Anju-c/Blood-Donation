// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/constants/image_strings.dart';
import 'package:bloodapp/utilis/constants/sizes.dart';

class TSocialButtons extends StatelessWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Container(
         decoration: BoxDecoration(
           
           border: Border.all(color: TColors.grey),
           borderRadius:  BorderRadius.circular(100),
         ),
         child: IconButton(onPressed: () {}, 
         icon: const Image(
           image:AssetImage(TImages.google), 
           width: TSizes.iconMd,
           height: TSizes.iconMd,)
           ),
           ),
           const SizedBox(width: TSizes.spaceBtwItems,),
           Container(
             decoration: BoxDecoration(
               border: Border.all(color: TColors.grey),
               borderRadius:  BorderRadius.circular(100),
             ),
             child: IconButton(onPressed: () {}, 
             icon: const Image(
               image:AssetImage(TImages.facebook), 
               width: TSizes.iconMd,
               height: TSizes.iconMd,)
               ),
           ),
    
     ],
       );
  }
}
