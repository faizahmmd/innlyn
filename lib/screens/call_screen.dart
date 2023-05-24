import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../core/colors.dart';
import '../core/providers/app_provider.dart';
import '../core/services/navigation_service.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greyLight1.withOpacity(0.7)
    ));
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: pureWhite,
      resizeToAvoidBottomInset: false,
        body: SizedBox(
        width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/3.5
            ),
            AvatarGlow(
              glowColor: primaryColor,
              endRadius: 80.0,
              duration: const Duration(milliseconds: 1000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 500),
              child: Material(     // Replace this child with your own
                elevation: 8.0,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: pureWhite.withOpacity(0.4),
                  foregroundColor: pureWhite,
                  radius: 40.0,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    child: Image.asset(
                      'assets/icons/connector_dummy.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
                width: MediaQuery.of(context).size.width/1.3,
                child: Text(
                    'Sam Leon',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        color: pureBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    )
                )
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width/1.3,
                child: Text(
                    '2:20 sec',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        color: pureBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    )
                )
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height/10
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: pureBlack
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SvgPicture.asset('assets/icons/speaker_icon.svg', color: pureWhite, width: 20, height: 28),
                      )
                  ),
                ),
                const SizedBox(
                  width: 50
                ),
                GestureDetector(
                  onTap: (){
                    navigationService.navigatePop();
                  },
                  child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: errorColor
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SvgPicture.asset('assets/icons/call_cancel_icon.svg', color: pureWhite, width: 20, height: 28),
                      )
                  )
                )
              ]
            )
          ]
        )
        )
    );
  }
}
