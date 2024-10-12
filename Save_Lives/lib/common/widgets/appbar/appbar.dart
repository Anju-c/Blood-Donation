import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:bloodapp/utilis/device/device_utility.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({super.key, this.title, this.actions,  this.showBackArrow = false, this.leadingIcon, this.leadingOnPressed});

 final Widget ? title;
 final List<Widget> ? actions;
 final bool showBackArrow ;
 final IconData ? leadingIcon;
 final VoidCallback ?  leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
    child: AppBar (
          automaticallyImplyLeading: false,
          leading: showBackArrow ? IconButton(onPressed: ()=> Get.back(),icon: const Icon(Iconsax.arrow_left),) 
          : leadingIcon!=null ?  IconButton(onPressed: leadingOnPressed,icon: Icon(leadingIcon),) : null,
          title: title,
          actions: actions,


      
      ),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}