import 'package:amazon_clone/constants/apis_call.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/screens/product_detail_screen.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:flutter/material.dart';

import '../constants/global_variables.dart';

class CategoryDealScreen extends StatefulWidget {
  const CategoryDealScreen({super.key, required this.text});

  final String text;

  static const routeName = '/category-deal-screen';

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  List<Product>? productList;
  @override
  void initState() {
    super.initState();
    fetchCatgoriesProducts(widget.text);
  }

  void fetchCatgoriesProducts(String category) async {
    productList = await ApiCall().fetchCategoryProducts(context, widget.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(
            widget.text,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep Shopping for ${widget.text}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                productList!.isEmpty
                    ? Container()
                    : SizedBox(
                        height: 270,
                        child: GridView.builder(
                          itemCount: productList!.length,
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 1.4,
                                  mainAxisSpacing: 10),
                          itemBuilder: ((context, index) {
                            final products = productList![index];
                            return SingleChildScrollView(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      ProductDetailScreen.routeName,
                                      arguments: productList![index]);
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 130,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 0.5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Image.network(
                                              products.imageUrl[0]),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, top: 5, right: 15),
                                        child: Text(
                                          products.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
              ],
            ),
    );
  }
}
