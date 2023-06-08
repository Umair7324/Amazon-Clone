// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/services/error_handling.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  Future<List<Product>> fetchCategoryProducts(
      BuildContext context, String category) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> products = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.token
      });

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              products
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }

  Future<List<Product>> fetchSearchProducts(
      BuildContext context, String querySearch) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> products = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products/search/$querySearch'), headers: {
        'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.token
      });

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              products
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }

  void rateProduct(
      Product product, BuildContext context, double ratings) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.token
        },
        body: jsonEncode(
          {'id': product.id, 'rating': ratings},
        ),
      );
      httpErrorHandling(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Product> getDealOftheDay(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    Product product = Product(
        name: '',
        description: '',
        price: 0,
        quantity: 0,
        category: '',
        imageUrl: []);
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-the-day'), headers: {
        'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.token
      });
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            product = Product.fromJson(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
