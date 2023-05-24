import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/core/services/navigation_service.dart';
import 'package:innlyn/routers/routing_constants.dart';
import '../core/colors.dart';
import '../widgets/button.dart';

class OnBoardingScreenOne extends StatefulWidget {
  const OnBoardingScreenOne({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreenOne> createState() => _OnBoardingScreenOneState();
}

class _OnBoardingScreenOneState extends State<OnBoardingScreenOne> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greyLight1.withOpacity(0.7)
    ));
    return Scaffold(
      backgroundColor: pureWhite,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        child: SvgPicture.asset('assets/icons/on_boarding_one.svg', fit: BoxFit.fill)
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/7,
                      child: Text(
                        'Simply dummy text of the printing and typesetting ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: pureBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                        )
                      )
                    ),
                  )

                ]
              )
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height/20,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomButton(buttonLabel: 'Get Started', backGroundColor: primaryColor, onTap: (){
                    navigationService.navigateTo(onBoardingTwoScreenRoute, null);
                  }, buttonWidth: double.infinity)
                )
              )
            )
          ]
        )
      )
    );
  }
}
