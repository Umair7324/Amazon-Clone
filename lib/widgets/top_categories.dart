import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCatgories extends StatelessWidget {
  const TopCatgories({super.key});

  void goToCategory(String category, BuildContext context) {
    Navigator.pushNamed(context, CategoryDealScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 75,
          itemCount: GlobalVariables.categoryImages.length,
          itemBuilder: ((context, index) => GestureDetector(
                onTap: (() => goToCategory(
                    GlobalVariables.categoryImages[index]['title']!, context)),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          GlobalVariables.categoryImages[index]['image']!,
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    Text(
                      GlobalVariables.categoryImages[index]['title']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12),
                    )
                  ],
                ),
              ))),
    );
  }
}
