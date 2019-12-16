import 'package:flutter/material.dart';

import 'bottom_clip_shadow_path.dart';
import 'bottom_clipper.dart';

class BottomWidget extends StatelessWidget {
 

  const BottomWidget({Key key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomClipShadowPath(
      shadow: Shadow(
        color: Colors.black.withOpacity(.3),
        blurRadius: 8,
      ),
      clipper: const BottomClipper(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Color(0xFFF8F8F8)),
        child: SafeArea(
          bottom: true,
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.network(
                  "https://flutterando.com.br/wp-content/uploads/2019/06/flutterando_logo.png",
                  width: 35,
                  height: 35,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Text(
                    "Perguntando",
                    style: TextStyle(
                      color: Color(0xFF848484),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
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
