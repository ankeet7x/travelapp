import 'package:flutter/material.dart';

class CoverStack extends StatelessWidget {
  final size;
  final guideText;
  CoverStack({required this.size, required this.guideText});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(55, 20),
                bottomRight: Radius.elliptical(55, 20)),
            child: Image.asset(
              'assets/cover.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
          height: size.height / 2.75,
        ),
        Positioned(
            top: size.height * 0.275,
            left: size.width * 0.10,
            child: Text(
              guideText,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ))
      ],
    );
  }
}
