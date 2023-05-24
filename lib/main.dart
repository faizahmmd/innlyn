import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:innlyn/app.dart';
import 'package:innlyn/core/services/service_locator.dart';
import 'package:innlyn/core/services/storage_service.dart';
import 'dart:io';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    WidgetsFlutterBinding.ensureInitialized();
    setupLocator();
    await storageService.initHiveInApp();
  if(Platform.isAndroid) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(const App());
}

