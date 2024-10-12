import 'dart:convert';
import 'package:bloodapp/common/widgets/appbar/appbar.dart';
import 'package:bloodapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bloodapp/features/bloodapp/models/donors_details.dart';
import 'package:bloodapp/features/bloodapp/screens/Donors/widgets/donor_details_screen.dart';
import 'package:bloodapp/features/bloodapp/screens/Donors/widgets/search_bloodgrp.dart';
import 'package:bloodapp/features/bloodapp/screens/Donors/widgets/search_loc.dart';
import 'package:bloodapp/features/bloodapp/screens/Donors/widgets/search_loc_blood.dart';
import 'package:bloodapp/utilis/constants/api_constants.dart';
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:bloodapp/utilis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

class DonorsScreen extends StatelessWidget {
  const DonorsScreen({super.key});

  // Fetch recipients from the backend API
  Future<List<DonorModel>> fetchdonors() async {
    final response = await http.get(Uri.parse(APIConstants.userdonorsApi)); // Replace with your API URL

    if (response.statusCode == 200) {
      List<dynamic> donorsJson = jsonDecode(response.body);
      return donorsJson.map((json) => DonorModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipients');
    }
  }  
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
               TAppBar(
                title:  Text('Donors',style: Theme.of(context).textTheme.headlineLarge),
                   actions: [
                  
                  PopupMenuButton<int>(
                   
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    onSelected: (item) => onSelected(context, item),
                    itemBuilder: (context) => 
                  [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text('Location Search'),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text('Blood Group Search'),
                    ),
                     const PopupMenuItem<int>(
                      value: 3,
                      child: Text('Blood Group and Location Search'),
                    ),
                  ],
                  )

                ],
              ),
              
              const SizedBox(height: 20),

              
              // FutureBuilder to fetch and display recipient details
              FutureBuilder<List<DonorModel>>(
                future: fetchdonors(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading recipients.'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No recipients found.'));
                  } else {
                    final donors = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,  // Allows ListView inside SingleChildScrollView
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: donors.length,
                      itemBuilder: (context, index) {
                        final donor = donors[index];
                        return Padding(
                          padding:  const EdgeInsets.only(bottom: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DonorDetailsScreen(donor: donor),
                                ),
                              );
                            },
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



void onSelected(BuildContext context,int item){
  switch (item)  {
    case 0:
      serachloaction(context);

      break;
    case 1:
      searchbloodgroup(context);
      break;
    case 3:
      searchDonorsByCriteria(context);
      break;
  }
}



