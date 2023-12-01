import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kayak/firebase_helper/firebase_options/firebase_options.dart';
import 'package:kayak/constants/theme.dart';
import 'package:kayak/screens/auth_ui/welcome/welcome.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseConfig.plaftformOptions,
    );

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
