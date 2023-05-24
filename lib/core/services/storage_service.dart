import 'package:hive_flutter/hive_flutter.dart';
import 'package:innlyn/core/services/service_locator.dart';

import '../constants.dart';

final StorageService storageService = locator.get<StorageService>();

class StorageService {
  Future initHiveInApp() async {
    await Hive.initFlutter();
    await Hive.openBox(hiveBoxName);
  }

  clearBox()async{
    var box = Hive.box(hiveBoxName);
    box.clear();
  }

  Future<String>? getAuthToken() async {
    try {
      var box = Hive.box(hiveBoxName);
      String token = box.get('TOKEN_STORE_KEY');
      return token;
    } catch (e) {
      rethrow;
    }
  }

  void setAuthToken(String token) async {
    try {
      var box = Hive.box(hiveBoxName);
      box.put('TOKEN_STORE_KEY', token);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?>? getThemeStatus() async {
    try {
      var box = Hive.box(hiveBoxName);
      bool? token = box.get('THEME_STORE_KEY');
      return token;
    } catch (e) {
      rethrow;
    }
  }

  void setThemeStatus(bool token) async {
    try {
      var box = Hive.box(hiveBoxName);
      box.put('THEME_STORE_KEY', token);
    } catch (e) {
      rethrow;
    }
  }

  void setLatitude(String value) async {
    try {
      var box = Hive.box(hiveBoxName);
      box.put(latitudeHiveKey, value);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?>? getLatitude() async {
    try {
      var box = Hive.box(hiveBoxName);
      String? value = box.get(latitudeHiveKey);

      return value;
    } catch (e) {
      rethrow;
    }
  }

  void setLongitude(String value) async {
    try {
      var box = Hive.box(hiveBoxName);
      box.put(longitudeHiveKey, value);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?>? getLongitude() async {
    try {
      var box = Hive.box(hiveBoxName);
      String? value = box.get(longitudeHiveKey);

      return value;
    } catch (e) {
      rethrow;
    }
  }
}
