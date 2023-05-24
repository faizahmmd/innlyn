import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/colors.dart';
import '../core/services/navigation_service.dart';
import '../widgets/button.dart';

class NotAcceptScreen extends StatefulWidget {
  const NotAcceptScreen({Key? key}) : super(key: key);

  @override
  State<NotAcceptScreen> createState() => _NotAcceptScreenState();
}

class _NotAcceptScreenState extends State<NotAcceptScreen> {
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
                    SvgPicture.asset('assets/icons/not_accept.svg', width: 90, height: 90),
                    SizedBox(
                        height: MediaQuery.of(context).size.height/30
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.4,
                      child: Text(
                          '"Connector not accept',
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
                          ' your request',
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
                          'Go back and search again"',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: pureBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          )
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height/40
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 43.0),
                        child: CustomButton(buttonLabel: 'Go Back', buttonWidth: MediaQuery.of(context).size.width/2.2, backGroundColor: primaryColor, onTap: (){
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
