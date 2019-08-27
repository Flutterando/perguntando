import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:perguntando/src/shared/widgets/image_viewer/image_viewer_widget.dart';
import '../question_module.dart';
import '../question_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double size;

  CustomAppBar({@required this.size});

  @override
  Size get preferredSize => Size.fromHeight(size);

  @override
  Widget build(BuildContext context) {
    final questionBloc = QuestionModule.to.bloc<QuestionBloc>();

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Hero(
          tag: questionBloc.tag,
          child: Card(elevation: 10),
        ),
        SafeArea(
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BackButton(color: Theme.of(context).primaryColor),
                Hero(
                  tag: "${questionBloc.tag}_image",
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ImageViewerWidget.network(
                            questionBloc.lecture.presenter.photo),
                      );
                    },
                    child: CircleAvatar(
                        maxRadius: 25,
                        backgroundImage: CachedNetworkImageProvider(
                          "${questionBloc.lecture.presenter.photo}}",
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: "${questionBloc.tag}_name",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              "${questionBloc.lecture.presenter.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Hero(
                          tag: "${questionBloc.tag}_talk",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              "${questionBloc.lecture.title}",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Hero(
                  tag: "${questionBloc.tag}_time",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "${DateFormat('hh:mm').format(questionBloc.lecture.infoDate)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
