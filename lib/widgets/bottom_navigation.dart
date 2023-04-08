import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/screens/account_screen.dart';
import 'package:amazon_clone/screens/cart_screen.dart';
import 'package:amazon_clone/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badge;

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  static const routeName = '/actual-home';

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int pageIndex = 0;

  List pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void pageSelect(int page) {
    setState(() {
      pageIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCArtLen = Provider.of<UserProvider>(context).user.cart.length;
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          backgroundColor: GlobalVariables.backgroundColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          iconSize: 28,
          currentIndex: pageIndex,
          onTap: pageSelect,
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  width: 42,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: pageIndex == 0
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: 5),
                    ),
                  ),
                  child: const Icon(Icons.home_outlined),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                  width: 42,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: pageIndex == 1
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: 5),
                    ),
                  ),
                  child: const Icon(Icons.person_outline_outlined),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Container(
                  width: 42,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: pageIndex == 2
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: 5),
                    ),
                  ),
                  child: badge.Badge(
                      elevation: 0,
                      badgeContent: Text(userCArtLen.toString()),
                      badgeColor: Colors.white,
                      child: const Icon(Icons.shopping_cart_outlined)),
                ),
                label: ''),
          ]),
    );
  }
}
