import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innlyn/widgets/textfield.dart';
import 'package:provider/provider.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import '../core/providers/app_provider.dart';
import 'button.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

class CreateNewConnectionWidget extends StatefulWidget {
  final VoidCallback onTapCreate, onTapSearch;
  const CreateNewConnectionWidget({Key? key, required this.onTapCreate, required this.onTapSearch}) : super(key: key);

  @override
  State<CreateNewConnectionWidget> createState() => _CreateNewConnectionWidgetState();
}

class _CreateNewConnectionWidgetState extends State<CreateNewConnectionWidget> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController currentLocationTextEditingController = TextEditingController();
  TextEditingController destinationTextEditingController = TextEditingController();
  bool mapAbsorbing = false;

  @override
  void didChangeDependencies() {
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    if(appProvider.currentLocationAddress?.addressLine != null && appProvider.startLocation == null){
      currentLocationTextEditingController.text =
      '${appProvider.currentLocationAddress?.addressLine}';
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height/35
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
                'Create New Connection',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    color: pureBlack,
                    fontSize: 22,
                    fontWeight: FontWeight.w700
                )
            )
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height/35
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height/35
                    ),
                    Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                            width: 1,
                            height: MediaQuery.of(context).size.height/14,
                            color: pureBlack
                        )
                    ),
                    Container(
                        width: 13,
                        height: 13,
                        decoration: const BoxDecoration(
                            color: errorColor,
                            shape: BoxShape.circle
                        )
                    )
                  ]
              ),
              const SizedBox(
                  width: 20
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 55,
                          child: CustomTextField(onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlacePicker(
                                    apiKey: Platform.isAndroid
                                        ? googleMapAPI
                                        : googleMapAPI,
                                    onPlacePicked: (result) async{
                                      appProvider.setStartLocation(startLocationFrom: result);
                                      currentLocationTextEditingController.text  = "${result.formattedAddress}";
                              Navigator.of(context).pop();
                              },
                                initialPosition: LatLng(double.parse(appProvider.latitude), double.parse(appProvider.longitude)),
                                useCurrentLocation: true,
                                resizeToAvoidBottomInset: false, // only works in page mode, less flickery, remove if wrong offsets
                              ),
                            ),
                            );
                          }, textSize: 12, readOnly: true, textAlignCenter: false, showBorder: false, showShadow: true, textEditingController: currentLocationTextEditingController, onChanged: (value){}, hintText: 'Current Location', onSubmit: (value) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height/40
                        ),
                        SizedBox(
                          height: 55,
                          child: CustomTextField(onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlacePicker(
                                  apiKey: Platform.isAndroid
                                      ? googleMapAPI
                                      : googleMapAPI,
                                  onPlacePicked: (result) async{
                                    appProvider.setEndLocation(endLocationFrom: result);
                                    destinationTextEditingController.text  = "${result.formattedAddress}";
                                    Navigator.of(context).pop();
                                  },
                                  initialPosition: LatLng(double.parse(appProvider.latitude), double.parse(appProvider.longitude)),
                                  useCurrentLocation: true,
                                  resizeToAvoidBottomInset: false, // only works in page mode, less flickery, remove if wrong offsets
                                ),
                              ),
                            );
                          }, textSize: 12, readOnly: true, textAlignCenter: false, showBorder: false, showShadow: true, textEditingController: destinationTextEditingController, onChanged: (value){}, hintText: 'Destination', onSubmit: (value) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height/40
                        ),
                        SizedBox(
                          height: 55,
                          child: CustomButton(buttonTextSize: 13, buttonLabel: 'Create Connection', buttonWidth: MediaQuery.of(context).size.width, backGroundColor: primaryColor, onTap: widget.onTapCreate),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height/40
                        ),
                        SizedBox(
                          height: 55,
                          child: CustomTextField(onTap: widget.onTapSearch, readOnly: true, prefixIcon: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: SvgPicture.asset('assets/icons/search.svg', color: pureBlack.withOpacity(0.6)),
                          ), textSize: 12, textAlignCenter: false, showBorder: false, showShadow: true, textEditingController: TextEditingController(), onChanged: (value){}, hintText: 'Search for available connects', onSubmit: (value) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }),
                        ),
                      ]
                  ),
                ),
              )

            ]
        )
      ]
    );
  }
}
