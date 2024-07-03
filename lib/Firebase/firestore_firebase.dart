import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsta_chat/Firebase/email_pass_login.dart';
import 'package:whatsta_chat/Models/chatroom.dart';
import 'package:whatsta_chat/Widgets/snackbarAL.dart';

import '../Models/user.dart';

class FirestoreFirebaseAL{
  FirebaseFirestore ff=FirebaseFirestore.instance;

  uploadUserDataAL(ChatUser cu) async {
    try{
await ff.collection("users").doc(cu.email).set(cu.toMap());
      print("user profile data success");
    return true;
    }
    catch(e){
      print("user data firebasefirestore upload failed");
      return false;
    }
  }
  deleteUserDataAl(String? docName) async {
    try{
      await ff.collection("users").doc(docName).delete();
      print("user profile data delete success");
      return true;
    }
    catch(e){
      print("user data firebasefirestore delete failed");
      return false;
    }
  }
  checkUserExists(String email) async {
    try{
      var user=await ff.collection("users").doc(email).get();
      print(email);
      print(user.data());
      if(user.data()!=null){
        return true;
      }
      return false;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }

   createChatRoom(Chatroom c, String user1, String user2) async {

    try{
      await ff.collection("chatrooms").doc(c.roomName).set(c.toMap());
      await ff.collection("users").doc(user1).update({"chatrooms":FieldValue.arrayUnion([c.roomName])});
      await ff.collection("users").doc(user2).update({"chatrooms":FieldValue.arrayUnion([c.roomName])});
    }catch(e){
      showErrorSnackbar(e.toString());
    }
  }

  Future<List<String>> getUserClassrooms() async {
    var data = await ff
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get();
    List<dynamic> chatrooms = data.get("chatrooms");
    return chatrooms.cast<String>();
  }



}