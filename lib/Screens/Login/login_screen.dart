import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsta_chat/Controllers/Login_Controller/login_controller.dart';
import 'package:whatsta_chat/Firebase/email_pass_login.dart';
import 'package:whatsta_chat/Firebase/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsta_chat/Screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

   @override
   Widget build(BuildContext context) {
     LoginController loginController=Get.put(LoginController());
     return Scaffold(
       appBar: AppBar(
         title: const Text('Login'),
       ),
       body: Padding(
         padding: const EdgeInsets.all(16.0),
         child: Form(
           key: loginController.formKey,
           child: Column(
             children: <Widget>[
               TextFormField(
                 controller: loginController.emailController,
                 decoration: const InputDecoration(labelText: 'Email'),
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter your email';
                   }
                   return null;
                 },
               ),
               TextFormField(
                 controller: loginController.passwordController,
                 decoration: const InputDecoration(labelText: 'Password'),
                 obscureText: true,
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter your password';
                   }
                   return null;
                 },
               ),
               const SizedBox(height: 20),
               ElevatedButton(
                 onPressed: () async {
loginController.loginUser();
                 },
                 child: const Text('Login'),
               ),

               ElevatedButton(onPressed: (){
                 Get.toNamed("/sign_up");
               }, child: const Text("Sign-Up")),
               ElevatedButton(onPressed: (){
                 Get.toNamed("/forget_pass");
               }, child: const Text("Forget-pass")),
               ElevatedButton(onPressed: () async {
                 if(await GoogleSignInAL().signInGoogle(context)){

                   Get.toNamed("/home");
                 }
               }, child: const Text("Google"))
             ],
           ),
         ),
       ),
     );
   }
}