import 'package:bloodapp/common/widgets/appbar/appbar.dart';
import 'package:bloodapp/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:bloodapp/common/widgets/images/t_rounded_image.dart';
import 'package:bloodapp/features/bloodapp/screens/Donors/widgets/donors_form.dart';
import 'package:bloodapp/features/bloodapp/screens/Recipients/widget/recipients_form.dart';


import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold (
      
      body: SingleChildScrollView
      (
        child: Column(
          children:  [
             TPrimaryHeaderContainer(
              child:Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                   const  TAppBar(),
                     Text("Save Lives, Donate Blood",style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),),
                     const TRoundedImage(imageUrl: "assets/logos/logo.png",
                     width: 250,
                     height: 200,
                     )
                     
                     
                     
                
                  ],
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0,),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                        height: 150,
                        width: 250,
                        child: ElevatedButton(onPressed: () {
                          Get.to(() => const TDonorsForm());
                        }, 
                        child: Text("Donors",style: Theme.of(context).textTheme.headlineLarge!.apply(color :Colors.white)),),),
                        const SizedBox(height: TSizes.spaceBtwItems,),
                         SizedBox(
                    height: 150,
                    width: 250,
                    child: ElevatedButton(onPressed: () {
                      Get.to(() => const TRecipientsForm());
                    }, 
                    child: Text("Recipient",style: Theme.of(context).textTheme.headlineLarge!.apply(color :Colors.white)),),),
                      ],
                    ),
                    
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    
  }
}