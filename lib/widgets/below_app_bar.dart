import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      child: RichText(
          text: TextSpan(
              text: 'Hello, ',
              style: const TextStyle(fontSize: 22, color: Colors.black),
              children: [
            TextSpan(
                text: user.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
          ])),
    );
  }
}
