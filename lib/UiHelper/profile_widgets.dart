import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileWidgets{
  Widget buildProfileOption(Size size, IconData icon, String text,VoidCallback onTap) {
    return GestureDetector(
     onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2)
        ),
        height: size.height/15,
        width: size.width - 40,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10), // Add some spacing between the icon and the text
            Text(text),
            const Spacer(),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );

  }

}
