import 'package:flutter/material.dart';
import 'package:kayak/constants/constants.dart';
import 'package:kayak/screens/cart_item_checkout/cart_item_checkout.dart';
import 'package:kayak/screens/cart_screen/widgets/single_cart_item.dart';
import 'package:kayak/screens/check_out/check_out.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../provider/app_provider.dart';
import '../../widgets/primary_button/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "\RM${appProvider.totalPrice().toString()}",
                      style: const TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              PrimaryButton(
                title: "Checkout",
                onPressed: () {
                  if (appProvider.getCartProductList.isEmpty) {
                    showMessage("Cart is Empty");
                  } else {
                    appProvider.clearBuyProduct();
                    appProvider.addBuyProductCartList();
                    appProvider.clearCart();
                    Routes.instance.push(
                        widget: const CartItemCheckout(), context: context);
                  }
                },
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        //backgroundColor: Colors.white,
        title: const Text(
          "Booking Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? const Center(
              child: Text("Empty"),
            )
          : ListView.builder(
              itemCount: appProvider.getCartProductList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              }),
    );
  }
}
