import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileController extends GetxController {
  var nickName = ''.obs;
  var downloadProfileUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    print("asdfa");
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc("anujlowanshi3@gmail.com")
        .get();

    nickName.value = userDoc["nickName"];
    downloadProfileUrl.value = userDoc["downloadProfileUrl"];
    print(nickName.value);
    nickName.refresh();
  }

}
