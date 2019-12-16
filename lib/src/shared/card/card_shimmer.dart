import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardShimmer extends StatelessWidget {
  
  const CardShimmer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 10,
      child: Container(
        height: 170,
        alignment: Alignment.bottomCenter,
        color: Colors.grey[300],
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                height: 170,
                color: Colors.white,
              ),
            ),
           const Center(
              child: Text(
                "Loading...",
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
