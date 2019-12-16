import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:perguntando/src/shared/models/event/lecture_model.dart';

class CardEvent extends StatelessWidget {
  final LectureModel lectureModel;
  final Function onPressed;
  final String tag;

  const CardEvent(
      {Key key, this.onPressed, @required this.tag, this.lectureModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: <Widget>[
          Hero(
            tag: tag,
            child: Container(
              width: 230,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Container(
            padding:const EdgeInsets.all(20),
            width: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: "${tag}_image",
                      child: CircleAvatar(
                        maxRadius: 30,
                        backgroundImage: CachedNetworkImageProvider(
                          "${lectureModel?.presenter?.photo}",
                        ),
                      ),
                    ),
                    Hero(
                      tag: "${tag}_time",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          "${DateFormat('HH:mm').format(lectureModel?.infoDate)}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Hero(
                  tag: "${tag}_name",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "${lectureModel?.presenter?.name}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Container(height: 5),
                Hero(
                  tag: "${tag}_talk",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "${lectureModel?.title}",
                      style: TextStyle(color: Colors.grey[700], fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.commentAlt,
                      color: Colors.grey[500],
                      size: 18,
                    ),
                    Container(
                      width: 3,
                    ),
                    Text(
                      lectureModel.counter > 99
                          ? "+99"
                          : "${lectureModel.counter}",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
