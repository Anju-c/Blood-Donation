import 'package:bloodapp/common/widgets/appbar/appbar.dart';
import 'package:bloodapp/features/bloodapp/controllers/Recipients/recipients_controller_form.dart';
import 'package:bloodapp/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:bloodapp/utilis/helpers/helper_functions.dart';
import 'package:bloodapp/utilis/validators/validation.dart';

class TRecipientsForm extends StatelessWidget {
  const TRecipientsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(RecipientController());
    
    bool isCritical = false;
    String? selectedBloodGroup;
    String? selectedUnits;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TAppBar(
                title: Text('Recipient Information',style: Theme.of(context).textTheme.headlineMedium,),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    // Blood Type
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    DropdownButtonFormField<String>(
                      validator: (value) => TValidator.validateEmptyText(value, 'Blood Type'),
                      decoration: const InputDecoration(
                        hintText: 'Select Blood Type',
                      ),
                      items: <String>['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        selectedBloodGroup = newValue;
                        controller.bloodGroupController.text = newValue!;
                      },
                    ),
                    
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Patient Name
                    TextFormField(
                      controller: controller.patientNameController,
                      validator: (value) => TValidator.validateEmptyText(value, 'Patient Name'),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Patient Name',
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Attendee Name
                    TextFormField(
                      controller: controller.attendeeNameController,
                      validator: (value) => TValidator.validateEmptyText(value, 'Attendee Name'),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Attendee Name',
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Attendee Phone Number
                    TextFormField(
                      controller: controller.attendeeContactNumberController,
                      validator: (value) => TValidator.validatePhoneNumber(value),
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Attendee Phone No.',
                        prefixIcon: Icon(Iconsax.call),
                      ),
                    ),
                    
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Required Date
                    TextFormField(
                      controller: controller.requiredDateController,
                      validator: (value) => TValidator.validateEmptyText(value, 'Required Date'),
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        hintText: 'Required Date',
                        prefixIcon: Icon(Iconsax.calendar),
                      ),
                    ),
                    
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Select Units
                    DropdownButtonFormField<String>(
                      validator: (value) => TValidator.validateEmptyText(value, 'Select Units'),
                      decoration: const InputDecoration(
                        hintText: 'Select Units',
                      ),
                      items: <String>['1', '2', '3', '4', '5']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        selectedUnits = newValue;
                        controller.selectUnitsController.text = newValue!;
                      },
                    ),
                    
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Location
                    TextFormField(
                      controller: controller.locationController,
                      validator: (value) => TValidator.validateEmptyText(value, 'Location'),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Location',
                        prefixIcon: Icon(Iconsax.location),
                      ),
                    ),
                    
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                   

                    const SizedBox(height: TSizes.spaceBtwSections),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                           await controller.addRecipient();
                          Get.to(const NavigationMenu());
                          // Handle form submission
                        },
                        child: const Text('Submit Recipient Information'),
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
