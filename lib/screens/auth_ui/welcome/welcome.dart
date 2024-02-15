import 'package:flutter/material.dart';
import 'package:kayak/constants/asset_images.dart';
import 'package:kayak/constants/routes.dart';
import 'package:kayak/screens/auth_ui/login/login.dart';
import 'package:kayak/screens/auth_ui/sign_up/sign_up.dart';
import 'package:kayak/widgets/primary_button/primary_button.dart';
import 'package:kayak/widgets/top_titles/top_titles.dart';
import 'package:kayak/screens/custom_bottom_bar/custom_bottom_bar.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Kayak Booking'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center the Column children
            children: [
              Center(
                // Center the Column
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the Column children
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage(AssetsImages.instance.welcomeImage),
                      radius: 60.0, // Double the size of the image
                    ),
                    const TopTitles(
                      subtitle: "KAYAK RIDE",
                      title: '',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
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
                  Routes.instance
                      .push(widget: const SignUp(), context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
