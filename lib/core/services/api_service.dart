
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:innlyn/core/errors/exceptions.dart';
import 'package:innlyn/core/services/api_client.dart';
import 'package:innlyn/core/services/service_locator.dart';
import 'package:dio/dio.dart';

final ApiService apiService = locator.get<ApiService>();

class ApiService {
  BaseClient? api = BaseClient();

  setAuthorisation(String token) {
    api?.setToken(token);
  }

  _processError(e) {
    // if (e is ClientException && e.statusCode == 401) {
    ///Force log out if access token is invalid.
      // Navigator.pushAndRemoveUntil(
      //     navigationService.currentContext,
      //     MaterialPageRoute(
      //         builder: (context) => const LoginScreen(forceSignOut: true)),
      //     (route) => false);
    // }
  }

  Future getRemoteConfig() async {
    try {
      const url = "https://configs.vcareservice.com/user_app_config.json";
      var response =
          await api?.getRemoteConfig(url: url, isAuthenticated: false);
      return response;
    } catch (e) {
      _processError(e);
      rethrow;
    }
  }

  Future getOtp({String? mobileNumber}) async {
    try {
      const url = "/app/auth/otp";
      var formData = FormData.fromMap({"phoneNumber": mobileNumber});
      var response =
          await api?.post(url: url, payload: formData, isAuthenticated: false);
      return response;
    } catch (e) {
      _processError(e);
      rethrow;
    }
  }

  Future mobileSignIn({String? mobileNumber, String? deviceToken, String? verificationCode}) async {
    try {
      const url = "/app/auth/login";
      dynamic payload = {"phoneNumber": mobileNumber, "deviceToken": deviceToken, "verificationCode": int.parse(verificationCode??'')};
      var response =
      await api?.post(url: url, payload: payload, isAuthenticated: false);
      return response;
    } catch (e) {
      _processError(e);
      rethrow;
    }
  }

  Future createConnect({required String description, required LatLng pickup, required LatLng drop}) async {
    try {
      const url = "/app/connect";
      dynamic payload = {"description": description, "pickup": [pickup.latitude, pickup.longitude], "drop": [drop.latitude, pickup.longitude]};
      var response =
      await api?.post(url: url, payload: payload, isAuthenticated: true);
      return response;
    } catch (e) {
      _processError(e);
      rethrow;
    }
  }
  Future searchConnect({required LatLng pickup, required LatLng drop}) async {
    try {
      const url = "/app/connect/search";
      dynamic payload = {"pickup": [pickup.latitude, pickup.longitude], "drop": [drop.latitude, drop.longitude]};
      var response =
      await api?.post(url: url, payload: payload, isAuthenticated: true);
      return response;
    } catch (e) {
      _processError(e);
      rethrow;
    }
  }
  Future cancelConnect() async {
    try {
      const url = "/app/connect/cancel";
      var response =
      await api?.post(url: url, payload: null, isAuthenticated: true);
      return response;
    } catch (e) {
      _processError(e);
      rethrow;
    }
  }
}
