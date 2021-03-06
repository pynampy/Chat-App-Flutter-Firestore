import 'package:firebase_auth/firebase_auth.dart';

import './screens/auth_screen.dart';

import './screens/chat_screen.dart';
import 'package:flutter/material.dart';


//USERNAME IS CAUSING THE APP TO HANG. POSSIBLE FIXES



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        )
        
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context,userSnapsht){
          if(userSnapsht.hasData){
            return ChatScreen();
          }
          return AuthScreen();
        }),
    );
  }
}
