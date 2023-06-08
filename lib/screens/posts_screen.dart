import 'package:amazon_clone/constants/utills.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:amazon_clone/widgets/single_product.dart';
import 'package:flutter/material.dart';
import './add_Product_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  addProductScreen() {
    Navigator.of(context).pushNamed(AddProductScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    fetchANdSeTProducts();
  }

  void fetchANdSeTProducts() async {
    products = await utills().fetchAndSetproducts(context);
    setState(() {});
  }

  void deleteProducts(Product product, int index) async {
    utills().deleteProduct(context, product, () {
      products!.removeAt(index);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: ((context, index) {
                  final productData = products![index];
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: SingleProduct(
                            image: productData.imageUrl[0],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                productData.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  deleteProducts(productData, index);
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        )
                      ],
                    ),
                  );
                })),
            floatingActionButton: FloatingActionButton(
              onPressed: addProductScreen,
              tooltip: 'add a product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
