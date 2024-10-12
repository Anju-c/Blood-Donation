import 'dart:convert';
import 'package:bloodapp/common/widgets/appbar/appbar.dart';
import 'package:bloodapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bloodapp/features/bloodapp/models/donors_details.dart';
import 'package:bloodapp/utilis/constants/api_constants.dart';
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:bloodapp/utilis/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

class DonorListPageBloodAndLocation extends StatelessWidget {
  const DonorListPageBloodAndLocation({
    super.key,
    required this.donors,
    this.location,
    this.bloodGroup,
  });

  final List<DonorModel> donors;
  final String? location;
  final String? bloodGroup;

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
                title: Text(
                  'Donors',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<DonorModel>>(
                future: searchDonorslocBgp(location, bloodGroup),
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
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: donors.length,
                      itemBuilder: (context, index) {
                        final donor = donors[index];
                        print(donor.firstName);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TRoundedContainer(
                            width: double.infinity,
                            height: 150,
                            showBorder: true,
                            backgroundColor: dark
                                ? TColors.primaryColor
                                : TColors.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Image(
                                    image: AssetImage('assets/img/request-removebg-preview.png'),
                                    height: 100,
                                    width: 80,
                                  ),
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.apply(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Iconsax.location, color: Colors.white),
                                          Text(
                                            ' ${donor.district}, Kerala, India',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.apply(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Iconsax.heart, color: Colors.white),
                                          Text(
                                            ' ${donor.bloodGroup}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.apply(color: Colors.white),
                                          ),
                                        ],
                                      ),
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

Future<List<DonorModel>> searchDonorslocBgp(String? location, String? bloodGroup) async {
  try {
    // Initialize an empty query string
    String query = "";
    String loc = location ?? '';
    String bg = bloodGroup ?? '';
    print('Searching for donors with location: $loc and blood group: $bg');

    if (location != null && location.isNotEmpty) {
      location = location.trim();
      query += "location=$location";
    }

    if (bloodGroup != null && bloodGroup.isNotEmpty) {
      print('Searching for donors with blood group: $bloodGroup');
      // bloodGroup = Uri.encodeComponent(bloodGroup.trim());
      // Add '&' if the query is not empty (i.e., location is also being searched)
      if (query.isNotEmpty) {
        query += "&";
      }
      query += "blood_group=$bloodGroup";
    }

    print('Searching for donors with query: $query');

    // Perform the API call with the query string
    final response = await http.get(Uri.parse('${APIConstants.donorsbloodlocApi}?$query'));

    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      // Convert the JSON response to a list of DonorModel objects
      List<DonorModel> donors = jsonResponse.map((donor) => DonorModel.fromlocationJson(donor)).toList();
      
      if (donors.isEmpty) {
        print('No donors found with the provided criteria.');
      }

      return donors;

    } else {
      print('Error: Failed to load donors, status code: ${response.statusCode}');
      return []; // Return an empty list on error
    }
  } catch (e) {
    print('Error in searchDonors: $e');
    return []; // Return an empty list on exception
  }
}

