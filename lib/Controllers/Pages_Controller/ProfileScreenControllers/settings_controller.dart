import 'package:get/get.dart';

class SettingsController extends GetxController {
  var isPushNotificationEnabled = false.obs;
  var isDarkThemeEnabled = false.obs;

  void togglePushNotification() {
    isPushNotificationEnabled.value = !isPushNotificationEnabled.value;
  }

  void toggleTheme() {
    isDarkThemeEnabled.value = !isDarkThemeEnabled.value;
  }
}
