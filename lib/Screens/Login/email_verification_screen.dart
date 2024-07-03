
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:whatsta_chat/Controllers/Login_Controller/verify_email_controller.dart';
import 'package:whatsta_chat/Firebase/email_pass_login.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VerifyEmailController verifyEmailController=Get.put(VerifyEmailController());
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        EmailPassLoginAl().signOut();
      },
      child: SafeArea(
        child: Scaffold(

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(20),
                const Center(
                  child: Text(
                    'Verify Email',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      'We have sent you a Email on ${verifyEmailController.fa.currentUser?.email}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      '\nVerifying email....',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          elevation: 5,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)))),
                      child: const Text('Cancel',style: TextStyle(fontSize: 16),),
                      onPressed: () {
                        verifyEmailController.cancelOp();
                      },
                    ),
                    Gap(10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 5,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)))),
                      child: const Text(
                        'Resend',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        verifyEmailController.resendEmail();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
