// import 'package:flutter/material.dart';
// import 'package:store/utilis/constants/colors.dart';
// import 'package:store/utilis/device/device_utility.dart';
// import 'package:store/utilis/helpers/helper_functions.dart';

// class TTabBar extends StatelessWidget implements PreferredSizeWidget {
//   final List<Widget> tabs;

//   const TTabBar({ super.key, required this.tabs});

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return Material(
//       color: dark ? TColors.black : TColors.primaryColor,
//       child: TabBar(
//         tabs: tabs,
        
//         isScrollable: true,
//         tabAlignment: TabAlignment.start,
//         indicatorColor: TColors.primaryColor,
//         labelColor: dark ? TColors.white : TColors.white,
//         unselectedLabelColor: TColors.darkGrey,
//         ),
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
// }