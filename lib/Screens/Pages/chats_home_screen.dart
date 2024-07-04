import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsta_chat/Controllers/Pages_Controller/chats_home_screen_controller.dart';
import 'package:whatsta_chat/Firebase/email_pass_login.dart';
import 'package:whatsta_chat/Widgets/appBarAL.dart';

class ChatsHomeScreen extends StatelessWidget {
  const ChatsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChatsHomeScreenController chatsHomeScreenController =
        Get.put(ChatsHomeScreenController());
  String? currentUser=EmailPassLoginAl().authUser.currentUser?.email;
    return Scaffold(
      appBar: appBarAl(title: "Chat's"),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("chatrooms")
            .where("participants", arrayContains: currentUser)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No chatrooms found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var chatroom = snapshot.data!.docs[index];
                var roomName = chatroom['roomName'].replaceAll(currentUser, "");
                return ListTile(
                  title: Text(roomName),
                  subtitle:Text(chatroom['lastMsg'],maxLines: 1,),
                  onTap: (){
                    Get.toNamed("/chat_room",arguments: [chatroom['roomName'],currentUser, chatroom]);
                  },
                  trailing: Text(chatroom['dateTime'].toString()),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => chatsHomeScreenController.showInputDialogChatRoom()),
    );
  }
}
