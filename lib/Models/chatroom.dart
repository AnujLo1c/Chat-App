
import 'package:flutter/cupertino.dart';

class Chatroom{
  String roomName;
  List<String> participants;
  String lastMsg;
  String dateTime;
  Chatroom({required this.roomName,required this.lastMsg,required this.participants,required this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      'roomName': roomName,
      'lastMsg': lastMsg,
      'dateTime': dateTime,
      'participants': participants,
    };
  }
  factory Chatroom.fromMap(Map<String, dynamic> map) {
    return Chatroom(
      roomName: map['roomName'] as String,
      lastMsg: map['lastMsg'] as String,
      dateTime: map['dateTime'] as String,
      participants: List<String>.from(map['participants'] as List<dynamic>),
    );
  }
}