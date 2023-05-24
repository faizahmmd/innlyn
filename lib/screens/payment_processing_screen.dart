import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/routers/routing_constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../core/colors.dart';
import '../core/services/navigation_service.dart';

class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen({Key? key}) : super(key: key);

  @override
  State<PaymentProcessingScreen> createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greyLight1.withOpacity(0.7)
    ));
    Timer(
        const Duration(seconds: 3),
            () =>
            navigationService.navigatePushReplacementNamedTo(paymentSuccessfulScreenRoute, null));
    return Scaffold(
      backgroundColor: pureWhite,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.threeRotatingDots(
                      color: primaryColor,
                      size: 50,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height/30
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.4,
                      child: Text(
                          'Payment Processing',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: pureBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.w400
                          )
                      ),
                    )
                  ]
              )
          )
      ),
    );
  }
}
