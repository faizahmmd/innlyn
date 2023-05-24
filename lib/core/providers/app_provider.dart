import 'package:flutter/material.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../models/chat_model.dart';
import '../models/connector_model.dart';
import '../services/api_service.dart';

class AppProvider extends ChangeNotifier {
List<ConnectorModel> connectorsList = [
  ConnectorModel(
    name: 'Grace',
    imageUrl: 'assets/icons/connector_dummy.png',
    distance: 3,
    gender: 'female',
    place: 'Marathahalli'
  ),
  ConnectorModel(
      name: 'Thomas Shelby',
      imageUrl: 'assets/icons/connector_dummy1.png',
      distance: 1.5,
      gender: 'male',
      place: 'Koramangala'
  ),
  ConnectorModel(
      name: 'Julie Ann',
      imageUrl: 'assets/icons/connector_dummy2.png',
      distance: 1,
      gender: 'female',
      place: 'ITPL'
  ),
  ConnectorModel(
      name: 'Jonathan',
      imageUrl: 'assets/icons/connector_dummy3.png',
      distance: 4,
      gender: 'male',
      place: 'Whitefield'
  ),
];
ConnectorModel? selectedConnector;
setSelectedConnector({required ConnectorModel value}){
  selectedConnector = value;
  notifyListeners();
}
bool showRequestSheet = true;
setShowRequestSheet({required bool status}){
  showRequestSheet = status;
  notifyListeners();
}
List<ChatModel> chatList = [
  const ChatModel(isUserSender: true, message: 'Hi, there?', time: '10:30 AM', imageUrl: 'assets/icons/connector_dummy1.png'),
  const ChatModel(isUserSender: false, message: 'Yes, Tell me', time: '10:32 AM', imageUrl: 'assets/icons/connector_dummy.png'),
  const ChatModel(isUserSender: true, message: 'Can we connect now', time: '10:33 AM', imageUrl: 'assets/icons/connector_dummy1.png'),
  const ChatModel(isUserSender: false, message: 'Yeah, sure we can share a cab. Shall I call you now?', time: '10:34 AM', imageUrl: 'assets/icons/connector_dummy.png'),
  const ChatModel(isUserSender: true, message: 'I cannot take now', time: '10:36 AM', imageUrl: 'assets/icons/connector_dummy1.png'),
  const ChatModel(isUserSender: false, message: 'ok, what to do?', time: '10:37 AM', imageUrl: 'assets/icons/connector_dummy.png'),
  const ChatModel(isUserSender: true, message: 'Any way we can walk towards each other with innlyn map', time: '10:38 AM', imageUrl: 'assets/icons/connector_dummy1.png'),
  const ChatModel(isUserSender: false, message: 'good, after meeting we will take a cab from there.', time: '10:39 AM', imageUrl: 'assets/icons/connector_dummy.png'),
  const ChatModel(isUserSender: true, message: 'We will share cab fare equally', time: '10:40 AM', imageUrl: 'assets/icons/connector_dummy1.png'),
  const ChatModel(isUserSender: false, message: 'ok', time: '10:42 AM', imageUrl: 'assets/icons/connector_dummy.png'),
  const ChatModel(isUserSender: true, message: 'I am almost there.', time: '10:43 AM', imageUrl: 'assets/icons/connector_dummy1.png'),
  const ChatModel(isUserSender: false, message: 'Hey here!, I can see you, turn left side.', time: '10:44 AM', imageUrl: 'assets/icons/connector_dummy.png'),
];

String latitude = '';
String longitude = '';

setLatLong({required String lat, required String lng}) {
  latitude = lat;
  longitude = lng;
  notifyListeners();
}
 CameraPosition kGooglePlex = const CameraPosition(
  target: LatLng(28.7041, 77.1025),
  zoom: 14.4746,
);
PickResult? startLocation;
PickResult? endLocation;
setStartLocation({required PickResult startLocationFrom}){
  startLocation = startLocationFrom;
  notifyListeners();
}
setEndLocation({required PickResult endLocationFrom}){
  endLocation = endLocationFrom;
  notifyListeners();
}
PickResult? startLocationForSearchConnection;
PickResult? endLocationForSearchConnection;
setStartLocationForSearchConnection({required PickResult startLocationFrom}){
  startLocationForSearchConnection = startLocationFrom;
  notifyListeners();
}
setEndLocationForSearchConnection({required PickResult endLocationFrom}){
  endLocationForSearchConnection = endLocationFrom;
  notifyListeners();
}
Address? currentLocationAddress;
setCurrentLocationAddress({required Address address}){
  currentLocationAddress = address;
  notifyListeners();
}
Future createConnect(
    {required String description,
      required LatLng pickup,
      required LatLng drop}) async {
  try {
    var response = await apiService.createConnect(
        description: description,
        pickup: pickup,
        drop: drop);
    // debugPrint(response.toString());
    return response;
  } catch (e) {
    // debugPrint(e is AppException ? e.message : e.toString());
    rethrow;
  }
}
Future searchConnect(
    {
      required LatLng pickup,
      required LatLng drop}) async {
  try {
    var response = await apiService.searchConnect(
        pickup: pickup,
        drop: drop);
    // debugPrint(response.toString());
    return response;
  } catch (e) {
    // debugPrint(e is AppException ? e.message : e.toString());
    rethrow;
  }
}
Future cancelConnect(
    ) async {
  try {
    var response = await apiService.cancelConnect(
      );
    // debugPrint(response.toString());
    return response;
  } catch (e) {
    // debugPrint(e is AppException ? e.message : e.toString());
    rethrow;
  }
}
}
