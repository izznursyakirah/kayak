// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayak/constants/constants.dart';
import 'package:kayak/constants/routes.dart';
import 'package:kayak/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:kayak/screens/auth_ui/sign_up/sign_up.dart';
import 'package:kayak/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:kayak/screens/home/home.dart';
import 'package:kayak/widgets/primary_button/primary_button.dart';
import 'package:kayak/widgets/top_titles/top_titles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitles(
                subtitle: "Welcome Back To Kayak Booking With Tracking System",
                title: "Login"),
            const SizedBox(
              height: 46.0,
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(
                  Icons.email_outlined,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: password,
              obscureText: isShowPassword,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(
                  Icons.password_outlined,
                ),
                suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                        print(isShowPassword);
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    )),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
              title: "Login",
              onPressed: () async {
                bool isVaildated = loginValidation(email.text, password.text);
                if (isVaildated) {
                  bool isLogined = await FirebaseAuthHelper.instance
                      .login(email.text, password.text, context);
                  if (isLogined) {
                    Routes.instance.pushAndRemoveUntil(
                      widget: const CustomBottomBar(),
                      context: context,
                      predicate: (route) => false,
                    );
                  }
                }
              },
            ),
            const SizedBox(
              height: 24.0,
            ),
            const Center(child: Text("Dont have an account?")),
            const SizedBox(
              height: 12.0,
            ),
            Center(
              child: CupertinoButton(
                onPressed: () {
                  Routes.instance
                      .push(widget: const SignUp(), context: context);
                },
                child: Text(
                  "Create an account",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
