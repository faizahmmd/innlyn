import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/core/colors.dart';
import 'package:innlyn/core/models/get_otp_response.dart';
import 'package:innlyn/core/providers/auth_provider.dart';
import 'package:innlyn/core/services/notification_service.dart';
import 'package:innlyn/routers/routing_constants.dart';
import 'package:innlyn/widgets/social_sign_in_button.dart';
import 'package:innlyn/widgets/textfield.dart';
import 'package:provider/provider.dart';

import '../core/services/navigation_service.dart';
import '../widgets/button.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textEditingController = TextEditingController();
  late StreamSubscription<bool> keyboardSubscription;
  bool keyboard = false;
  bool buttonLoading = false;


  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      if(visible){
        setState(() {
          keyboard = true;
        });
      }else{
        setState(() {
          keyboard = false;
        });
      }

    });
  }

  Future getOtp()async{
    final authProvider =
    Provider.of<AuthProvider>(context, listen: false);
    try{
      setState(() {
        buttonLoading = true;
      });
     var response = await authProvider.getOtp(phoneNumber: textEditingController.text.trim());
     GetOtpResponse getOtpResponse = GetOtpResponse.fromJson(response);
     if(getOtpResponse.success??false){
       authProvider.setPhoneNumber(phone: getOtpResponse.data?.phoneNumber??'');
       authProvider.setOtp(otp: getOtpResponse.data?.verificationCode.toString()??'');

       authProvider.setDeviceToken(deviceTokenFromResponse: '9889j9j9n9mh6554f676g');
       setState(() {
         buttonLoading = false;
       });
       navigationService.navigateTo(otpVerificationScreenRoute, null);
     }else{
       setState(() {
         buttonLoading = false;
       });
       notificationService.showToast(navigationService.currentContext, getOtpResponse.message, type: NotificationType.error);
     }
    }catch(e){
      setState(() {
        buttonLoading = false;
      });
     notificationService.showToast(context, e.toString(), type: NotificationType.error);

    }
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greyLight1.withOpacity(0.7)
    ));
    return Scaffold(
      backgroundColor: pureWhite,
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            keyboard?Container():SizedBox(
              height: MediaQuery.of(context).size.height/6.7
            ),
       SvgPicture.asset('assets/icons/innlyn.svg',  width: 165,
         height: 44),
            SizedBox(
                height: MediaQuery.of(context).size.height/24
            ),
            Text(
                'Login',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: pureBlack,
                    fontSize: 36,
                    fontWeight: FontWeight.w300
                )
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height/25
            ),
            Text(
                'Login with your Phone number',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: pureBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                )
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height/30
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 43.0),
              child: CustomTextField(textEditingController: textEditingController, textSize: 13, onChanged: (value){}, hintText: 'Enter your Phone Number', onSubmit: (value) {
                FocusManager.instance.primaryFocus?.unfocus();
              })
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height/30
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 43.0),
              child: CustomButton(loading: buttonLoading, buttonLabel: 'Send Code', buttonWidth: MediaQuery.of(context).size.width, backGroundColor: primaryColor, onTap: ()async{
await getOtp();
              })
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height/30
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 43.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
SocialSignInButton(buttonImage: 'assets/icons/google.svg', onTap: (){}, borderColor: pureBlack, width: 75, height: 46, iconWidth: 50, iconHeight: 50),
                  SocialSignInButton(buttonImage: 'assets/icons/apple.svg', onTap: (){}, borderColor: pureBlack, width: 75, height: 46, iconWidth: 50, iconHeight: 50),
                  SocialSignInButton(buttonImage: 'assets/icons/facebook.svg', onTap: (){}, borderColor: pureBlack, width: 75, height: 46, iconWidth: 50, iconHeight: 50)
                ]
              ),
            )
          ]
        )
      ))
    );
  }
}
