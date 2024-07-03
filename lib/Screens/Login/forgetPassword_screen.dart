import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:whatsta_chat/Controllers/Login_Controller/forget_pass_controller.dart';
import 'package:whatsta_chat/Firebase/email_pass_login.dart';

class ForgetpasswordScreen extends StatelessWidget {
   ForgetpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgetPassController forgetPassController=Get.put(ForgetPassController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: forgetPassController.formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: forgetPassController.emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add additional validation for email format if needed
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  forgetPassController.resetPass();
                },
                child: Text('Send Reset Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}