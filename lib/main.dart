import 'package:flutter/material.dart';
// flutter dotenv
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/screens/welcome_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
