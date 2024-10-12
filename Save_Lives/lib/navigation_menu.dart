import 'package:bloodapp/features/bloodapp/screens/Donors/donors.dart';
import 'package:bloodapp/features/bloodapp/screens/Profile/profile.dart';
import 'package:bloodapp/features/bloodapp/screens/Recipients/recipient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bloodapp/features/bloodapp/screens/home/home.dart';
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/helpers/helper_functions.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});


  @override
  Widget build(BuildContext context) {
    
    final  controller = Get.put(NavigationMenuController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: controller.updateIndex,
        backgroundColor: darkMode ? Colors.black : Colors.white,
        indicatorColor: darkMode ? TColors.white.withOpacity(0.1) : TColors.black.withOpacity(0.1),
        destinations: const  [
           NavigationDestination(icon: Icon(Iconsax.home),label: 'Home',),
           NavigationDestination(icon: Icon(Iconsax.shop),label: 'Donors',),
           NavigationDestination(icon: Icon(Iconsax.heart),label: 'Recipient',),
           NavigationDestination(icon: Icon(Iconsax.user),label: 'Profile',),
        ]
      )),
      body: Obx(() => controller.screens[controller.selectedIndex.value])
    );
  }
}
class NavigationMenuController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final screens = [const HomeScreen(),const DonorsScreen(),const RecipientScreen(),const ProfileScreen()];
  void updateIndex(int index) {
    selectedIndex.value = index;
  }

}