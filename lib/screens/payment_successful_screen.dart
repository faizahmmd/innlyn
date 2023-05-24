import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/routers/routing_constants.dart';

import '../core/colors.dart';
import '../core/services/navigation_service.dart';

class PaymentSuccessfulScreen extends StatefulWidget {
  const PaymentSuccessfulScreen({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessfulScreen> createState() => _PaymentSuccessfulScreenState();
}

class _PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greyLight1.withOpacity(0.7)
    ));
    Timer(
        const Duration(seconds: 3),
            () =>
            navigationService.navigatePushReplacementNamedTo(chatAndCallScreenRoute, null));
    return Scaffold(
      backgroundColor: pureWhite,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
              SizedBox(
              height: MediaQuery.of(context).size.height/3.5),
                    Stack(
                      children: [
                        Container(
                            width: 200,
                            height: 200,
                          color: Colors.yellow,
                          child: Image.asset(
                            'assets/icons/payment_success.gif',
                           fit: BoxFit.fill
                          )
                        ),
                        Positioned(
                          bottom: 0,
                          child: SizedBox(
                            width: 200,
                            child: Text(
                                'Payment Successful',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: pureBlack,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400
                                )
                            ),
                          ),
                        )
                      ]
                    )


                  ]
              )
          )
      ),
    );
  }
}
