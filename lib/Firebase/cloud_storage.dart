import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:whatsta_chat/Firebase/email_pass_login.dart';
import 'package:whatsta_chat/Widgets/snackbarAL.dart';

class CloudStorage{
  FirebaseStorage fs=FirebaseStorage.instance;
  uploadImageAL(File? file, String name) async {
  String downloadURL="";
    Reference ref=fs.ref().child('profile/$name');
    try {
      await ref.putFile(file!);
      print("File uploaded successfully.");
    }
    catch(e){
print("File upload fail.");
    }
    finally{
     downloadURL = await ref.getDownloadURL();
    }
    return downloadURL;
  }

  /////////////////////////////////////////////////////////////////////Delete Profile/////////////////////////////////////////////////
  deleteProfile(String? email) async {
    if(email!.isEmpty ||email=="")return false;
    final desertRef = fs.ref().child('profile/$email');
try{
    await desertRef.delete();
return false;
}
catch(e){
  print(e.toString());
  return false;
}
  }

  Future<String> editProfile(File? image) async {
    var name=EmailPassLoginAl().authUser.currentUser?.email;
    String downloadURL="";
   var ref= await fs.ref().child('profile/$name');
    try {
      await ref.putFile(image!);
      showSuccessSnackbar("File uploaded successfully.");
    }
    catch(e){
      showErrorSnackbar("File upload fail.");
    }
    finally{
      downloadURL = await ref.getDownloadURL();
    }
    return downloadURL;
  }
}