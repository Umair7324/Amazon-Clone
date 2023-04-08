// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/services/error_handling.dart';
import '../model/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../model/sales.dart';

class OrderApis {
  Future<List<Order>> fetchUserOrder(BuildContext context) async {
    List<Order> orders = [];
    var userProvider = Provider.of<UserProvider>(context);
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/orders'), headers: {
        'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orders.add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orders;
  }

  Future<List<Order>> adminFetchOrders(BuildContext context) async {
    List<Order> ordersList = [];
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/fetch/admin/orders'), headers: {
        'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              ordersList
                  .add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return ordersList;
  }

  void changeOrderStatus(
      {required BuildContext context,
      required Order order,
      required int status,
      required VoidCallback onSuccess}) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/change/order/status'),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({'id': order.id, 'status': status}));
      httpErrorHandling(response: res, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> fetchAdminAnlytics(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarnings = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            var response = jsonDecode(res.body);
            totalEarnings = int.parse(response['totalEarnings'].toString());
            print(response['totalEarnings'].runtimeType);
            sales = [
              Sales('Mobile', response['mobileEarnings']),
              Sales('Essentials', response['essentialsEarnings']),
              Sales('Appliances', response['appliancesEarnings']),
              Sales('Books', response['booksEarnings']),
              Sales('Fashion', response['fashionEarnings']),
            ];
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
    }
    return {'sales': sales, 'totalEarnings': totalEarnings};
  }
}
