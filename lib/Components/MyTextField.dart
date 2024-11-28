import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  String hintText;
  TextEditingController controller;

  Mytextfield({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.grey.shade300),
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none),
      ),
    );
  }
}
