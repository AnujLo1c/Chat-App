import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsta_chat/Controllers/Pages_Controller/ProfileScreenControllers/edit_screen_controller.dart';
import 'package:whatsta_chat/Controllers/Pages_Controller/user_profile_controller.dart';
import 'package:whatsta_chat/Firebase/firestore_firebase.dart';
import 'package:whatsta_chat/UiHelper/profile_widgets.dart';
import 'package:whatsta_chat/Widgets/appBarAL.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EditScreenController editScreenController = Get.put(EditScreenController());

    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: appBarAl(title: "Edit Details", check: true),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final isEditing = editScreenController.check.value;
                return Container(
                  height: size.height / (isEditing ? 6 : 16),
                  width: size.width - 40,
                  child: isEditing
                      ? Column(
                    children: [
                      TextField(
                        controller: editScreenController.textEditingController,
                        minLines: 1,
                        maxLength: 32,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                      editScreenController.editName();
                          editScreenController.check.value = false;
                        },
                        child: Text("Change"),
                      ),
                    ],
                  )
                      : ElevatedButton(
                    onPressed: () {
                      editScreenController.check.value = true;
                    },
                    child: Text("Edit Details"),
                  ),
                );
              }),
              Gap(20),
              SizedBox(
                height: 50,
                width: size.width-40,
                child: ElevatedButton(
                    onPressed: (){
    _showImageSourceActionSheet(context, editScreenController);

                    },
                    child: Text("Change Profile")),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _showImageSourceActionSheet(BuildContext context, EditScreenController controller) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () async {
                Navigator.of(context).pop();
                await controller.pickImage(ImageSource.gallery);
                controller.editProfile();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Camera'),
              onTap: () async {
                Navigator.of(context).pop();
                await controller.pickImage(ImageSource.camera);
                controller.editProfile();
              },
            ),
          ],
        ),
      );
    });
  }
}
