import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/routers/routing_constants.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/colors.dart';
import '../core/services/navigation_service.dart';
import '../core/services/notification_service.dart';
import '../widgets/button.dart';

class OnBoardingScreenThree extends StatefulWidget {
  const OnBoardingScreenThree({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreenThree> createState() => _OnBoardingScreenThreeState();
}

class _OnBoardingScreenThreeState extends State<OnBoardingScreenThree> {
  askPhotosPermission() async{
    var status = await Permission.photos.status.isGranted;
    if(status){
      navigationService.navigateTo(loginScreenRoute, null);
    }else{
      Map<Permission, PermissionStatus> status = await [Permission.photos].request();
      if(status.containsValue(PermissionStatus.granted)){
        navigationService.navigateTo(loginScreenRoute, null);
      }
    }
    if(await Permission.photos.isPermanentlyDenied){
      openAppSettings();
    }
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
                            SizedBox(height: MediaQuery.of(context).size.height/3.7),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width/1.7, height: MediaQuery.of(context).size.width/1.7,
                                  child: SvgPicture.asset('assets/icons/on_boarding_three.svg')
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height/20),
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
                              child: CustomButton(buttonLabel: 'Allow Photos', buttonWidth: double.infinity, backGroundColor: primaryColor, onTap: ()async{
                                await askPhotosPermission();
                              })
                          )
                      )
                  )
                ]
            )
        )
    );
  }
}
