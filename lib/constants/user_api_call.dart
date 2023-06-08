// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/services/error_handling.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'global_variables.dart';

class UserApiCall {
  Future<void> addToCart(BuildContext context, Product product) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/add-to-cart'),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({'id': product.id}));
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUSerFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> removeFromCart(BuildContext context, Product product) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
          Uri.parse('$uri/api/remove-from-cart/${product.id}'),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUSerFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> saveUSerAddress(BuildContext context, String address) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/save-user-address'),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({'address': address}));
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(address: jsonDecode(res.body)['address']);
            userProvider.setUSerFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeAnOrder(
      BuildContext context, String address, double totalSum) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'address': address,
            'cart': userProvider.user.cart,
            'totalPrice': totalSum
          }));
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'your order has been placed successfully');
            User user = userProvider.user.copyWith(cart: []);
            userProvider.setUSerFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
