import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:whatsta_chat/Widgets/snackbarAL.dart';

class EmailPassLoginAl {
  final _auth = FirebaseAuth.instance;
  FirebaseAuth get authUser=>_auth;
  loginInAL( String email, String password) async {
    try {

      if (!validateEmailAL(email)) {
        // showSuccessSnackbar("Email badly formatted.");
        showErrorSnackbar("Email badly formatted.");
        return false;
      }

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("///////////////////////////////////////////////////////////");
      if (!_auth.currentUser!.emailVerified) {
        Get.toNamed("/email_verify");
      }
      print(
          "!_auth.currentUser!.emailVerified ${!_auth.currentUser!.emailVerified}");
      showSuccessSnackbar("Login successful.");

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        showErrorSnackbar("No User Found for that Email and Password.");
      } else {
        showErrorSnackbar(e.message.toString());
      }
      return false;
      // Navigator.pop(context);
    } catch (e) {
      showErrorSnackbar(e.toString());
      return false;
    }
  }

  signUpAL( String email, String password) async {
    try {
      if (!validateEmailAL(email)) {
        showErrorSnackbar("Email badly formatted.");
        return false;
      }
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      showSuccessSnackbar("Account created successful.");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        showErrorSnackbar("Account with this email Already exists");
        Get.toNamed("/email_verify", arguments: email);
      } else if (e.code == 'weak-password') {
        showErrorSnackbar("Password Provided is too Weak");
      } else {
        showErrorSnackbar(e.message.toString());
      }
      return false;
    } catch (e) {
      showErrorSnackbar(e.toString());
      return false;
    }
  }

  resetPasswordAL(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSuccessSnackbar("Password Reset Email has been sent !");

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showSuccessSnackbar("No user found for that email.");

      }
      return false;
    }
  }

  Future<bool> deleteUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
        showSuccessSnackbar('User deleted successfully');
        return true;
      } else {
        showSuccessSnackbar('No user is currently signed in');
        return false;
      }
    } catch (e) {
        showSuccessSnackbar('Failed to delete user: $e');

      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();

        showSuccessSnackbar('Signout Successfully');
      return true;
    } catch (e) {

        showSuccessSnackbar('Signout Failed');
      // print("signout failded");
      return false;
    }
  }

  /////////////////////////////////////////////validation////////////////////////////////////////////////////
//   bool isEmailVerified = false;
//   Timer? timer;
//   @override
//   void initState() {
//     isEmailVerified = false;
//     super.initState();
//     FirebaseAuth.instance.currentUser?.sendEmailVerification();
//     timer =
//         Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
//   }
//   checkEmailVerifiedAL(BuildContext context) async {
//     // Check if currentUser is not null before reloading
//     if (FirebaseAuth.instance.currentUser != null) {
//       await FirebaseAuth.instance.currentUser!.reload();
//        bool isEmailVerifiedAL = FirebaseAuth.instance.currentUser!.emailVerified;
//
//       if (isEmailVerifiedAL) {
//         showSuccessSnackbar("Email Successfully Verified");
//
//        return true;
//       }
//     }
//     return false;
//   }
  ///////////////////////////////////////////// Validation ////////////////////////////////////////////////////

  

  validateEmailAL(String email) {
    if (EmailValidator.validate(email)) {
      if (email.endsWith("@gmail.com")) {
        return true;
      }
    }
    return false;
  }
}
