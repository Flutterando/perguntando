import 'package:flutter/material.dart';

class BottomClipper extends CustomClipper<Path> {
 
  const BottomClipper();
  
  @override
  Path getClip(Size size) {
    var path = new Path();

    path
      ..moveTo(0, 35)
      ..quadraticBezierTo(size.width/2, 0, size.width, 35)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 35);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}