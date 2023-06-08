import 'dart:io';
import 'package:amazon_clone/constants/utills.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/text_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../constants/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  static const routeName = '/add-product-screen';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<File> images = [];

  void pickImage() async {
    var res = await utills().imagePicker();
    setState(() {
      images = res;
    });
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  String category = 'Mobiles';
  final TextEditingController nameCOnstroller = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void sellProduct() {
    if (formKey.currentState!.validate()) {
      utills().sellProduct(
          context: context,
          name: nameCOnstroller.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: int.parse(quantityController.text),
          catgories: category,
          images: images);
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameCOnstroller.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Admin',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map((e) {
                            return Builder(
                                builder: ((context) => Image.file(
                                      e,
                                      fit: BoxFit.cover,
                                      height: 200,
                                    )));
                          }).toList(),
                          options:
                              CarouselOptions(viewportFraction: 1, height: 200))
                      : GestureDetector(
                          onTap: pickImage,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            dashPattern: const [10, 4],
                            radius: const Radius.circular(10),
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Choose a Image',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      controller: nameCOnstroller, text: 'Product name'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: descriptionController,
                    text: 'Description',
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(controller: priceController, text: 'Price'),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      controller: quantityController, text: 'Quantity'),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                        value: category,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: productCategories.map((String item) {
                          return DropdownMenuItem(
                              value: item, child: Text(item));
                        }).toList(),
                        onChanged: (String? newitem) {
                          setState(() {
                            category = newitem!;
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(ontap: sellProduct, text: 'Sell'),
                ],
              ),
            )),
      ),
    );
  }
}
