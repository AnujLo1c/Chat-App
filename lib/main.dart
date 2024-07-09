import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsta_chat/Screens/Login/email_verification_screen.dart';
import 'package:whatsta_chat/Screens/Login/forgetPassword_screen.dart';
import 'package:whatsta_chat/Screens/Login/signUp_screen.dart';
import 'package:whatsta_chat/Screens/Pages/ProfileScreens/edit_screen.dart';
import 'package:whatsta_chat/Screens/Pages/chatRoomScreen.dart';
import 'package:whatsta_chat/Screens/home_screen.dart';
import 'package:whatsta_chat/Screens/Login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsta_chat/firebase_options.dart';

import 'Screens/Pages/ProfileScreens/settings.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Whatsta Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: [
GetPage(name: "/login", page: ()=>LoginScreen()),
        GetPage(name: "/sign_up", page: () =>  const SignupScreen(),),
        GetPage(name: "/forget_pass", page: () =>  ForgetpasswordScreen(),),
        GetPage(name: "/email_verify", page: () =>  const EmailVerificationScreen(),),
        GetPage(name: "/home", page: () => const HomeScreen(),),
        GetPage(name: "/chat_room", page: () => const ChatRoomScreen(),),
        GetPage(name: "/edit_screen", page: () => const EditScreen(),),
        GetPage(name: "/settings", page: () => SettingsScreen(),),
      ],
initialRoute: "home",
unknownRoute: GetPage(name: "/login", page: ()=>LoginScreen()),
    );
  }
}
