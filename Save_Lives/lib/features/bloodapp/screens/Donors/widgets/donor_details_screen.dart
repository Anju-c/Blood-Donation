import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bloodapp/features/bloodapp/models/donors_details.dart';
import 'package:bloodapp/utilis/constants/colors.dart';

class DonorDetailsScreen extends StatelessWidget {
  final DonorModel donor;

  const DonorDetailsScreen({super.key, required this.donor});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('${donor.firstName} Details'),
        backgroundColor: TColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Iconsax.user, 'Name:', donor.firstName),
            const SizedBox(height: 16),
            _buildDetailRow(Iconsax.location, 'Location:', '${donor.district}, Kerala, India'),
            const SizedBox(height: 16),
            _buildDetailRow(Iconsax.map, 'Pincode:', donor.pinCode),
            const SizedBox(height: 16),
            _buildDetailRow(Iconsax.call, 'Phone Number:', donor.contactNumber),
            const SizedBox(height: 16),
            // _buildDetailRow(Iconsax.sms, 'Email ID:', donor.),
            // const SizedBox(height: 16),
            _buildDetailRow(Iconsax.heart, 'Blood Group:', donor.bloodGroup),
            const Spacer(),
            // Optional: Button to call or send an email to the donor
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Iconsax.call),
                    label: const Text('Call Donor'),
                    onPressed: () {
                      // Implement calling functionality (e.g., launch dialer)
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Iconsax.sms),
                    label: const Text('Email Donor'),
                    onPressed: () {
                      // Implement email functionality (e.g., open email app)
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: TColors.primaryColor),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
