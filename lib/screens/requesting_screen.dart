import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/routers/routing_constants.dart';
import 'package:provider/provider.dart';

import '../core/colors.dart';
import '../core/providers/app_provider.dart';
import '../core/services/navigation_service.dart';
import '../widgets/button.dart';

class RequestingScreen extends StatefulWidget {
  const RequestingScreen({Key? key}) : super(key: key);

  @override
  State<RequestingScreen> createState() => _RequestingScreenState();
}

class _RequestingScreenState extends State<RequestingScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greyLight1.withOpacity(0.7)
    ));
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    Timer(
        const Duration(seconds: 3),
            () =>
            navigationService.navigatePushReplacementNamedTo(notAcceptScreenRoute, null));
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
                    AvatarGlow(
                      glowColor: greyColor,
                      endRadius: 80.0,
                      duration: const Duration(milliseconds: 2000),
                      repeat: true,
                      showTwoGlows: true,
                      repeatPauseDuration: const Duration(milliseconds: 500),
                      child: Material(     // Replace this child with your own
                        elevation: 8.0,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: primaryColor.withOpacity(0.4),
                          foregroundColor: primaryColor,
                          radius: 40.0,
                          child: Image.asset(
                            '${appProvider.selectedConnector?.imageUrl}',
                            height: 70,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height/100
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2,
                      child: Text(
                          'Request sending to ',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: pureBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      ),
                    ),  SizedBox(
                      width: MediaQuery.of(context).size.width/2,
                      child: Text(
                          '${appProvider.selectedConnector?.name} ...',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: pureBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height/30
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 43.0),
                        child: CustomButton(buttonLabel: 'Cancel', buttonWidth: MediaQuery.of(context).size.width/2.2, backGroundColor: primaryColor, onTap: (){
                          navigationService.navigatePop();
                        })
                    ),
                  ]
              )
          )
      ),
    );
  }
}
