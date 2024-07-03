import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whatsta_chat/Screens/Pages/chats_home_screen.dart';
import 'package:whatsta_chat/Screens/Pages/user_profile.dart';

import '../Widgets/appBarAL.dart';

class HomeScreenController extends GetxController{
  var pages=[ChatsHomeScreen(),UserProfile()];

  Rx<int> currentPage=0.obs ;
  PageController pageController=PageController(initialPage: 0);

  onPageChage(int index) {
    currentPage.value=index;
  }

  onBNavItemTap(int index) {
currentPage.value=index;
    pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }
}