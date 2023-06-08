import 'package:amazon_clone/screens/admin_order_screen.dart';
import 'package:amazon_clone/screens/analytics_screen.dart';
import 'package:amazon_clone/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import '../constants/global_variables.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int pageIndex = 0;

  List pages = [
    const PostsScreen(),
    const AnalyticsScreen(),
    const AdminOrderScreen()
  ];

  void pageSelect(int page) {
    setState(() {
      pageIndex = page;
    });
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
                  child: const Icon(Icons.analytics_outlined),
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
                  child: const Icon(Icons.inbox_outlined),
                ),
                label: ''),
          ]),
    );
  }
}
