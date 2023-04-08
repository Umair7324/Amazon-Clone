import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/screens/add_Product_screen.dart';
import 'package:amazon_clone/screens/address_screen.dart';
import 'package:amazon_clone/screens/auth_Screen.dart';
import 'package:amazon_clone/screens/category_deals_screen.dart';
import 'package:amazon_clone/screens/home_screen.dart';
import 'package:amazon_clone/screens/order_detail_screen.dart';
import 'package:amazon_clone/screens/product_detail_screen.dart';
import 'package:amazon_clone/screens/search_screen.dart';
import 'package:amazon_clone/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          builder: ((_) => const AuthScreen()), settings: routeSettings);
    case HomeScreen.routeName:
      return MaterialPageRoute(
          builder: ((_) => const HomeScreen()), settings: routeSettings);
    case BottomNavigation.routeName:
      return MaterialPageRoute(
          builder: ((context) => const BottomNavigation()),
          settings: routeSettings);
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          builder: ((context) => const AddProductScreen()),
          settings: routeSettings);
    case CategoryDealScreen.routeName:
      String category = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: ((context) => CategoryDealScreen(text: category)),
          settings: routeSettings);
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: ((context) => SearchScreen(
                searchQuery: searchQuery,
              )),
          settings: routeSettings);
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          builder: ((context) => ProductDetailScreen(
                product: product,
              )),
          settings: routeSettings);
    case AddressScreen.routeName:
      var totalSum = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: ((context) => AddressScreen(
                totalSum: totalSum,
              )),
          settings: routeSettings);
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          builder: (_) => OrderDetailScreen(
                order: order,
              ));
    default:
      return MaterialPageRoute(
          builder: ((context) => const Scaffold(
                body: Center(
                  child: Text('404 error page not found'),
                ),
              )));
  }
}
