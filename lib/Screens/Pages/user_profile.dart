import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsta_chat/Controllers/Pages_Controller/user_profile_controller.dart';
import 'package:whatsta_chat/UiHelper/profile_widgets.dart';
import 'package:gap/gap.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    UserProfileController userProfileController = Get.put(UserProfileController());
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(20),
                Center(
                  child: Obx((){

                    return Column(
                      children: [
                        const Text("Profile"),
                        const Gap(20),
                        ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            height: 150,
                            width: 150,
                            imageUrl: userProfileController.downloadProfileUrl
                                .value,
                            placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                            const CircleAvatar(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              radius: 100,
                              child: Icon(
                                Icons.person,
                                size: 90,
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Text(
                          userProfileController.nickName.value,
                          style: const TextStyle(fontSize: 22),
                        ),
                      ],
                    );
                  }
                  ),
                ),
                const Gap(40),
                Container(
                  height: size.height / 2,
                  child: ListView(
                    padding: const EdgeInsets.all(15),
                    children: [
                      ProfileWidgets().buildProfileOption(size, Icons.edit, "Edit", () {
                        Get.toNamed("/edit_screen");
                      }),
                      const Gap(10),
                      ProfileWidgets().buildProfileOption(size, Icons.settings, "Settings", () {
                        Get.toNamed("/settings");
                      }),
                      const Gap(10),
                      ProfileWidgets().buildProfileOption(size, Icons.logout, "Log-out", () {
                        Get.offNamedUntil("/login", (route) => route.settings.name == "/login");
                      }),
                    ],
                  ),
                ),
              ],
            ),
          )

      )
    );
  }
}
