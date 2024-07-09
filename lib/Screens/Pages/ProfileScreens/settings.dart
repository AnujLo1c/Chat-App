import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/Pages_Controller/ProfileScreenControllers/settings_controller.dart';


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final SettingsController controller = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          Obx(() {
            return SwitchListTile(
              activeColor: Colors.blue,
              title: Text('Push Notification'),
              value: controller.isPushNotificationEnabled.value,
              onChanged: (value) {
                controller.togglePushNotification();
              },
            );
          }),
          Obx(() {
            return SwitchListTile(
              activeColor: Colors.blue,
              title: Text('Theme'),
              value: controller.isDarkThemeEnabled.value,
              onChanged: (value) {
                controller.toggleTheme();
              },
            );
          }),
        ],
      ),
    );
  }
}
