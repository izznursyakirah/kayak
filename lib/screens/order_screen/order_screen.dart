import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayak/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:kayak/models/order_model/order_model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Your Booking",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null ||
              snapshot.data!.isEmpty ||
              !snapshot.hasData) {
            return const Center(
              child: Text("No Booking Found"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              OrderModel orderModel = snapshot.data![index];
              return ExpansionTile(
                
                title: Text(
                  orderModel.payment, // Assuming item has a property playerName
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      orderModel
                          .status, // Assuming item has a property description
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
