import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayak/constants/constants.dart';
import 'package:kayak/models/product_model/product_model.dart';
import 'package:kayak/provider/app_provider.dart';
import 'package:kayak/screens/check_out/check_out.dart';
import 'package:kayak/screens/cart_screen/cart_screen.dart';
import 'package:kayak/screens/favourite_screen/location_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance
                  .push(widget: const CartScreen(), context: context);
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.singleProduct.image,
              height: 350,
              width: 350,
            ),
            Text(
              widget.singleProduct.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(widget.singleProduct.description),
            const SizedBox(
              height: 12.00,
            ),
            Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    if (qty >= 1) {
                      setState(() {
                        qty--;
                      });
                    }
                  },
                  padding: EdgeInsets.zero,
                  child: const CircleAvatar(
                    child: Icon(Icons.remove),
                  ),
                ),
                Text(
                  qty.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                CupertinoButton(
                  onPressed: () {
                    setState(() {
                      qty++;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: const CircleAvatar(
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    ProductModel productModel =
                        widget.singleProduct.copyWith(qty: qty);
                    appProvider.addCartProduct(productModel);
                    showMessage("Added to Cart");
                  },
                  child: const Text("ADD TO CART"),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                SizedBox(
                  height: 38,
                  width: 140,
                  child: ElevatedButton(
                    onPressed: () {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      Routes.instance.push(
                          widget: Checkout(singleProduct: productModel),
                          context: context);
                    },
                    child: Text(
                      "RENT NOW",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors
                            .white, // Change this value to make the text smaller
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 52.0,
            ),
          ],
        ),
      ),
    );
  }
}
