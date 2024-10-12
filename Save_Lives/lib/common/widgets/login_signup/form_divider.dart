// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloodapp/utilis/constants/colors.dart';
import 'package:bloodapp/utilis/helpers/helper_functions.dart';

class TFormDivider extends StatelessWidget {
  const TFormDivider({
    super.key,
    required this.dividerText,
  });
  final String dividerText;
  @override
  Widget build(BuildContext context) {
      final dark =THelperFunctions.isDarkMode(context);
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Flexible(child: Divider(color: dark ? TColors.darkGrey : TColors.grey, thickness: 0.5,indent: 60,endIndent: 5,)),
       Text(dividerText, style: Theme.of(context).textTheme.bodyMedium),
       Flexible(child: Divider(color: dark ? TColors.darkGrey : TColors.grey, thickness: 0.5,indent: 5,endIndent: 60,)),
                  ],
                  );
  }
}
