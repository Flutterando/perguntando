import 'package:flutter/material.dart';

import 'bottom_clip_shadow_path.dart';
import 'bottom_clipper.dart';

class BottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomClipShadowPath(
      shadow: Shadow(
        color: Colors.black.withOpacity(.3),
        blurRadius: 8,
      ),
      clipper: BottomClipper(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Color(0xFFF8F8F8)),
        child: SafeArea(
          bottom: true,
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Image.network(
                  "https://flutterando.com.br/wp-content/uploads/2019/06/flutterando_logo.png",
                  width: 35,
                  height: 35,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    "Perguntando",
                    style: TextStyle(
                      color: Color(0xFF848484),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "by Flutterando",
                    style: TextStyle(
                      color: Color(0xFF747474),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
