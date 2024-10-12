
import 'package:flutter/material.dart';
import 'package:bloodapp/common/widgets/appbar/appbar.dart';
// import 'package:bloodapp/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/constants/text_strings.dart';


class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,style: Theme.of(context).textTheme.labelMedium!.apply(color:TColors.grey),),
            Text(
            TTexts.homeAppbarSubTitle,style: Theme.of(context).textTheme.labelMedium!.apply(color:TColors.grey),),
    
        ],
      ),
      actions:  const [
        //  TCartCounterIcon(onPressed: () {},iconColor: TColors.white,)
      
        
      ],
    );
  }
}