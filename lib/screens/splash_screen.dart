import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:innlyn/core/colors.dart';
import 'package:innlyn/core/services/navigation_service.dart';
import 'package:innlyn/routers/routing_constants.dart';
import 'package:provider/provider.dart';

import '../core/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() async{
    await authCheck();
    super.didChangeDependencies();
  }

  authCheck() async {
    final authProvider =
    Provider.of<AuthProvider>(context, listen: false);
    bool authStatus = await authProvider.checkAuthState()
    ;
    if(authStatus){
      navigationService.navigatePushNamedAndRemoveUntilTo(homeScreenRoute, null);
    }else{
      navigationService.navigatePushNamedAndRemoveUntilTo(onBoardingOneScreenRoute, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greyLight1.withOpacity(0.7)
    ));
    return const Scaffold(
        backgroundColor: pureWhite,

      resizeToAvoidBottomInset: false
    );
  }
}
