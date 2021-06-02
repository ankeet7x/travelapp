import 'package:flutter/material.dart';

class NameFields extends StatelessWidget {
  final size;
  final fieldController;
  final hintText;

  NameFields(
      {required this.size,
      required this.fieldController,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.85,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
        controller: fieldController,
        validator: (val) {
          if (val!.length < 3) {
            return "name isn't' valid";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(left: 10),
            hintText: hintText),
      ),
    );
  }
}
