import 'package:flutter/material.dart';
import 'package:perguntando/src/shared/widgets/image_viewer/image_viewer_widget.dart';

class CircularImageWidget extends StatelessWidget {
  final String imageUrl;
  final double size;
  final IconData icon;
  final double iconSize;
  final VoidCallback onPress;
  final bool center;

  CircularImageWidget({
    this.imageUrl,
    this.size = 80,
    this.icon,
    this.iconSize = 45,
    this.onPress,
    this.center = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: center
          ? AlignmentDirectional.topCenter
          : AlignmentDirectional.topStart,
      padding: EdgeInsets.only(top: 15),
      child: _buildHero(
        child: CircleAvatar(
          radius: size,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                shape: CircleBorder(),
                child: Stack(
                  children: <Widget>[
                    if (icon != null)
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Color.fromRGBO(0, 0, 0, 490),
                      ),
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: onPress ??
                          () {
                            if (imageUrl != null)
                              ImageViewerWidget.network(imageUrl);
                          },
                      child: null,
                    ),
                  ],
                ),
              ),
              if (icon != null)
                IgnorePointer(
                  child: Icon(
                    icon,
                    size: iconSize,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
          backgroundImage: (imageUrl == null) ? null : NetworkImage(imageUrl),
          backgroundColor: (imageUrl == null)
              ? Theme.of(context).primaryColor.withOpacity(0.8)
              : Colors.transparent,
        ),
      ),
    );
  }

  Widget _buildHero({Widget child}) {
    return (imageUrl == null)
        ? child
        : Hero(
            tag: imageUrl,
            child: child,
          );
  }
}
