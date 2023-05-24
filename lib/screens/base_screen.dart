import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:innlyn/core/colors.dart';
import 'package:innlyn/core/constants.dart';
import 'package:innlyn/core/models/search_connect_response.dart';
import 'package:innlyn/core/providers/app_provider.dart';
import 'package:innlyn/core/services/location_services.dart';
import 'package:innlyn/core/services/notification_service.dart';
import 'package:innlyn/widgets/create_new_connection_widget.dart';
import 'package:innlyn/widgets/drawer_tile.dart';
import 'package:innlyn/widgets/search_connection_widget.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../core/errors/exceptions.dart';
import '../core/models/create_connect_response.dart';
import '../core/providers/auth_provider.dart';
import '../core/services/navigation_service.dart';
import '../core/utils.dart';
import '../routers/routing_constants.dart';
import '../widgets/icon_button.dart';
import '../widgets/incoming_request_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io';
class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  bool selectedSearchScreen = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  final _socketResponse= StreamController<String>();
  void Function(String) get addResponse => _socketResponse.sink.add;
  Stream<String> get getResponse => _socketResponse.stream;
  bool createButtonLoading = false;
  bool searchButtonLoading = false;

@override
  void initState() {
   FlutterNativeSplash.remove();
    super.initState();
  }
  @override
  void didChangeDependencies() async{
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    try{
      geo.Position position = await geo.Geolocator.getCurrentPosition();
      appProvider.setLatLong(lat: position.latitude.toString(), lng: position.longitude.toString());
      locationService.positionStream();
      Address address = await getAddressFromLatLong(lat: position.latitude, lng: position.longitude);
      appProvider.setCurrentLocationAddress(address: address);
      // connectAndListen();
    }catch(e){
      notificationService.showToast(context, 'cannot detect location, check phone GPS and try again', type: NotificationType.error);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose(){
    super.dispose();
    _socketResponse.close();
  }

  void connectAndListen(){
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try{
      IO.Socket socket = IO.io('http://15.206.175.75:7000',
          OptionBuilder()
              .setExtraHeaders({'x-api-key': xApiKey, 'Authorization': authProvider.authToken, 'autoConnect': false})
              .setTransports(['websocket']).build());

      socket.onConnect((_) {
        if (kDebugMode) {
          print('<=========== SOCKET CONNECTED ===========>');
        }
        socket.on('getLiveLocation', (data) {
          print("XXXXXXXXXXXXX $data");
          addResponse(data);
        });
        socket.emit('postLiveLocation', {
          "userDetails": {
            "location": [
              double.parse(appProvider.latitude),
              double.parse(appProvider.longitude)
            ]
          }
        });
      });


      socket.onDisconnect((_) => print('<=========== SOCKET DISCONNECTED ===========>'));
    }catch(e){
      print("<============ SOCKET CONNECTION FAILED $e==============>");
    }


  }


  Future createConnect() async {
    try{
      setState(() {
        createButtonLoading = true;
      });
      final appProvider = Provider.of<AppProvider>(context, listen: false);
      var response = await appProvider.createConnect(description: 'Created your ride', pickup: (appProvider.startLocation?.geometry?.location.lat)!=null?LatLng((appProvider.startLocation?.geometry?.location.lat)!, (appProvider.startLocation?.geometry?.location.lng)!):LatLng(double.parse(appProvider.latitude), double.parse(appProvider.longitude)), drop: LatLng((appProvider.endLocation?.geometry?.location.lat)!, (appProvider.endLocation?.geometry?.location.lng)!));
      CreateConnectResponse createConnectResponse = CreateConnectResponse.fromJson(response);
      if(createConnectResponse.success??false){
        setState(() {
          createButtonLoading = false;
        });
        navigationService.navigatePushNamedAndRemoveUntilTo(loadingScreenRoute, null);
      }else{
        setState(() {
          createButtonLoading = false;
        });
        notificationService.showToast(navigationService.currentContext,
            createConnectResponse.message,
            type: NotificationType.error);
      }
    } catch (e) {
      setState(() {
        createButtonLoading = false;
      });
      notificationService.showToast(context,
          e is AppException ? e.message : e.toString(),
          type: NotificationType.error);
    }
  }
  Future searchConnect() async {
    try{
      setState(() {
        searchButtonLoading = true;
      });
      final appProvider = Provider.of<AppProvider>(context, listen: false);
      var response = await appProvider.searchConnect(pickup: (appProvider.startLocationForSearchConnection?.geometry?.location.lat)!=null?LatLng((appProvider.startLocationForSearchConnection?.geometry?.location.lat)!, (appProvider.startLocationForSearchConnection?.geometry?.location.lng)!):LatLng(double.parse(appProvider.latitude), double.parse(appProvider.longitude)), drop: LatLng((appProvider.endLocationForSearchConnection?.geometry?.location.lat)!, (appProvider.endLocationForSearchConnection?.geometry?.location.lng)!));
      SearchConnectResponse searchConnectResponse = SearchConnectResponse.fromJson(response);
      if(searchConnectResponse.success??false){
        setState(() {
          searchButtonLoading = false;
        });
        navigationService.navigateTo(connectorListScreenRoute, null);
      }else{
        setState(() {
          searchButtonLoading = false;
        });
        notificationService.showToast(navigationService.currentContext,
            searchConnectResponse.message,
            type: NotificationType.error);
      }
    } catch (e) {
      setState(() {
        searchButtonLoading = false;
      });
      notificationService.showToast(context,
          e is AppException ? e.message : e.toString(),
          type: NotificationType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greyLight1.withOpacity(0.7)
    ));
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    return WillPopScope(
        onWillPop: () async {
      if (selectedSearchScreen) {
        setState(() {
          selectedSearchScreen = false;
        });
        return false;
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Alert", style: GoogleFonts.poppins(

                color: pureBlack,
                fontWeight: FontWeight.w600
            )),
            content: Text("Are you sure you want to exit?", style: GoogleFonts.poppins(

                color: greyColor,
                fontWeight: FontWeight.w400
            )),
            actions: [
              TextButton(
                onPressed: () {
                  navigationService.navigatePop();
                },
                child: Text("No", style: GoogleFonts.poppins(

                    color: greyLight1,
                    fontWeight: FontWeight.w600
                ))
              ),
              TextButton(
                onPressed: () {
                  navigationService.navigatePop();
                  SystemNavigator.pop();
                },
                child: Text("Yes", style: GoogleFonts.poppins(

                    color: pureBlack,
                    fontWeight: FontWeight.w600
                )),
              ),
            ],
          ),
        );
        return false;
      }},
      child: Scaffold(
        key: _key,
        backgroundColor: pureWhite,
          extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
          drawer: Drawer(
            elevation: 90,
            backgroundColor: primaryColor,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/15),
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height/8
                ),
                InkWell(
                  onTap: (){},
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height/12,
                        color: transparentColor,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.height/12,
                              height: MediaQuery.of(context).size.height/12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: greyLight1,
                                border: Border.all(color: primaryColor.withOpacity(0.4), width: 2.0)
                              ),
                              child: Image.asset('assets/icons/connector_dummy1.png', fit: BoxFit.fill)
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    color: transparentColor,
                                    height: 30,
                                    child:   Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            'Shelby',
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                color: pureWhite,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600
                                            )
                                        )
                                    )
                                  ),
                                  Container(
                                    color: transparentColor,
                                      child:   Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              'Edit',
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.poppins(
                                                  color: pureWhite,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400
                                              )
                                          ),
                                          const SizedBox(width: 3),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 3.0),
                                            child: SvgPicture.asset('assets/icons/pen_icon_drawer.svg', color: pureWhite, width: 24, height: 22),
                                          )
                                        ]
                                      )
                                  )
                                ]
                              ),
                            ),
                            const SizedBox(width: 20),
                            SvgPicture.asset('assets/icons/forward_arrow_icon_drawer.svg', color: pureWhite, height: 17, width: 17)
                          ]
                        )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height/17
                ),
          DrawerTileWidget(onTap: () {
            navigationService.navigatePop();
            navigationService.navigateTo(connectHistoryScreenRoute, null);
          }, imageUrl: 'assets/icons/history_icon_drawer.svg', title: 'Connects History'),

                DrawerTileWidget(onTap: () {  }, imageUrl: 'assets/icons/wallet_icon_drawer.svg', title: 'Wallet', isWallet: true),

                DrawerTileWidget(onTap: () {  }, imageUrl: 'assets/icons/privacy_icon_drawer.svg', title: 'Safety & Privacy'),

                DrawerTileWidget(onTap: () {  }, imageUrl: 'assets/icons/about_icon_drawer.svg', title: 'About'),

                DrawerTileWidget(onTap: () {  }, imageUrl: 'assets/icons/report_icon_drawer.svg', title: 'Report'),

                DrawerTileWidget(onTap: () {  }, imageUrl: 'assets/icons/faq_icon_drawer.svg', title: 'FAQ'),

                DrawerTileWidget(onTap: () async{
                  authProvider.clearLoginCredentials();
                  navigationService.navigatePushNamedAndRemoveUntilTo(loginScreenRoute, null);
                }, imageUrl: 'assets/icons/log_out_icon_drawer.svg', title: 'Logout')

              ]
            )
          ),
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        selectedSearchScreen? CustomIconButton(imagePath: 'assets/icons/back_arrow.svg', onTap: (){
                          setState(() {
                            selectedSearchScreen = false;
                          });
                        }):GestureDetector(
                          onTap:(){
                            _key.currentState!.openDrawer();
                          },
                          child: Container(
                            color: transparentColor,
                            child: SvgPicture.asset('assets/icons/menu_icon.svg', color: pureBlack,  width: 24,
                                 height: 24),
                          ),
                        ),
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
                                            spreadRadius: 5,
                                              offset: const Offset(1,1)//New
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
                    ),
                    !selectedSearchScreen?CreateNewConnectionWidget(onTapCreate: ()async{
                      await createConnect();
                   }, onTapSearch: () {
                     setState(() {
                       selectedSearchScreen = true;
                     });
                   }):SearchConnectionWidget(onTapSearchConnection: () async{
                      await searchConnect();
                    })


                  ]
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/1.0,
              child: DraggableScrollableSheet(
                minChildSize: selectedSearchScreen?0.54:0.36,
                maxChildSize: 1,
                initialChildSize: selectedSearchScreen?0.54:0.36,
                builder: (BuildContext context, ScrollController scrollController) {
                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/1.0,
                          width: MediaQuery.of(context).size.width/1.0,
                        decoration: const BoxDecoration(
                            color: greyLight,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
                        ),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                                child: GoogleMap(
                                  myLocationEnabled: true,
                                  mapType: MapType.normal,
                                  initialCameraPosition: appProvider.kGooglePlex,
                                  onMapCreated: (GoogleMapController controller) {
                                    controller.animateCamera(CameraUpdate.newLatLng(LatLng(double.parse(appProvider.latitude), double.parse(appProvider.longitude))));
                                    _controller.complete(controller);
                                    },
                                )
                              )
                            )
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
            ),
            Visibility(
                visible: appProvider.showRequestSheet,
                child: IncomingRequestWidget(onAccept: () {
                  appProvider.setShowRequestSheet(status: false);
                  navigationService.navigateTo(paymentProcessingScreenRoute, null);
                }, onReject: () {
                  appProvider.setShowRequestSheet(status: false);
                }))
          ]
        )
      ),
    );
  }
}



