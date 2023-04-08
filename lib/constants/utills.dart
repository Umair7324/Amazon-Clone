// ignore_for_file: camel_case_types, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/services/error_handling.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'global_variables.dart';

class utills {
  List<File> images = [];
  Future<List<File>> imagePicker() async {
    try {
      var files = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: true);
      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i <= files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return images;
  }

  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required int quantity,
      required String catgories,
      required List<File> images}) async {
    try {
      final cloudinary = CloudinaryPublic('dip690bqg', 'xoyhqwh8');
      List<String> imageUrls = [];
      for (int i = 0; i <= images.length; i++) {
        var userProvider =
            Provider.of<UserProvider>(context, listen: false).user;
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
        Product product = Product(
            name: name,
            description: description,
            price: price,
            quantity: quantity,
            category: catgories,
            imageUrl: imageUrls);
        http.Response response = await http.post(
            Uri.parse(
              '$uri/admin/add-product',
            ),
            headers: {
              'Content-type': 'application/json; charset=UTF-8',
              'x-auth-token': userProvider.token
            },
            body: product.toJson());
        httpErrorHandling(
            response: response,
            context: context,
            onSuccess: (() {
              showSnackBar(context, 'Product added successfully');
            }));
        Navigator.pop(context);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAndSetproducts(BuildContext context) async {
    List<Product> products = [];
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.token
      });
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            products.add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }

  deleteProduct(
      BuildContext context, Product product, VoidCallback onSuccess) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res =
          await http.post(Uri.parse('$uri/admin/delete-product'),
              headers: {
                'Content-type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.token
              },
              body: jsonEncode({'id': product.id}));
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
