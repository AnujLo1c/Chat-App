import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Firebase/email_pass_login.dart';

class LoginController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
loginUser() async {
  print("1");
  if (formKey.currentState!.validate()) {
    var email = emailController.text;
    var password = passwordController.text;
    if( await
    EmailPassLoginAl().loginInAL(email, password)){
  Get.toNamed("/home");
  }
  else{
  print("login Failed");
  }
}
}
}