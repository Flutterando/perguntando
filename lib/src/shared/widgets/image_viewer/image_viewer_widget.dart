import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageViewerWidget extends StatelessWidget {
  final ImageProvider image;

  ImageViewerWidget({Key key, this.image}) : super(key: key);

  factory ImageViewerWidget.memory(Uint8List byteArray) {
    return ImageViewerWidget(image: MemoryImage(byteArray));
  }

  factory ImageViewerWidget.network(String url) {
    return ImageViewerWidget(image: NetworkImage(url));
  }

  factory ImageViewerWidget.asset(String path) {
    return ImageViewerWidget(image: AssetImage(path));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          InkWell(
            onTap: Navigator.of(context).pop,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Container(
              color: Colors.black26,
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: Navigator.of(context).pop,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                IgnorePointer(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 200,
                    width: MediaQuery.of(context).size.width - 30,
                    child: Image(
                      image: image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
