import 'package:flutter/material.dart';
import 'package:kayak/constants/theme.dart';
import 'package:kayak/screens/auth_ui/welcome/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Kayak Booking and Tracking', 
    theme: themeData,
    home: const Welcome()
    );
  }
}
