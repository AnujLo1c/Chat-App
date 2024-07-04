import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsta_chat/Controllers/Pages_Controller/user_profile_controller.dart';
import 'package:whatsta_chat/Firebase/cloud_storage.dart';
import 'package:whatsta_chat/Firebase/firestore_firebase.dart';

class EditScreenController extends GetxController{
  TextEditingController textEditingController=TextEditingController();
  UserProfileController userProfileController = Get.find<UserProfileController>();
  var check=false.obs;
Size? size;
  var image = Rx<File?>(null);
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> editName() async {
    await FirestoreFirebaseAL().editName(textEditingController.text);
  }
  Future<void> editProfile() async {
    var dlink=await CloudStorage().editProfile(image.value);
    if(dlink!=""){
      FirestoreFirebaseAL().editDownloadLink(dlink);
    }

  }
@override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    userProfileController.fetchUserProfile();
  }

}