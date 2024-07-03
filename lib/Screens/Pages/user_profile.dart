import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/appBarAL.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: appBarAl(title: "Profile"),
body: FutureBuilder(
    future: FirebaseFirestore.instance.collection("users").doc("anujlowanshi3@gmail.com").get(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(
    child: CircularProgressIndicator(
    color: Colors.blue,
    )
    );
    } else if (snapshot.hasError) {
    return Text(
    'Error: ${snapshot.error}',
    );
    } else {
    return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    const Gap(20),

    Center(
    child: Column(
      children: [
        ClipOval(
        child: CachedNetworkImage(
        fit: BoxFit.fill,
        height: 150,
        width: 150,
        imageUrl: snapshot.data?["downloadProfileUrl"],
        placeholder: (context, url) =>
        const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const CircleAvatar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        radius: 100,
        child: Icon(
        Icons.person,
        size: 90,
        ),
        ),
        ),
        ),
        Gap(10),
        Text(snapshot.data?["nickName"],style: TextStyle(fontSize: 22),)
      ],
    ),
    ),
        ])
    );
  }
}
    )
    )
    );
  }
}
