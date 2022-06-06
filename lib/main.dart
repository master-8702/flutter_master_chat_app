import 'package:flutter/material.dart';
import 'package:flutter_master_chat_app/screens/chat_screen.dart';
import 'package:flutter_master_chat_app/screens/login_screen.dart';
import 'package:flutter_master_chat_app/screens/registration_screen.dart';
import 'package:flutter_master_chat_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: WelcomeScreen.id, routes: {
      WelcomeScreen.id: (context) => WelcomeScreen(),
      RegistrationScreen.id: (context) => RegistrationScreen(),
      LoginScreen.id: (context) => LoginScreen(),
      ChatScreen.id: (context) => ChatScreen(),
    });
  }
}
