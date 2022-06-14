import 'package:chat_socket/screens/HomeScreen.dart';
import 'package:chat_socket/screens/LoginScreen.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
          ),
          colorScheme: const ColorScheme.light().copyWith(
            primary: const Color(0xFF075E54),
            secondary: const Color(0xFF128C7E),
          ),
        ),
        home: LoginScreen());
  }
}
