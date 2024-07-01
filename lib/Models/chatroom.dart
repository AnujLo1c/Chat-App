import 'package:whatsta_chat/Models/user.dart';

class Chatroom{
  String roomName;
  Map<ChatUser,bool> users;
  String lastMsg;
  DateTime dateTime;
  Chatroom({required this.roomName,required this.lastMsg,required this.users,required this.dateTime});
  Map<String, dynamic> toMap() {
    return {
      'roomName': roomName,
      'lastMsg': lastMsg,
      'dateTime':dateTime,
      'users':{}
    };
  }
}