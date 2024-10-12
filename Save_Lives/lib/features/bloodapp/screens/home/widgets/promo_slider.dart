
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:bloodapp/common/widgets/custom_shapes/containers/circular_container.dart';
// import 'package:bloodapp/common/widgets/images/t_rounded_image.dart';
// // import 'package:bloodapp/features/shop/controllers/home_controller.dart';
// import 'package:bloodapp/utilis/constants/colors.dart';

// import 'package:bloodapp/utilis/constants/sizes.dart';

// class TPromoSlider extends StatelessWidget {
//   const TPromoSlider({
//     super.key, required this.banners,
//   });
//   final List<String> banners;

//   @override
//   Widget build(BuildContext context) {
//     // final controller = Get.put(HomeController());
//     return Padding(
//      padding:  const EdgeInsets.all(TSizes.defaultSpace),
//      child: Column(
//        children: [
//          CarouselSlider (
//            options: CarouselOptions(
//              viewportFraction: 1,
//              onPageChanged: (index,_) => controller.updatePageIndicator(index),
//            ),
//            items: banners.map((url) => TRoundedImage(
//             imageUrl: url,)).toList(),
//          ),
//          const SizedBox(height: TSizes.spaceBtwSections,),
//          Obx(
//            () =>  Row(
//                mainAxisSize: MainAxisSize.min,
//              children: [
//                 for (int i = 0; i < banners.length; i++)  
//                  TCircularContainer(
//                    width: 20, 
//                    height: 4,
//                    margin: const EdgeInsets.only(right: 10),
//                    backgroundColor: controller.carouselCurrentIndex.value == i ? TColors.primaryColor : TColors.grey),
//            ],
//            ),
           
//          ),
    
//        ],
//      ),
//                 );
//   }
// }