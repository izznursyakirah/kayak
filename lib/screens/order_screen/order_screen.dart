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
            padding: const EdgeInsets.all(12.0),
            itemBuilder: (context, index) {
              OrderModel orderModel = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ExpansionTile(
                  childrenPadding: EdgeInsets.zero,
                  tilePadding: EdgeInsets.zero,
                  collapsedShape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 2.3)),
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 2.3)),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        color: Colors.blueGrey.withOpacity(0.5),
                        child: Image.network(
                          orderModel.products[0].image,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderModel.products[0].name,
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            orderModel.products.length > 1
                                ? SizedBox.fromSize()
                                : Column(
                                    children: [
                                      Text(
                                        "Quantity: ${orderModel.products[0].qty.toString()}",
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                    ],
                                  ),
                            Text(
                              "Total Price: RM${orderModel.totalPrice.toString()}",
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              "Order Status:${orderModel.status}",
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: orderModel.products.length > 1
                      ? [
                          const Text("Hello"),
                        ]
                      : [],
                ),
              );
            },
          );
        },
      ),
    );
  }
}