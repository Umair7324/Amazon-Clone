import 'package:amazon_clone/constants/user_api_call.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    var cartProduct = Provider.of<UserProvider>(context, listen: false)
        .user
        .cart[widget.index];
    var product = Product.fromMap(cartProduct['product']);
    var quantity = cartProduct['quantity'];
    void increaseProduct() {
      UserApiCall().addToCart(context, product);
      setState(() {});
    }

    void decreaseProduct() {
      UserApiCall().removeFromCart(context, product);
      setState(() {});
    }

    return SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.imageUrl[0],
                fit: BoxFit.fitWidth,
                height: 130,
                width: 130,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        maxLines: 2,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Text(
                        '\$${product.price}',
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: const Text(
                        'Eligible for FREE Shipping',
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: const Text(
                        'In Stock',
                        maxLines: 2,
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Colors.black12),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: decreaseProduct,
                        child: Container(
                          alignment: Alignment.center,
                          width: 35,
                          height: 32,
                          child: const Icon(
                            Icons.remove,
                            size: 18,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5, color: Colors.black12),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black12,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 1.5),
                              color: Colors.white),
                          child: Container(
                            alignment: Alignment.center,
                            width: 35,
                            height: 32,
                            child: Text(quantity.toString()),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: increaseProduct,
                        child: Container(
                          alignment: Alignment.center,
                          width: 35,
                          height: 32,
                          child: const Icon(
                            Icons.add,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))
      ]),
    );
  }
}
