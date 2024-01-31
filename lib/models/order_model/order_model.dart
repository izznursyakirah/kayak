import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kayak/models/product_model/product_model.dart';

class OrderModel {
  OrderModel({
    required this.orderId,
    required this.payment,
    required this.totalPrice,
    required this.products,
    required this.status,
  });

  String payment;
  String status;

  List<ProductModel> products;
  double totalPrice;
  String orderId;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"] ?? [];
    return OrderModel(
        orderId: json["orderId"] ?? "",
        products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
        totalPrice: json["totalPrice"] ?? 0.0,
        status: json["status"] ?? "",
        payment: json["payment"] ?? "");
  }
}
