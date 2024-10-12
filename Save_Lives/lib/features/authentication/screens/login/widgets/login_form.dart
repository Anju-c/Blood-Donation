
import 'package:bloodapp/features/authentication/controllers/login/login_controller.dart';
import 'package:bloodapp/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:bloodapp/features/authentication/screens/signup/signup.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:bloodapp/features/authentication/controllers/login/login_controller.dart';
// import 'package:bloodapp/features/authentication/screens/password_configuration/forget_password.dart';
// import 'package:bloodapp/features/authentication/screens/signup/signup.dart';

import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:bloodapp/utilis/validators/validation.dart'; 

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(LoginController());
    return Form(
      key: controller.loginformKey,
     child: Padding(
     padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
         child: Column(
           children: [
             TextFormField(
              controller: controller.emailController,
              validator: (value) {
                TValidator.validateEmail(value);
                return null;
            
              },
               decoration: const InputDecoration(
                 prefixIcon: Icon(Iconsax.direct_right),
                //  labelText: 'E-mail',
                 hintText: 'E-mail',
               ),
             ),
             const SizedBox(height: TSizes.spaceBtwInputFields,),
            //  TextFormField(

            //     controller: controller.passwordController,
            //     validator: (value) {
            //       TValidator.validateEmptyText('Password',value);
            //       return null;
            //     },
            //    decoration: const InputDecoration(
            //      prefixIcon: Icon(Iconsax.password_check),
            //     //  labelText: 'Password',
            //      hintText: 'Password',
            //      suffixIcon: Icon(Iconsax.eye_slash),
            //    ),
            //  ),

            Obx(
             () =>  TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.hidePassword.value,
                    validator: (value) => TValidator.validateEmptyText('password',value),
                   expands: false,
                   decoration:   InputDecoration(
                     hintText: 'Password',
                     prefixIcon: const Icon(Iconsax.password_check),
                     suffixIcon: IconButton(
                      onPressed: () {
                        controller.hidePassword.value = !controller.hidePassword.value;
                      },
                      icon: Icon(controller.hidePassword.value?Iconsax.eye_slash: Iconsax.eye),),
                   ),
             ),
             
           ), 
             const SizedBox(height: TSizes.spaceBtwInputFields/2,),
         
             ///Remember me and Forgot password
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     Obx( ()=> Checkbox(value: controller.rememberMe.value, onChanged: (value) {
                        controller.rememberMe.value = !controller.rememberMe.value;
                     })),
                     Text('Remember me', style: Theme.of(context).textTheme.bodyMedium),
                   ],
                 ),
                 TextButton(
                   onPressed: () {
                       Get.to(() => const ForgetPassword());
                   },
                   child: Text('Forgot password?', style: Theme.of(context).textTheme.bodyMedium),
                 ),
               ],
             ),
             const SizedBox(height: TSizes.spaceBtwSections,),
             SizedBox(
               width: double.infinity,
               child: ElevatedButton(
                 onPressed: () {
                    controller.emailAndPasswordSignIn();
                    // Get.to(() => const HomeScreen());
                    // Get.to(const NavigationMenu());
                 },
                 child: const Text('Sign In',),
               ),
             ),
             const SizedBox(height: TSizes.spaceBtwSections,),
             SizedBox(
               width: double.infinity,
               child: OutlinedButton(
                 onPressed: () {
                  Get.to(() => const SignupScreen());
                 },
                 child: const Text('Create Account',),
               ),
             ),
         ],
         ),
                    ),
                    );
  }
}

