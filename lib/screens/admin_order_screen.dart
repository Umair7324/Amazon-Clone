import 'package:amazon_clone/constants/order_apis.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/screens/order_detail_screen.dart';
import 'package:amazon_clone/widgets/single_product.dart';
import 'package:flutter/material.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  List<Order>? orderList;
  @override
  void initState() {
    super.initState();
    fetchAdminSideOrders();
  }

  fetchAdminSideOrders() async {
    orderList = await OrderApis().adminFetchOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orderList == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            itemCount: orderList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (_, index) {
              var orders = orderList![index].products;
              if (orders.isEmpty) {
                return const SizedBox.shrink();
              }
              var imageUrl = orders[0].imageUrl;
              if (imageUrl.isEmpty) {
                return const SizedBox.shrink();
              }
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(OrderDetailScreen.routeName,
                      arguments: orderList![index]);
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                      image: orderList![index].products[0].imageUrl[0]),
                ),
              );
            });
  }
}
