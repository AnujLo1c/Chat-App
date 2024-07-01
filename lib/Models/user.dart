import 'chatroom.dart';

class ChatUser{
  String nickName;
  String email;
  String downloadProfileUrl;
  List<Chatroom> chatrooms;
  ChatUser({required this.nickName,required this.email,required this.chatrooms,required this.downloadProfileUrl});

  Map<String, dynamic> toMap() {
    return {
      'nickName': nickName,
      'email': email,
      'downloadProfileUrl': downloadProfileUrl,
      'chatrooms': [],
    };
  }
}