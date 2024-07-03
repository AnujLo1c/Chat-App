import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/home_screen_controller.dart';
import 'package:whatsta_chat/Widgets/appBarAL.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenController homeScreenController = Get.put(HomeScreenController());
    return SafeArea(
        child: Scaffold(
            body: PageView(
              controller: homeScreenController.pageController,
              children: homeScreenController.pages,
              onPageChanged: (value) => homeScreenController.onPageChage(value),
            ),
            bottomNavigationBar: Obx(() {
              return BottomNavigationBar(
                  currentIndex: homeScreenController.currentPage.value,
                  backgroundColor: Colors.blue,
                  selectedItemColor: Colors.white,
                  onTap: (value) => homeScreenController.onBNavItemTap(value),
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.chat_outlined,
                        color: Colors.grey.shade50,
                      ),
                      label: "Chat",
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey.shade50,
                        ),
                        label: "Profile"),
                  ]);
            })));
  }
}
