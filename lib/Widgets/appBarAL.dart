import 'package:flutter/material.dart';

appBarAl({required String title,bool? check}){
  return AppBar(
    automaticallyImplyLeading: check??false,
    backgroundColor: Colors.blue,
    title: Text(title),
    titleSpacing: 30
    ,
  );
}

