import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/routers/routing_constants.dart';

import '../core/colors.dart';
import '../core/services/navigation_service.dart';
import '../widgets/button.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greyLight1.withOpacity(0.7)
    ));
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
                   SvgPicture.asset('assets/icons/request.svg', width: 90, height: 90),
                    SizedBox(
                        height: MediaQuery.of(context).size.height/30
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.4,
                      child: Text(
                          'Sorry currently we do not have',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: pureBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.4,
                      child: Text(
                          'any available connects',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: pureBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.4,
                      child: Text(
                          'for this location',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: pureBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height/26
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 43.0),
                        child: CustomButton(buttonLabel: 'Create Connect', buttonWidth: MediaQuery.of(context).size.width, backGroundColor: primaryColor, onTap: (){
                          navigationService.navigatePushNamedAndRemoveUntilTo(homeScreenRoute, null);
                        })
                    ),
                  ]
              )
          )
      ),
    );
  }
}
