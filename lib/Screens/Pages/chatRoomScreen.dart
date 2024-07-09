import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsta_chat/Controllers/chat_room_controller.dart';
import 'package:whatsta_chat/Models/message_model.dart';
import 'package:whatsta_chat/Widgets/appBarAL.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({super.key});
  @override
  Widget build(BuildContext context) {
ChatRoomController chatRoomController=Get.put(ChatRoomController());

    return Scaffold(
      appBar: appBarAl(title: "Chats",check: true),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chatrooms")
                  .doc(chatRoomController.chatRoomData[0])
                  .collection("messages")
                  .orderBy("createdon", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                    return ListView.builder(

                      reverse: true,
                      itemCount: dataSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        MessageModel currentMessage = MessageModel.fromMap(
                            dataSnapshot.docs[index].data() as Map<String, dynamic>);
                        return Row(
                          mainAxisAlignment: (currentMessage.sender == chatRoomController.chatRoomData[1])
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 2),
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        constraints: BoxConstraints(
                        maxWidth: 250,
                        maxHeight: 500,
                        ),
                              decoration: BoxDecoration(

                                color: (currentMessage.sender == chatRoomController.chatRoomData[1])
                                    ? Colors.grey
                                    : Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                currentMessage.text.toString(),
                                maxLines: 100,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("An error occurred! Please check your internet connection."),
                    );
                  } else {
                    return Center(
                      child: Text("Say hi to your new friend"),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chatRoomController.messageController,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter message",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Implement sendMessage() method
                    chatRoomController.sendMessage();
                    print("asdfsa");
                  },
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
