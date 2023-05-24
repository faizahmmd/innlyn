import 'package:flutter/material.dart';
import 'package:innlyn/routers/routing_constants.dart';
import 'package:innlyn/screens/base_screen.dart';
import 'package:innlyn/screens/chat_and_call_screen.dart';
import 'package:innlyn/screens/chat_screen.dart';
import 'package:innlyn/screens/connector_list_screen.dart';
import 'package:innlyn/screens/connects_history_screen.dart';
import 'package:innlyn/screens/loading_screen.dart';
import 'package:innlyn/screens/login_screen.dart';
import 'package:innlyn/screens/not_accept_screen.dart';
import 'package:innlyn/screens/onboarding_screen_one.dart';
import 'package:innlyn/screens/otp_verification_screen.dart';
import 'package:innlyn/screens/payment_processing_screen.dart';
import 'package:innlyn/screens/payment_successful_screen.dart';
import 'package:innlyn/screens/rate_screen.dart';
import 'package:innlyn/screens/request_screen.dart';
import 'package:innlyn/screens/requesting_screen.dart';
import 'package:innlyn/screens/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/call_screen.dart';
import '../screens/onboarding_screen_three.dart';
import '../screens/onboarding_screen_two.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const SplashScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case homeScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const BaseScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case onBoardingOneScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const OnBoardingScreenOne(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case onBoardingTwoScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const OnBoardingScreenTwo(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case onBoardingThreeScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const OnBoardingScreenThree(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case loginScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const LoginScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case otpVerificationScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const OTPVerificationScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case loadingScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const LoadingScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case requestScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const RequestScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case connectorListScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const ConnectorListScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case requestingScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const RequestingScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case notAcceptScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const NotAcceptScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case connectHistoryScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const ConnectsHistoryScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case paymentProcessingScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const PaymentProcessingScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case paymentSuccessfulScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const PaymentSuccessfulScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case chatAndCallScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const ChatAndCallScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case chatScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const ChatScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case callScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const CallScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
    case rateScreenRoute:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const RateScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));

      default:
      return PageTransition(type: PageTransitionType.rightToLeft, child: const SplashScreen(), isIos: true, settings: settings, duration: const Duration(milliseconds: 500));
  }
}
