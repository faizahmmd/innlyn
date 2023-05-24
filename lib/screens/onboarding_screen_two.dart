import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/core/services/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../core/colors.dart';
import '../core/providers/app_provider.dart';
import '../core/services/navigation_service.dart';
import '../routers/routing_constants.dart';
import '../widgets/button.dart';

class OnBoardingScreenTwo extends StatefulWidget {
  const OnBoardingScreenTwo({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreenTwo> createState() => _OnBoardingScreenTwoState();
}

class _OnBoardingScreenTwoState extends State<OnBoardingScreenTwo> {

   askLocationPermission() async{
     final appProvider = Provider.of<AppProvider>(context, listen: false);
    var statusService = await Permission.location.serviceStatus.isEnabled;
    Permission.location.serviceStatus.asStream().listen((event) {
      if(event == ServiceStatus.disabled){
        statusService = false;
      }else{
        statusService = true;
      }});
   var statusPermission = await Permission.location.status;
   if(statusPermission.isGranted && statusService){
     navigationService.navigateTo(onBoardingThreeScreenRoute, null);
   }else if(statusPermission.isGranted && !statusService){
     notificationService.showToast(navigationService.currentContext, 'Turn on GPS in phone settings', type: NotificationType.error);
   }else if(statusPermission.isDenied){
     Map<Permission, PermissionStatus> status = await [Permission.location].request();
     if(status.containsValue(PermissionStatus.granted)){
       navigationService.navigateTo(onBoardingThreeScreenRoute, null);
     }
   }
   if(await Permission.location.isPermanentlyDenied){
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
                                  child: SvgPicture.asset('assets/icons/on_boarding_two.svg')
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
                              child: CustomButton(buttonLabel: 'Allow Location', buttonWidth: double.infinity, backGroundColor: primaryColor, onTap: ()async{
                                await askLocationPermission();
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
