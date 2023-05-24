import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:innlyn/routers/routing_constants.dart';
import 'package:provider/provider.dart';

import '../core/colors.dart';
import '../core/providers/app_provider.dart';
import '../core/services/navigation_service.dart';
import '../widgets/button.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({Key? key}) : super(key: key);

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  TextEditingController textEditingController = TextEditingController();
  late StreamSubscription<bool> keyboardSubscription;
  bool keyboard = false;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      if(visible){
        setState(() {
          keyboard = true;
        });
      }else{
        setState(() {
          keyboard = false;
        });
      }

    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }
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
                        minChildSize: keyboard?1:0.7,
                        maxChildSize: 1,
                        initialChildSize: keyboard?1:0.7,
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
                                      padding: const EdgeInsets.symmetric(horizontal: 33.0),
                                      child: SingleChildScrollView(
                                        controller: scrollController,
                                        physics: const NeverScrollableScrollPhysics(),
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              Text(
                                                  'Thank you for your connect',
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                      color: pureBlack,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500
                                                  )
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context).size.height/40
                                              ),
                                              const Divider(
                                                thickness: 1,
                                                height: 1,
                                                color: greyLight3
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context).size.height/60
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
                                              SizedBox(
                                                  height: MediaQuery.of(context).size.height/90
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
                          )),
                                              SizedBox(
                                                  height: MediaQuery.of(context).size.height/60
                                              ),
                                              const Divider(
                                                  thickness: 1,
                                                  height: 1,
                                                  color: greyLight3
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context).size.height/60
                                              ),
                                              Text(
                                                  'How was your connection with Sam Leon',
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                      color: pureBlack,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500
                                                  )
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context).size.height/40
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: List.generate(5, (index) =>   Padding(
                                                  padding: const EdgeInsets.only(left: 20.0),
                                                  child: SvgPicture.asset('assets/icons/star.svg', width: 16, height: 16, color: index==0?null:greyLight3),
                                                ))
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context).size.height/35
                                              ),
                                               Container(
                                                  decoration: BoxDecoration(
                                                      color: greyLight3,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: TextField(
                                                      controller: textEditingController,
                                                      maxLines: 3,
                                                      decoration: const InputDecoration.collapsed(fillColor: greyLight3, hintText: "Type here..."),
                                                    ),
                                                  )
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context).size.height/35
                                              ),
                                              SizedBox(
                                                height: 50,
                                                child: CustomButton(buttonTextSize: 16, buttonLabel: 'Done', buttonWidth: MediaQuery.of(context).size.width/2.7, backGroundColor: primaryColor, onTap: (){
                                                  navigationService.navigatePushNamedAndRemoveUntilTo(homeScreenRoute, null);
                                                }),
                                              )
                                            ]

                                        ),
                                      )
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
