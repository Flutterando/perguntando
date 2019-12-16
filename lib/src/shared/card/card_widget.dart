import 'package:animated_card/animated_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/shared/card/card_shimmer.dart';
export 'card_shimmer.dart';

class CardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String date;
  final void Function() onPressed;

  const CardWidget({
    Key key,
    @required this.title,
    @required this.imageUrl,
    @required this.subtitle,
    @required this.onPressed,
    @required this.date,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 10,
      child: InkWell(
        onTap: onPressed,
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: imageUrl,
              placeholder: (context, val) => const CardShimmer(),
            ),
            Container(
              height: 170,
              alignment: Alignment.bottomCenter,
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  Expanded(
                    child: ClipRect(
                      child: AnimatedCard(
                        direction: AnimatedCardDirection.bottom,
                        initDelay: const Duration(seconds: 1),
                        initOffset: const Offset(0, 85),
                        child: Container(
                          width: double.infinity,
                          color: Colors.black.withOpacity(.7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                subtitle,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                date ?? "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
