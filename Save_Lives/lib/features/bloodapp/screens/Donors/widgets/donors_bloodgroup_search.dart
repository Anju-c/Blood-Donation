import 'dart:convert';
import 'dart:core';
import 'package:bloodapp/common/widgets/appbar/appbar.dart';
import 'package:bloodapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bloodapp/features/bloodapp/models/donors_details.dart';
import 'package:bloodapp/utilis/constants/api_constants.dart';
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:bloodapp/utilis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:http/http.dart' as http;

class DonorListPageBlood extends StatelessWidget {


 const DonorListPageBlood( {super.key, required this.donors,
  required this.bloodgroup,
 }) ;
  final List<DonorModel> donors;
  final String bloodgroup;
   

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TAppBar(
                title:  Text('Blood Group ${bloodgroup}',style: Theme.of(context).textTheme.headlineLarge,),
               
             
              ),
              
              const SizedBox(height: 20),
             FutureBuilder<List<DonorModel>>(
                future: searchDonorsByBloodGroup(bloodgroup),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading recipients.'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No recipients found.'));
                  } else {
                    final donors = snapshot.data!;
                    print(donors);
                    return ListView.builder(
                      shrinkWrap: true,  // Allows ListView inside SingleChildScrollView
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: donors.length,
                      itemBuilder: (context, index) {
                        final donor = donors[index];
                        print(donor.firstName);
                        return Padding(
                          padding:  const EdgeInsets.only(bottom: 20.0),
                          child: TRoundedContainer(
                            width: double.infinity,
                            height: 150, // Adjust the height as per the design
                            showBorder: true,
                            backgroundColor: dark ? TColors.primaryColor : TColors.primaryColor,
                            
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                          
                                children: [
                                  // const Icon(FontAwesomeIcons.droplet, color: Color.fromARGB(255, 159, 24, 14),size:50),
                                  // const Image(image: AssetImage('assets/img/donor-removebg-preview.png'),height: 20,width: 20,),
                                  const Image(image: AssetImage('assets/img/request-removebg-preview.png'),height: 100,width: 80,),
                                  
                                  const SizedBox(width: 10),
                                  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                          
                                     children: [
                                      const Icon(Iconsax.user, color: Colors.white),
                                    Text(
                                      ' ${donor.firstName}',
                                      style: Theme.of(context).textTheme.headlineSmall?.apply(color: Colors.white),
                                    ), ],
                                  ),
                                  const SizedBox(height: 8),
                                    Row(
                          
                                     children: [
                                      const Icon(Iconsax.location, color: Colors.white),
                                    Text(
                                      ' ${donor.district} ,kerala India',
                                      style: Theme.of(context).textTheme.headlineSmall?.apply(color: Colors.white),
                                    ), ],
                                  ),
                                 
                                
                                 
                                  const SizedBox(height: 8),
                                  Row(
                          
                                     children: [
                                      const Icon(Iconsax.heart, color: Colors.white),
                                    Text(
                                      ' ${donor.bloodGroup}',
                                      style: Theme.of(context).textTheme.headlineSmall?.apply(color: Colors.white),
                                    ), ],
                                  ),
                                  const SizedBox(height: 8),
                          
                                 
                                ],
                               
                              ),
                          
                          
                               ],
                              ),
                            ),
                          ),
                        );
                        
                      },
                    );
                  }
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<DonorModel>> searchDonorsByBloodGroup(String bloodGroup) async {

    try {
       bloodGroup = Uri.encodeComponent(bloodGroup.trim()); 
      print('Searching for donors with blood group: $bloodGroup');
      final response = await http.get(Uri.parse('${APIConstants.donorsbloodApi}$bloodGroup'));

      print(response.body);

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);

        List<DonorModel> donors = jsonResponse.map((donor) => DonorModel.fromlocationJson(donor)).toList();
        if (donors.isEmpty) {
          print('No donors found with blood group: $bloodGroup');
        }

        return donors;

      } else {
        print('Error: Failed to load donors, status code: ${response.statusCode}');
        return []; // Return an empty list on error
      }
    } catch (e) {
      print('Error in _searchDonors: $e');
      return []; // Return an empty list on exception
    }
  }