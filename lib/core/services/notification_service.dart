import 'package:flutter/material.dart';
import 'package:innlyn/core/services/service_locator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum NotificationType { success, error, warning }

final NotificationService notificationService =
    locator.get<NotificationService>();

class NotificationService {
  // final _navigationKey = locator<NavigationService>().navigatorKey;
  void showToast(BuildContext context, String? message,
      {NotificationType type = NotificationType.success}) {
    if (type == NotificationType.success) {
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: message ?? "",
        ),
      );
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: message ?? "",
        ),
      );
    }
  }
}
