import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsta_chat/Firebase/email_pass_login.dart';
import 'package:whatsta_chat/Firebase/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsta_chat/Screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text('Login'),
       ),
       body: Padding(
         padding: const EdgeInsets.all(16.0),
         child: Form(
           key: _formKey,
           child: Column(
             children: <Widget>[
               TextFormField(
                 controller: _emailController,
                 decoration: const InputDecoration(labelText: 'Email'),
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter your email';
                   }
                   return null;
                 },
               ),
               TextFormField(
                 controller: _passwordController,
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
                   if (_formKey.currentState!.validate()) {
                     final email = _emailController.text;
                     final password = _passwordController.text;
                     if( await
EmailPassLoginAl().loginInAL(context, email, password)){
                       Get.toNamed("/home");
                     }
                     else{
                       print("jasdjfheawjkhsdfefasf");
                     }
                   }
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