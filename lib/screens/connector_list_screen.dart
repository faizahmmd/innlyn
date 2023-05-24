import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:innlyn/core/providers/app_provider.dart';
import 'package:innlyn/routers/routing_constants.dart';
import 'package:provider/provider.dart';

import '../core/colors.dart';
import '../core/services/navigation_service.dart';
import '../widgets/button.dart';
import '../widgets/connector_list_card_widget.dart';
import '../widgets/icon_button.dart';

class ConnectorListScreen extends StatefulWidget {
  const ConnectorListScreen({Key? key}) : super(key: key);

  @override
  State<ConnectorListScreen> createState() => _ConnectorListScreenState();
}

class _ConnectorListScreenState extends State<ConnectorListScreen> {
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
            Positioned(
              top: 55,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomIconButton(imagePath: 'assets/icons/back_arrow.svg', onTap: (){
                          navigationService.navigatePop();
                        }),
                        SizedBox(
                            width:37,
                            height: 37,
                            child: Stack(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: pureWhite,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color:greyLight1.withOpacity(0.5),
                                                  blurRadius: 5.0,
                                                  spreadRadius: 5, //New
                                                )
                                              ]
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(7.0),
                                              child: SvgPicture.asset('assets/icons/bell_icon.svg', color: pureBlack)
                                          )
                                      )
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 2,
                                      child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                              color: primaryColor,
                                              shape: BoxShape.circle
                                          )
                                      )
                                  )
                                ]
                            ))
                      ]
                  )
                )
              )
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height/1.0,
                child: DraggableScrollableSheet(
                    minChildSize: 0.6,
                    maxChildSize: 1,
                    initialChildSize: 0.6,
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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: MediaQuery.of(context).size.height/25
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            'Select Your Connector',
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.poppins(
                                                color: pureBlack,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600
                                            )
                                        )
                                    ),
                                    SizedBox(
                                        height: MediaQuery.of(context).size.height/45
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        physics: const BouncingScrollPhysics(),
                                        controller: scrollController,
                                        itemCount: appProvider.connectorsList.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return ConnectorListCardWidget(imageUrl: appProvider.connectorsList[index].imageUrl, name: appProvider.connectorsList[index].name, distance: appProvider.connectorsList[index].distance, place: appProvider.connectorsList[index].place, gender: appProvider.connectorsList[index].gender,  onTap: (){
                                            appProvider.setSelectedConnector(value: appProvider.connectorsList[index]);
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:pureWhite,
                                              blurRadius: 15.0,
                                              spreadRadius: 15, //New
                                            )
                                          ]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20.0,right: 20.0, bottom: 35, top: 15),
                                        child: CustomButton(buttonLabel: 'Send Request', buttonWidth: MediaQuery.of(context).size.width, backGroundColor: primaryColor, onTap: (){
                                          if(appProvider.selectedConnector != null){
                                            navigationService.navigateTo(requestingScreenRoute, null);
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text("Select one user to send request"),
                                            ));
                                          }
                                        }),
                                      ),
                                    )
                                  ]
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
                        ],
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
