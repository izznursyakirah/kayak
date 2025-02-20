import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayak/constants/constants.dart';
import 'package:kayak/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';

import '../../widgets/primary_button/primary_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Change Password",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              hintText: "New Password",
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
          SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: isShowPassword,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              hintText: "Confirm Password",
              prefixIcon: const Icon(
                Icons.password_outlined,
              ),
            ),
          ),
          SizedBox(
            height: 36.0,
          ),
          PrimaryButton(
            title: "Update",
            onPressed: () async {
              if (newpassword.text.isEmpty) {
                showMessage("New Password is empty");
              } else if (confirmpassword.text.isEmpty) {
                showMessage("Confirm Password is empty");
              } else if (confirmpassword.text == newpassword.text) {
                FirebaseAuthHelper.instance
                    .ChangePassword(newpassword.text, context);
              } else {
                showMessage("Confirm Password is not match");
              }
              {}
            },
          ),
        ],
      ),
    );
  }
}
