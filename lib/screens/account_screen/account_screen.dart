import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayak/constants/routes.dart';
import 'package:kayak/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:kayak/provider/app_provider.dart';
import 'package:kayak/screens/edit_profile/edit_profile.dart';
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
                      radius: 70,
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
                onTap: () {},
                leading: const Icon(Icons.shopping_bag_outlined),
                title: const Text("Your Booking"),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.favorite_outline),
                title: const Text("Favourite"),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.info),
                title: const Text("About Us"),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.support_outlined),
                title: const Text("Support"),
              ),
               ListTile(
                onTap: () {},
                leading: const Icon(Icons.support_outlined),
                title: const Text("Support"),
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
