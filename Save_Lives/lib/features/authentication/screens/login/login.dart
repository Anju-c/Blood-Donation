import 'package:bloodapp/common/styles/spacing_styles.dart';
import 'package:bloodapp/common/widgets/login_signup/form_divider.dart';
import 'package:bloodapp/common/widgets/login_signup/social_buttons.dart';
import 'package:bloodapp/features/authentication/screens/login/widgets/login_form.dart';
import 'package:bloodapp/features/authentication/screens/login/widgets/login_header.dart';
import 'package:bloodapp/utilis/constants/sizes.dart';
import 'package:bloodapp/utilis/constants/text_strings.dart';
import 'package:flutter/material.dart';
// import 'package:bloodapp/common/styles/spacing_styles.dart';
// import 'package:bloodapp/common/widgets/login_signup/form_divider.dart';
// import 'package:store/common/widgets/login_signup/social_buttons.dart';
// import 'package:store/features/authentication/screens/login/widgets/login_form.dart';
// import 'package:store/features/authentication/screens/login/widgets/login_header.dart';
// import 'package:store/utilis/constants/sizes.dart';
// import 'package:store/utilis/constants/text_strings.dart';






class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///Logo,Title, and Subtitle
              TLoginHeader(),
                ///Form
                 TLoginForm(),
               TFormDivider(dividerText: TTexts.orSignInWith,),
              SizedBox(height: TSizes.spaceBtwSections,),

              //Footer
               TSocialButtons(),
                ],
              ),
              
            
          ),
           ),
       
      );
  }
}



