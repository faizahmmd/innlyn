import 'package:flutter/material.dart';
import 'package:innlyn/core/colors.dart';
import 'package:innlyn/core/services/connectivity_service.dart';
import 'package:innlyn/core/services/navigation_service.dart';
import 'package:innlyn/routers/router.dart';
import 'package:innlyn/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'core/providers/providers_list.dart';
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    ///Build a tree of providers from a list of SingleChildWidget.
    return MultiProvider(
        providers: providers(),

        ///For internet connectivity check.
        child: StreamProvider<ConnectivityStatus>(
          initialData: ConnectivityStatus.wifi,
          create: (context) {
            return ConnectivityService().connectionStatusController.stream;
          },
          child: MaterialApp(
                title: "PRKAnalytics",
                theme: ThemeData(
                    primaryColor: primaryColor,
                    scaffoldBackgroundColor: scaffoldBackgroundColor,
                    backgroundColor: backgroundColor,
                    fontFamily: 'openSans',
                    colorScheme:
                        ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                            .copyWith(secondary: accentColor)),
                debugShowCheckedModeBanner: false,
                navigatorKey: navigationService.navigatorKey,
                onGenerateRoute: generateRoute,
                //initialRoute: orderScreenRoute,
                home: const SplashScreen(),
              )
          ),
        );
  }
}
