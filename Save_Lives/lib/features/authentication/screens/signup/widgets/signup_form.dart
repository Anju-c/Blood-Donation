import 'package:bloodapp/features/authentication/controllers/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:bloodapp/features/authentication/controllers/signup/signup_controller.dart';

import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/helpers/helper_functions.dart';
import 'package:bloodapp/utilis/validators/validation.dart';


class TSignupForm extends StatelessWidget {
  const  TSignupForm({
    super.key,
   
  });
  @override
  Widget build(BuildContext context) {
    final bool dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Form(
       key: controller.signupFormKey,
      child: 
   
    Column(
     children: [
       Row(
         children: [
           Expanded(
             child: TextFormField(
              controller: controller.firstName,
              validator: (value) => TValidator.validateEmptyText(value, 'First Name'),
               expands: false,
               decoration:  const InputDecoration(
                 hintText: 'First Name',
                 prefixIcon: Icon(Iconsax.user),
               ),
               
             ),
           ),
           const SizedBox(width: TSizes.spaceBtwInputFields,),
           Expanded(
             child: TextFormField(
              controller: controller.lastName,
              validator: (value) => TValidator.validateEmptyText(value, 'Last Name'),
               expands: false,
               decoration:  const InputDecoration(
                 hintText: 'Last Name',
                 prefixIcon: Icon(Iconsax.user),
               ),
               
             ),
           ),
         ],
       ),
       const SizedBox(height: TSizes.spaceBtwInputFields,),
       //username
        TextFormField(
                controller: controller.username,
                validator: (value) => TValidator.validateEmptyText(value, 'User Name'),
               expands: false,
               decoration:  const InputDecoration(
                 hintText: 'User Name',
                 prefixIcon: Icon(Iconsax.user_edit),
               ),
         ),
         const SizedBox(height: TSizes.spaceBtwInputFields,),
         //email
          TextFormField(
                controller: controller.email,
                validator: (value) => TValidator.validateEmail(value),
               expands: false,
               decoration:  const InputDecoration(
                 hintText: 'Email',
                 prefixIcon: Icon(Iconsax.user_edit),
               ),
         ),
         const SizedBox(height: TSizes.spaceBtwInputFields,),
         //phone Number
           TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => TValidator.validatePhoneNumber(value),
                 expands: false,
                 decoration:  const InputDecoration(
                   hintText: 'Phone Number',
                   prefixIcon: Icon(Iconsax.call),
                 ),
           ),
           const SizedBox(height: TSizes.spaceBtwInputFields,),
           //password
           Obx(
             () => 
              TextFormField(
                    controller: controller.password,
                    obscureText: controller.hidePassword.value,
                    validator: (value) => TValidator.validatePassword(value),
                   expands: false,
                   decoration:   InputDecoration(
                     hintText: 'Password',
                     prefixIcon: const Icon(Iconsax.password_check),
                     suffixIcon: IconButton(
                      onPressed: () {
                        controller.hidePassword.value = !controller.hidePassword.value;
                      },
                      // icon: const Icon(Iconsax.eye_slash),
                      icon: Icon(controller.hidePassword.value?Iconsax.eye_slash: Iconsax.eye),
                      // ),
                   ),
             ),
             
           ), 
           ),
           const SizedBox(height: TSizes.spaceBtwInputFields,),

          
    
           //Terms and Conditions
           Row(children: [
             Obx( () => Checkbox(value: controller.checkbox.value, onChanged: (value) {
                controller.checkbox.value = value!;
             }),),
           
               const SizedBox(width: TSizes.spaceBtwItems,),
             Text.rich( 
               TextSpan(
               children: [
                 TextSpan(
                   text: 'I agree to the ',
                   style: Theme.of(context).textTheme.bodySmall,
                 ),
                 TextSpan(
                   text: 'Privacy Policy',
                   style: Theme.of(context).textTheme.bodyMedium!.apply(
                     color: dark ? TColors.white :TColors.primaryColor,
                     decoration: TextDecoration.underline,
                     decorationColor: dark ? TColors.white :TColors.primaryColor,
    
                   ),
                 ),
                 TextSpan(
                   text: ' and ',
                   style:  Theme.of(context).textTheme.bodySmall,
                 ),
                    TextSpan(
                   text: 'Terms of Use',
                   style: Theme.of(context).textTheme.bodyMedium!.apply(
                     color: dark ? TColors.white :TColors.primaryColor,
                     decoration: TextDecoration.underline,
                     decorationColor: dark ? TColors.white :TColors.primaryColor,
    
                   ),
                 ),
               ],
             ),),
             
           ],),
           const SizedBox(height: TSizes.spaceBtwInputFields,),
           ///Sign Up Button
           SizedBox(
             width: double.infinity,
             child: ElevatedButton(
               onPressed: () {
                  controller.signup();
                // Get.to(() => controller.signup());
               },
               child: const Text('Create Account',),
             ),
           ),
    
     ],
    
    ),
    );
  }
}