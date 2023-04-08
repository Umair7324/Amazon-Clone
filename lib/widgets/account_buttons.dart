import 'package:amazon_clone/services/auth_services.dart';
import 'package:flutter/material.dart';
import './account_button_desing.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({super.key});

  void userLogOut(BuildContext context) {
    AuthServices().userLogOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonDesign(
                text: 'Your Orders',
                ontap: () {},
              ),
              ButtonDesign(text: 'Turn Sellers', ontap: () {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonDesign(
                  text: 'Log Out',
                  ontap: () {
                    userLogOut(context);
                  }),
              ButtonDesign(text: 'Your Wish List', ontap: () {})
            ],
          )
        ],
      ),
    );
  }
}
