import 'package:flutter/material.dart';

Widget buildProfileAvatar() {
  return ClipOval(
    child: Image.asset(
      'assets/images/profile.jpg',
      width: 60,
      height: 60,
      fit: BoxFit.cover,
    ),
  );
}