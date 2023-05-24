
import 'package:get_it/get_it.dart';
import 'package:innlyn/core/services/api_service.dart';
import 'package:innlyn/core/services/connectivity_service.dart';
import 'package:innlyn/core/services/location_services.dart';
import 'package:innlyn/core/services/navigation_service.dart';
import 'package:innlyn/core/services/notification_service.dart';
import 'package:innlyn/core/services/storage_service.dart';
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerLazySingleton<LocationService>(() => LocationService());
  locator.registerSingleton<NotificationService>(NotificationService());
  locator.registerSingleton<ConnectivityService>(ConnectivityService());
  locator.registerLazySingleton<ApiService>(() => ApiService());
  locator.registerLazySingleton<StorageService>(() => StorageService());
}
