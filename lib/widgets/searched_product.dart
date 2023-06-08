import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/widgets/stars.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  const SearchedProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: const Stars(
                    rating: 4,
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
    );
  }
}
