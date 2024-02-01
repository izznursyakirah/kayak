import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kayak/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:kayak/firebase_helper/firebase_options/firebase_options.dart';
import 'package:kayak/constants/theme.dart';
import 'package:kayak/provider/app_provider.dart';
import 'package:kayak/screens/auth_ui/welcome/welcome.dart';
import 'package:kayak/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 Stripe.publishableKey = "pk_test_51Of2uoJGOfc4oQ5Fd2Zy5NCPKr0YNqfqkHMaQXsu70aLuBzPqzY8UAS2WOQ77K0IM8tke5mKl8s58u4kxKJZjwVs003EL1Cn4b";
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
        title: 'Kayak Booking and Tracking System',
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottomBar();
            }
            return const Welcome();
          },
        ),
      ),
    );
  }
}
