import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Firebase/email_pass_login.dart';

class ForgetPassController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future<void> resetPass() async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      if(await EmailPassLoginAl().resetPasswordAL(email)){
        print("Reset email send.");
      }
      else{
        print("Some error occured");
      }
    }
  }

}