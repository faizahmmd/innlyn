import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/core/colors.dart';
import 'package:innlyn/core/models/mobile_sign_in_response.dart';
import 'package:innlyn/core/services/api_service.dart';
import 'package:innlyn/routers/routing_constants.dart';
import 'package:innlyn/widgets/icon_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../core/models/get_otp_response.dart';
import '../core/providers/auth_provider.dart';
import '../core/services/navigation_service.dart';
import '../core/services/notification_service.dart';
import '../core/services/storage_service.dart';
import '../widgets/button.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  int secondsRemaining = 59;
  bool enableResend = false;
  Timer? timer;
  bool buttonLoading = false;

  runTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  void initState() {
    final authProvider =
    Provider.of<AuthProvider>(context, listen: false);
    if(authProvider.otpReceived != ''){
      textEditingController.text = authProvider.otpReceived;
    }
    runTimer();
    super.initState();
  }

  Future getOtp()async{
    final authProvider =
    Provider.of<AuthProvider>(context, listen: false);
    try{
      textEditingController.clear();
      authProvider.otpReceived = '';
      var response = await authProvider.getOtp(phoneNumber: authProvider.phoneNumber);
      GetOtpResponse getOtpResponse = GetOtpResponse.fromJson(response);
      if(getOtpResponse.success??false){
        authProvider.setPhoneNumber(phone: getOtpResponse.data?.phoneNumber??'');
        authProvider.setOtp(otp: getOtpResponse.data?.verificationCode.toString()??'');
        authProvider.setDeviceToken(deviceTokenFromResponse: DateTime.now().millisecondsSinceEpoch.toString());
        if(authProvider.otpReceived != ''){
          textEditingController.text = authProvider.otpReceived;
        }
      }else{
        notificationService.showToast(navigationService.currentContext, getOtpResponse.message, type: NotificationType.error);
      }
    }catch(e){
      // notificationService.showToast(context, e.toString(), type: NotificationType.error);
      if(e is HttpException){
      }
    }
  }

    Future _resendCode() async{
    await getOtp();
    setState((){
      secondsRemaining = 59;
      enableResend = false;
    });
  }

  @override
  dispose(){
    secondsRemaining = 59;
    enableResend = false;
    timer?.cancel();
    super.dispose();
  }

  Future mobileSignIn()async{
    final authProvider =
    Provider.of<AuthProvider>(context, listen: false);
    try{
      setState(() {
        buttonLoading = true;
      });
      var response = await authProvider.mobileSignIn(otp: textEditingController.text.trim());
      MobileSignInResponse mobileSignInResponse = MobileSignInResponse.fromJson(response);
      if(mobileSignInResponse.success??false){
        storageService.setAuthToken(mobileSignInResponse.data?.accessToken ?? '');
        apiService.setAuthorisation(mobileSignInResponse.data?.accessToken ?? '');
        setState(() {
          buttonLoading = false;
        });
        navigationService.navigatePushNamedAndRemoveUntilTo(homeScreenRoute, null);
      }else{
        setState(() {
          buttonLoading = false;
        });
        notificationService.showToast(navigationService.currentContext, mobileSignInResponse.message, type: NotificationType.error);
      }
    }catch(e){
      setState(() {
        buttonLoading = false;
      });
      notificationService.showToast(context, e.toString(), type: NotificationType.error);
    }
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greyLight1.withOpacity(0.7)
    ));
    final authProvider =
    Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: pureWhite,
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomIconButton(imagePath: 'assets/icons/back_arrow.svg', onTap: (){
                      navigationService.navigatePop();
                    })
                  ]
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height/20
              ),
              Text(
                  'Validate OTP',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: pureBlack,
                      fontSize: 22,
                      fontWeight: FontWeight.w700
                  )
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height/35
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width/1.3,
                child: Align(
                  alignment: Alignment.center,
                  child:
                    RichText(
                      overflow: TextOverflow.visible,

                      textAlign: TextAlign.center,

                      textDirection: TextDirection.rtl,

                      softWrap: true,

                      maxLines: 4,

                      textScaleFactor: 1,
                      text: TextSpan(
                        text: 'A code has been send to ',
                              style: GoogleFonts.poppins(

                                  color: greyLight1,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400
                              ),
                        children: <TextSpan>[
                          TextSpan(
                              text: authProvider.phoneNumber, style: GoogleFonts.poppins(

                              color: greyLight1,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )),
                          TextSpan(
                              text: ' via sms', style: GoogleFonts.poppins(

                              color: greyLight1,
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          )),
                        ]
                      )
                    )
                )
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height/30
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: GoogleFonts.poppins(
                        color: pureBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                    ),
                    textStyle: GoogleFonts.poppins(
                        color: pureBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                    ),
                    backgroundColor: pureWhite,
                    length: authProvider.otpReceived.length,
                    obscureText: false,
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < authProvider.otpReceived.length) {
                        return "";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: pureWhite,
                      selectedColor: pureWhite,
                      selectedFillColor: pureWhite,
                      inactiveColor: pureWhite,
                      disabledColor: pureWhite,
                      activeColor: pureWhite,
                      inactiveFillColor: pureWhite,
                      errorBorderColor: pureWhite,

                    ),
                    cursorColor: pureBlack,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        color: greyColor,
                        blurRadius: 0.5,
                      )
                    ],
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {

                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  )),
              SizedBox(
                  height: MediaQuery.of(context).size.height/35
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                      overflow: TextOverflow.visible,

                      textAlign: TextAlign.center,

                      textDirection: TextDirection.rtl,


                      maxLines: 4,

                      textScaleFactor: 1,
                      text: TextSpan(
                          text: "Didn't receive a code? ",
                          style: GoogleFonts.poppins(

                              color: pureBlack,
                              fontWeight: FontWeight.w500
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                recognizer: TapGestureRecognizer()..onTap = () => enableResend ? _resendCode() : null,
                                text: 'Resend', style: GoogleFonts.poppins(
                                color: primaryColor,
                                fontWeight: FontWeight.w600
                            )),
                          ]
                      )
                  ),
                  !enableResend?Text(
                      textAlign: TextAlign.center,
                      '(', style: GoogleFonts.poppins(
                    color: pureBlack,
                    fontWeight: FontWeight.w500,
                  )):Container(),
                  !enableResend?SizedBox(
                    width: 25,
                    child:
                    Text(
                        textAlign: TextAlign.center,
                        '$secondsRemaining', style: GoogleFonts.poppins(
                        color: pureBlack,
                        fontWeight: FontWeight.w500,
                    )),
                  ):Container(),
                  !enableResend?SizedBox(
                    child:
                    Text('Sec)', style: GoogleFonts.poppins(
                        color: pureBlack,
                        fontWeight: FontWeight.w500,
                    )),
                  ):Container(),
                ],
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height/20
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 43.0),
                  child: CustomButton(loading: buttonLoading, buttonLabel: 'Next', buttonWidth: MediaQuery.of(context).size.width, backGroundColor: primaryColor, onTap: ()async{
                  await mobileSignIn();
                  })
              )
            ]
          )
        )
      ))
    );
  }
}
