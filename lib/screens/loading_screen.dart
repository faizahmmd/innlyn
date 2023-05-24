import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/core/models/cancel_connect_response.dart';
import 'package:innlyn/routers/routing_constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../core/colors.dart';
import '../core/errors/exceptions.dart';
import '../core/providers/app_provider.dart';
import '../core/services/navigation_service.dart';
import '../core/services/notification_service.dart';
import '../widgets/button.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool buttonLoading = false;
  Future cancelConnect() async {
    setState(() {
      buttonLoading = true;
    });
    try{
      final appProvider = Provider.of<AppProvider>(context, listen: false);
      var response = await appProvider.cancelConnect();
      CancelConnectResponse cancelConnectResponse = CancelConnectResponse.fromJson(response);
      if(cancelConnectResponse.success??false){
        setState(() {
          buttonLoading = false;
        });
        navigationService.navigatePushNamedAndRemoveUntilTo(homeScreenRoute, null);
      }else{
        setState(() {
          buttonLoading = false;
        });
        notificationService.showToast(navigationService.currentContext,
            cancelConnectResponse.message,
            type: NotificationType.error);
      }
    } catch (e) {
      setState(() {
        buttonLoading = false;
      });
      notificationService.showToast(context,
          e is AppException ? e.message : e.toString(),
          type: NotificationType.error);
    }
  }
  @override
  void dispose(){
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    try{
      appProvider.cancelConnect();
    }catch(e){
      debugPrint(e.toString());
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greyLight1.withOpacity(0.7)
    ));
    Timer(
        const Duration(seconds: 180),
            () =>
                navigationService.navigatePushNamedAndRemoveUntilTo(requestScreenRoute, null));
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
                    'You have successfully created',
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
                    'a connect to Hopeform',
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
                    'destination we are waiting',
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
                    'for someone to connect',
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
                    'with you',
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
                  child: CustomButton(loading: buttonLoading, buttonLabel: 'Cancel', buttonWidth: MediaQuery.of(context).size.width/2.2, backGroundColor: primaryColor, onTap: ()async{
                    await cancelConnect();

                  })
              ),
            ]
          )
        )
      ),
    );
  }
}
