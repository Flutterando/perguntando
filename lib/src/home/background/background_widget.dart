import 'package:flutter/material.dart';

class BackgroundWidget extends StatefulWidget {


  const BackgroundWidget({Key key}) : super(key: key);
  @override
  _BackgroundWidgetState createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  double get radius => MediaQuery.of(context).size.width * 0.5;
  double get leftDistance => radius * 0.5;
  double get topDistance => radius * 0.3;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -leftDistance,
      top: -topDistance,
      child: CircleAvatar(
        radius: radius,
      ),

    );
  }
}
