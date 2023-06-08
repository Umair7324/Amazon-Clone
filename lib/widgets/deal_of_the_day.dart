import 'package:amazon_clone/constants/apis_call.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/screens/product_detail_screen.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Product? product;
  @override
  void initState() {
    super.initState();
    fetchDealOFtheDay();
  }

  void fetchDealOFtheDay() async {
    product = await ApiCall().getDealOftheDay(context);
    setState(() {});
  }

  void navigateToDetailsScreen() {
    Navigator.of(context)
        .pushNamed(ProductDetailScreen.routeName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailsScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: const Text(
                        'Deal Of the day',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: Image.network(
                        product!.imageUrl[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text('\$100'),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: const Text('Umair'),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: product!.imageUrl
                              .map((e) => Image.network(
                                    e,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fitWidth,
                                  ))
                              .toList()),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(vertical: 15)
                          .copyWith(left: 15),
                      child: Text(
                        'See all deals',
                        style: TextStyle(color: Colors.cyan[800]),
                      ),
                    )
                  ],
                ),
              );
  }
}
