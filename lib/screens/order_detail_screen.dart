import 'package:amazon_clone/constants/order_apis.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/screens/search_screen.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../constants/global_variables.dart';
import '../model/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;
  const OrderDetailScreen({super.key, required this.order});

  static const routeName = '/order-detail-screen';

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  ///** Only for Admins    */

  void changeOrderStatus(int status) {
    OrderApis().changeOrderStatus(
        context: context,
        order: widget.order,
        status: status + 1,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        });
  }

  void navigateToSearchScreen(String query) {
    Navigator.of(context).pushNamed(SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 42,
                color: Colors.transparent,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 22,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'View Order Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Date: ${DateFormat().format(
                    DateTime.fromMillisecondsSinceEpoch(widget.order.orderAt),
                  )}'),
                  Text('Order ID: ${widget.order.id}'),
                  Text('Total Price: ${widget.order.totalPrice}'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Purchase Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < widget.order.products.length; i++)
                    Row(
                      children: [
                        Image.network(
                          widget.order.products[i].imageUrl[0],
                          height: 120,
                          width: 120,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.products[i].name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'qty : ${widget.order.quantity[i]}',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Tracking',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
              ),
              child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (user.type == 'admin') {
                      return CustomButton(
                          ontap: () {
                            return changeOrderStatus(details.currentStep);
                          },
                          text: 'Done');
                    }
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                        title: const Text('Pending'),
                        content:
                            const Text('Your Order is yet to be delivered'),
                        isActive: currentStep > 0,
                        state: currentStep > 0
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text('Completed'),
                        content: const Text(
                            'Your Order has been delivered,you are yet to sign'),
                        isActive: currentStep > 1,
                        state: currentStep > 1
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text('Received'),
                        content: const Text(
                            'Your Order has ben delivered and Signed by you'),
                        isActive: currentStep > 2,
                        state: currentStep > 2
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text('Delivered'),
                        content: const Text(
                            'Your Order has ben delivered and Signed by you'),
                        isActive: currentStep >= 3,
                        state: currentStep >= 3
                            ? StepState.complete
                            : StepState.indexed),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
