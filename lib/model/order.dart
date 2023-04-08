// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazon_clone/model/product.dart';

class Order {
  final String id;
  final String address;
  final List<Product> products;
  final List<int> quantity;
  final String userId;
  final int orderAt;
  final int status;
  final double totalPrice;

  Order(
      {required this.id,
      required this.address,
      required this.products,
      required this.quantity,
      required this.userId,
      required this.orderAt,
      required this.status,
      required this.totalPrice});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'userId': userId,
      'orderAt': orderAt,
      'status': status,
      'totalPrice': totalPrice
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      address: map['address'] as String,
      products: List<Product>.from(
        map['products']?.map(
          (x) => Product.fromMap(x['product']),
        ),
      ),
      quantity: List<int>.from(map['products']?.map((x) => x['quantity'])),
      userId: map['userId'] ?? '',
      orderAt: map['orderAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
