import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayak/constants/routes.dart';
import 'package:kayak/screens/home/home.dart';
import 'package:kayak/widgets/primary_button/primary_button.dart';
import 'package:kayak/widgets/top_titles/top_titles.dart';

import '../../../constants/constants.dart';
import '../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isShowPassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
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
                title: "SignUp"),
            const SizedBox(
              height: 46.0,
            ),
            TextFormField(
              controller: name,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: "Name",
                prefixIcon: Icon(
                  Icons.person_outlined,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
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
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Phone Number",
                prefixIcon: Icon(
                  Icons.phone_outlined,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: password,
              obscureText: isShowPassword,
              keyboardType: TextInputType.visiblePassword,
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
              title: "Create an account",
              onPressed: () async {
                 bool isVaildated = signUpValidation(email.text, password.text,name.text, phone.text);
                if (isVaildated) {
                  bool isLogined = await FirebaseAuthHelper.instance
                      .signUp(name.text, email.text, password.text, context);
                  if (isLogined) {
                    Routes.instance.pushAndRemoveUntil(
                      widget: const Home(), context: context);
              }
            }
              },
            ),
            const SizedBox(
              height: 24.0,
            ),
            const Center(child: Text("Already have an account?")),
            const SizedBox(
              height: 12.0,
            ),
            Center(
              child: CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Login",
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

