import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kayak/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:kayak/firebase_helper/firebase_options/firebase_options.dart';
import 'package:kayak/constants/theme.dart';
import 'package:kayak/provider/app_provider.dart';
import 'package:kayak/screens/auth_ui/welcome/welcome.dart';
import 'package:kayak/screens/home/home.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kayak Booking and Tracking',
        theme: themeData,
        home: StreamBuilder(
            stream: FirebaseAuthHelper.instance.getAuthChange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const Home();
              }
              return const Welcome();
            }),
      ),
    );
  }
}
