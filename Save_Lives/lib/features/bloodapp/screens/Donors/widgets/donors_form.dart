// import 'package:bloodapp/common/widgets/appbar/appbar.dart';
import 'package:bloodapp/common/widgets/appbar/appbar.dart';
import 'package:bloodapp/features/bloodapp/controllers/Donors/donors_controller.dart';
import 'package:bloodapp/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:bloodapp/utilis/constants/sizes.dart';

import 'package:bloodapp/utilis/helpers/helper_functions.dart';
import 'package:bloodapp/utilis/validators/validation.dart';

class TDonorsForm extends StatelessWidget {
  const TDonorsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(DonorsController());
    
    String? selectedGender;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
               TAppBar(
                title: Text('Donor Information',style: Theme.of(context).textTheme.headlineMedium,),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    // Blood Donors Group
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    DropdownButtonFormField<String>(

                      validator: (value) => TValidator.validateEmptyText(value, 'Blood Donor Group'),
                      decoration: const InputDecoration(
                        hintText: 'Blood Donor Group',
                      ),
                      items: <String>['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle blood group selection
                        controller.bloodGroupController.text = newValue!;
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Gender
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      validator: (value) => TValidator.validateEmptyText(value, 'Gender'),
                      decoration: const InputDecoration(
                        hintText: 'Gender',
                      ),
                      items: <String>['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        selectedGender = newValue; 
                        controller.genderController.text = selectedGender!;
                        // Handle gender selection
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    //State
                         TextFormField(
                          controller: controller.stateController,
                      validator: (value) => TValidator.validateEmptyText(value, 'Pin Code'),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'State',
                        prefixIcon: Icon(Iconsax.location),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                      TextFormField(
                          controller: controller.districtController,

                      validator: (value) => TValidator.validateEmptyText(value, 'Pin Code'),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'District',
                        prefixIcon: Icon(Iconsax.location),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Pin Code
                    TextFormField(
                      controller: controller.pinCodeController,
                      validator: (value) => TValidator.validateEmptyText(value, 'Pin Code'),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Pin Code',
                        prefixIcon: Icon(Iconsax.location),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Address
                    TextFormField(
                      controller: controller.addressController,
                      validator: (value) => TValidator.validateEmptyText(value, 'Address'),
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Address',
                        prefixIcon: Icon(Iconsax.home),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Contact Number
                    TextFormField(
                      controller: controller.contactNumberController,
                      validator: (value) => TValidator.validatePhoneNumber(value),
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Contact Number',
                        prefixIcon: Icon(Iconsax.call),
                      ),
                    ),
                    

                    
                   
                    const SizedBox(height: TSizes.spaceBtwSections),

                    
                    

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                         await controller.addDonor();
                          Get.to(const NavigationMenu());
                        },
                        child: const Text('Submit Donor Information'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
