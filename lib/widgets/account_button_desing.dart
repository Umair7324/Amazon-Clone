// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ButtonDesign extends StatelessWidget {
  const ButtonDesign({super.key, required this.text, required this.ontap});

  final String text;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.circular(50)),
        child: OutlinedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                primary: Colors.black12.withOpacity(0.03)),
            onPressed: ontap,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.normal),
            )),
      ),
    );
  }
}
