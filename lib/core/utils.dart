import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

enum PermissionGroup {

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - Always
  locationAlways,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
  locationWhenInUse
}
Future<Address> getAddressFromLatLong({required double lat, required double lng})async{
  final coordinates = Coordinates(lat, lng);
  List<Address> addresses= await Geocoder.local.findAddressesFromCoordinates(coordinates);
  Address address = addresses.first;
  return address;
}
