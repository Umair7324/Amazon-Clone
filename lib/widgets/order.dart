import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/order_apis.dart';
import 'package:amazon_clone/screens/order_detail_screen.dart';
import 'package:amazon_clone/widgets/single_product.dart';
import 'package:flutter/material.dart';
import '../model/order.dart' as order;

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<order.Order>? orders;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchingOrders();
  }

  void fetchingOrders() async {
    orders = await OrderApis().fetchUserOrder(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      'See all',
                      style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: orders!.length,
                  itemBuilder: ((context, index) {
                    var products = orders![index].products;
                    if (products.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    var imageUrl = products[0].imageUrl;
                    if (imageUrl.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              OrderDetailScreen.routeName,
                              arguments: orders![index]);
                        },
                        child: SingleProduct(image: imageUrl[0]));
                  }),
                ),
              )
            ],
          );
  }
}
