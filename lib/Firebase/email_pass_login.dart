import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class EmailPassLoginAl {
  final _auth = FirebaseAuth.instance;
  loginInAL(BuildContext context, String email, String password) async {
    try {
      if (!validateEmailAL(email)) {
        showSnackbarAL("Email badly formatted.", context);
        return false;
      }

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("///////////////////////////////////////////////////////////");
      if (!_auth.currentUser!.emailVerified) {
        Get.toNamed("/email_verify");
      }
      print(
          "!_auth.currentUser!.emailVerified ${!_auth.currentUser!.emailVerified}");
      showSnackbarAL("Login successful.", context);

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        showSnackbarAL("No User Found for that Email and Password.", context);
      } else {
        showSnackbarAL(e.message.toString(), context);
      }
      return false;
      // Navigator.pop(context);
    } catch (e) {
      showSnackbarAL(e.toString(), context);
      return false;
    }
  }

  signUpAL(BuildContext context, String email, String password) async {
    try {
      if (!validateEmailAL(email)) {
        showSnackbarAL("Email badly formatted.", context);
        return false;
      }
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      showSnackbarAL("Account created successful.", context);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        showSnackbarAL("Account with this email Already exists", context);
        Get.toNamed("/email_verify", arguments: email);
      } else if (e.code == 'weak-password') {
        showSnackbarAL("Password Provided is too Weak", context);
      } else {
        showSnackbarAL(e.message.toString(), context);
      }
      return false;
    } catch (e) {
      showSnackbarAL(e.toString(), context);
      return false;
    }
  }

  resetPasswordAL(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackbarAL("Password Reset Email has been sent !", context);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showSnackbarAL("No user found for that email.", context);
      }
      return false;
    }
  }

  Future<bool> deleteUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
        print('User deleted successfully');
        return true;
      } else {
        print('No user is currently signed in');
        return false;
      }
    } catch (e) {
      print('Failed to delete user: $e');
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print("signout failded");
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
//         showSnackbarAL("Email Successfully Verified", context);
//
//        return true;
//       }
//     }
//     return false;
//   }
  ///////////////////////////////////////////// Validation ////////////////////////////////////////////////////

  showSnackbarAL(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      style: const TextStyle(fontSize: 18.0),
    )));
  }

  validateEmailAL(String email) {
    if (EmailValidator.validate(email)) {
      if (email.endsWith("@gmail.com")) {
        return true;
      }
    }
    return false;
  }
}
