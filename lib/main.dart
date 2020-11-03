import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mychat_app/screens/chat.dart';
import 'package:mychat_app/screens/chatroom.dart';

// import 'package:mychat_app/screens/home.dart';
import 'package:mychat_app/screens/login.dart';
import 'package:mychat_app/screens/map.dart';
import 'package:mychat_app/screens/reg.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "chat",
      routes: {
        // "home": (context) => MyHome(),
        "reg": (context) => MyReg(),
        "login": (context) => MyLogin(),
        "chat": (context) => MyChat(),
        "map": (context) => Gmaps(),
        "room": (context) => MyChatRoom(),
      },
    ),
  );
}