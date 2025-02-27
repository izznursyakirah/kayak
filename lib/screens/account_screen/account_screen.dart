import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayak/constants/routes.dart';
import 'package:kayak/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:kayak/provider/app_provider.dart';
import 'package:kayak/screens/change_password/change_password.dart';
import 'package:kayak/screens/edit_profile/edit_profile.dart';
import 'package:kayak/screens/favourite_screen/location_screen.dart';
import 'package:kayak/screens/order_screen/order_screen.dart';
import 'package:kayak/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Account",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(children: [
        Expanded(
          child: Column(
            children: [
              appProvider.getUserInformation.image == null
                  ? const Icon(
                      Icons.person_outline,
                      size: 120,
                    )
                  : CircleAvatar(
                      backgroundImage:
                          NetworkImage(appProvider.getUserInformation.image!),
                      radius: 60,
                    ),
              Text(
                appProvider.getUserInformation.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                appProvider.getUserInformation.email,
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 150,
                height: 30.0,
                child: PrimaryButton(
                  title: "Edit Profile",
                  onPressed: () {
                    Routes.instance
                        .push(widget: const EditProfile(), context: context);
                  },
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Column(children: [
              ListTile(
                onTap: () {
                  Routes.instance
                      .push(widget: const OrderScreen(), context: context);
                },
                leading: const Icon(Icons.book_online_outlined),
                title: const Text("Your Booking"),
              ),
              ListTile(
                onTap: () {
                  Routes.instance
                      .push(widget: LocationScreen(), context: context);
                },
                leading: const Icon(Icons.location_on_rounded),
                title: const Text("Location"),
              ),
              ListTile(
                onTap: () {
                  Routes.instance
                      .push(widget: const ChangePassword(), context: context);
                },
                leading: const Icon(Icons.change_circle_outlined),
                title: const Text("Change Password"),
              ),
              ListTile(
                onTap: () {
                  FirebaseAuthHelper.instance.signOut();
                  setState(() {});
                },
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Log Out"),
              ),
              const SizedBox(
                height: 12.0,
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
