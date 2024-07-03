import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:whatsta_chat/Firebase/email_pass_login.dart';
import 'package:whatsta_chat/Models/chatroom.dart';
import 'package:whatsta_chat/Models/user.dart';
import 'package:whatsta_chat/Widgets/snackbarAL.dart';

import '../../Firebase/firestore_firebase.dart';

class ChatsHomeScreenController extends GetxController {
  addChatRoom(String user2) async {
    if (await FirestoreFirebaseAL().checkUserExists(user2)) {
      String? user1 = EmailPassLoginAl().authUser.currentUser?.email;

      if (user1!.isNotEmpty) {

        Chatroom c = Chatroom(
            roomName: chatRoomName(user1, user2),
            lastMsg: "",
            participants:
              [user1, user2]
            ,
            dateTime: DateFormat('dd MMM').format(DateTime.now()));

        FirestoreFirebaseAL().createChatRoom(c, user1, user2);
      } else {
        showErrorSnackbar("Some error. Please relogin");
      }
    } else {
      showErrorSnackbar("No user found");
    }
  }

  String chatRoomName(String email1, String email2) {
    if (email1.compareTo(email2) > 0) {
      return email2 + email1;
    } else {
      return email1 + email2;
    }
  }

  void showInputDialogChatRoom() {
    TextEditingController textFieldController = TextEditingController();
    Get.defaultDialog(
      title: 'Enter your input',
      content: TextField(
        controller: textFieldController,
        decoration: InputDecoration(hintText: "Type something here"),
      ),
      textCancel: 'Cancel',
      textConfirm: 'OK',
      onCancel: () {},
      onConfirm: () {
        Get.back();
        addChatRoom(textFieldController.text);
      },
    );
  }



}
