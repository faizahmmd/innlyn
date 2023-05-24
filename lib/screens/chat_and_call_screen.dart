import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../core/colors.dart';
import '../core/providers/app_provider.dart';
import '../core/services/navigation_service.dart';
import '../routers/routing_constants.dart';
import '../widgets/button.dart';

class ChatAndCallScreen extends StatefulWidget {
  const ChatAndCallScreen({Key? key}) : super(key: key);

  @override
  State<ChatAndCallScreen> createState() => _ChatAndCallScreenState();
}

class _ChatAndCallScreenState extends State<ChatAndCallScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

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
          child: Stack(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: appProvider.kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        controller.animateCamera(CameraUpdate.newLatLng(LatLng(double.parse(appProvider.latitude), double.parse(appProvider.longitude))));
                        _controller.complete(controller);
                      },
                    )
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height/1.0,
                    child: DraggableScrollableSheet(
                        minChildSize: 0.44,
                        maxChildSize: 1,
                        initialChildSize: 0.44,
                        builder: (BuildContext context, ScrollController scrollController) {
                          return Stack(
                            children: [
                              Container(
                                  height: MediaQuery.of(context).size.height/1.0,
                                  width: MediaQuery.of(context).size.width/1.0,
                                  decoration: const BoxDecoration(
                                      color: pureWhite,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: SingleChildScrollView(    controller: scrollController,
                                        physics: const NeverScrollableScrollPhysics(),
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                            GestureDetector(
                              onTap: (){
                                navigationService.navigateTo(chatScreenRoute, null);
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: SvgPicture.asset('assets/icons/chat_icon.svg', color: pureWhite, width: 20, height: 28),
                                )
                              ),
                            ),
                                              const SizedBox(
                                                  width: 40
                                              ),
                                              Container(
                                                  width: 75,
                                                  height: 75,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: primaryColor
                                                  ),
                                                child: Image.asset('assets/icons/connector_dummy1.png', fit: BoxFit.fill)
                                              ),
                                              const SizedBox(
                                                  width: 40
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  navigationService.navigateTo(callScreenRoute, null);
                                                },
                                                child: Container(
                                                  width: 48,
                                                  height: 48,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: primaryColor
                                                  ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(13.0),
                                                      child: SvgPicture.asset('assets/icons/call_icon.svg', color: pureWhite, width: 20, height: 28),
                                                    )
                                                ),
                                              )
                                            ]
                                          ),
                                              SizedBox(
                                                  height: MediaQuery.of(context).size.height/200
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
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w600
                                                      )
                                                  )
                                              ),
                                              const SizedBox(
                                                  height: 1
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context).size.width/1.3,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset('assets/icons/black_marker_icon.svg', color: pureBlack, width: 16, height: 16),
                                                      const SizedBox(
                                                          width: 5
                                                      ),
                                                      Text(
                                                          'Kundanahalli Gate',
                                                          textAlign: TextAlign.center,
                                                          style: GoogleFonts.poppins(
                                                              color: pureBlack,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w400
                                                          )
                                                      ),
                                                    ],
                                                  )
                                              ),
                                              const SizedBox(
                                                  height: 1
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context).size.width/1.3,
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [

                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 1),
                                                          child: Text(
                                                              '4.3',
                                                              textAlign: TextAlign.center,
                                                              style: GoogleFonts.poppins(
                                                                  color: pureBlack,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w400
                                                              )
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(bottom: 1.0),
                                                          child: SvgPicture.asset('assets/icons/star.svg', width: 14, height: 14),
                                                        )

                                                      ]
                                                  )
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context).size.height/35
                                              ),
                                              SizedBox(
                                                height: 50,
                                                child: CustomButton(buttonTextSize: 16, buttonLabel: 'End the Connect', buttonWidth: MediaQuery.of(context).size.width/2.1, backGroundColor: errorColor, onTap: (){
                                                  navigationService.navigateTo(rateScreenRoute, null);
                                                }),
                                              )
                                            ]
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                color: transparentColor,
                                child: Center(
                                  child: Container(
                                    width: 100,
                                    height: 2.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: pureBlack
                                    ),
                                  ),
                                ),
                              )
                            ]
                          );
                        }
                    )
                )

              ]
          )
      ),
    );
  }
}
