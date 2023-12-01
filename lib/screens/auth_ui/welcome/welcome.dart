import 'package:flutter/material.dart';
import 'package:kayak/constants/asset_images.dart';
import 'package:kayak/constants/routes.dart';
import 'package:kayak/screens/auth_ui/login/login.dart';
import 'package:kayak/screens/auth_ui/sign_up/sign_up.dart';
import 'package:kayak/widgets/primary_button/primary_button.dart';
import 'package:kayak/widgets/top_titles/top_titles.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopTitles(subtitle: "BUY ANYTHING YOU WANT", title: "Welcome"),
          Center(
            child: Image.asset(
              AssetsImages.instance.welcomeImage,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          PrimaryButton(
            title: "Login",
            onPressed: () {
              Routes.instance.push(widget: const Login(), context: context);
            },
          ),
          const SizedBox(
            height: 18.0,
          ),
          PrimaryButton(
            title: "Sign Up",
            onPressed: () {
               Routes.instance.push(widget: SignUp(), context: context);
            },
          ),
        ],
      ),
    ));
  }
}
