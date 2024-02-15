import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayak/models/product_model/product_model.dart';
import 'package:kayak/provider/app_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;

  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueGrey, width: 3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Colors.blueGrey.withOpacity(0.5),
              child: Image.network(
                widget.singleProduct.image,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.singleProduct.name,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                CupertinoButton(
                                  onPressed: () {
                                    if (qty > 1) {
                                      setState(() {
                                        qty--;
                                      });
                                      appProvider.updateQty(
                                          widget.singleProduct, qty);
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 12,
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                                Text(
                                  qty.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CupertinoButton(
                                  onPressed: () {
                                    setState(() {
                                      qty++;
                                    });

                                    appProvider.updateQty(
                                        widget.singleProduct, qty);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 12,
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "RM${widget.singleProduct.price.toString()}",
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          appProvider.removeCartProduct(widget.singleProduct);
                          showMessage("Remove from Cart");
                        },
                        child: const CircleAvatar(
                          maxRadius: 13,
                          child: Icon(
                            Icons.delete,
                            size: 17,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
