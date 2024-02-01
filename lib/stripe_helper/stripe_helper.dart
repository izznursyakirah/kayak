import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeHelper {
  Map<String, dynamic>? paymentIntent;

  static var instance;

  Future<void> makePayment(String amount) async {
    try {
   
      paymentIntent = await createPaymentIntent(amount, 'GBP');

      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "GB",
        currencyCode: "GBP",
        testEnv: true,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: 'Izznur',
          googlePay: gpay,
        ),
      );

      displayPaymentSheet();
    } catch (err) {}
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        print("Payment Successfully");
      });
    } catch (e) {
      print('$e');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51Of2uoJGOfc4oQ5F2PEu0oBVcHzVXjrrNgzvdlvQyN85H4sQIEw8P8sM3LEvTg0a2lPQMpoyR83vRDcYEl93LpVy00qgAqIime',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
