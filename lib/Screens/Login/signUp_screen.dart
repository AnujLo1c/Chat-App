import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsta_chat/Firebase/cloud_storage.dart';
import 'package:whatsta_chat/Firebase/email_pass_login.dart';
import 'package:whatsta_chat/Firebase/firestore_firebase.dart';
import 'package:whatsta_chat/Models/user.dart';

import '../../Controllers/Login_Controller/sign_up_controller.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

    @override
    Widget build(BuildContext context) {
      final SignUpController controller = Get.put(SignUpController());

      return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () => _showImageSourceActionSheet(context, controller),
                  child: Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                    controller.image.value != null ? FileImage(controller.image.value!) : null,
                    child: controller.image.value == null ? Icon(Icons.add_a_photo, size: 50) : null,
                  )),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: controller.nicknameController,
                  decoration: InputDecoration(labelText: 'Nickname'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your nickname';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Obx(() => TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscurePassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.toggleObscurePassword,
                    ),
                  ),
                  obscureText: controller.obscurePassword.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                )),
                SizedBox(height: 16),
                Obx(() => TextFormField(
                  controller: controller.confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureConfirmPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.toggleObscureConfirmPassword,
                    ),
                  ),
                  obscureText: controller.obscureConfirmPassword.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != controller.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                )),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    if (controller.formKey.currentState?.validate() ?? false) {
                      // Handle sign up logic here
                      print('Nickname: ${controller.nicknameController.text}');
                      print('Email: ${controller.emailController.text}');
                      print('Password: ${controller.passwordController.text}');
if(await EmailPassLoginAl().signUpAL( controller.emailController.text, controller.passwordController.text)){
  print("here");
  String profileUrl=await CloudStorage().uploadImageAL(controller.image.value,controller.emailController.text);
  if(profileUrl=="" || profileUrl.isEmpty){
  print("here1");
await EmailPassLoginAl().deleteUser();
  print("user failed to upload userproffile");
  }
  else{
  print("here2");

ChatUser signupUser=ChatUser(nickName: controller.nicknameController.text, email: controller.emailController.text, chatrooms: [], downloadProfileUrl: profileUrl);
bool userDataUploadStatus=await FirestoreFirebaseAL().uploadUserDataAL(signupUser);
if(userDataUploadStatus){
  print("here3");
  Get.toNamed("/email_verify");
}
else{
  print("here4");
  EmailPassLoginAl().deleteUser();
  CloudStorage().deleteProfile(controller.emailController.text);
  FirestoreFirebaseAL().deleteUserDataAl(controller.emailController.text);
  print("user failed to upload firebasefirestore");
}
  }

}
else{
  print("here5");
  print("user failed to upload signup firebase auth");

}
                    }
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    void _showImageSourceActionSheet(BuildContext context, SignUpController controller) {
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
                  onTap: () {
                    Navigator.of(context).pop();
                    controller.pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    controller.pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }