import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perguntando/src/home/pages/question/question_module.dart';
import 'package:perguntando/src/shared/models/lecture_question_model.dart';
import 'package:perguntando/src/shared/utils/date_utils.dart';
import 'package:perguntando/src/shared/widgets/image_viewer/image_viewer_widget.dart';

import '../question_bloc.dart';

class QuestionCard extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final LectureQuestionModel lectureQuestionModel;
  const QuestionCard(
      {Key key,
      @required this.lectureQuestionModel,
      @required this.scaffoldKey})
      : super(key: key);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  var bloc = QuestionModule.to.bloc<QuestionBloc>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(10),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: 18, right: 18, bottom: 6, top: 18),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 13),
                      child: GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  ImageViewerWidget.network(widget?.lectureQuestionModel?.user?.photo),
                            );
                          },
                          child: CircleAvatar(
                              maxRadius: 23,
                              backgroundImage: CachedNetworkImageProvider(
                                "${widget?.lectureQuestionModel?.user?.photo}",
                              )),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child:
                              Text("${widget.lectureQuestionModel.user.name}"),
                        ),
                        Text(
                          "${frindlyFormatTime(widget.lectureQuestionModel.infoDate)}",
                          style: const TextStyle(fontSize: 11),
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(top: 13, bottom: 8),
                  child: Text(
                    "${widget.lectureQuestionModel.description}",
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(right: 5, bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (bloc.user.id ==
                      widget.lectureQuestionModel.user.id)
                    FlatButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (innerContext) {
                              return AlertDialog(
                                title: const Text("Alerta"),
                                content: const Text("Deseja excluir essa mensagem?"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(innerContext).pop();
                                    },
                                    child: Text("NÃO"),
                                  ),
                                  FlatButton(
                                    onPressed: () async {
                                      var excluida =
                                          await bloc.deleteLectureQuestion(
                                              widget.lectureQuestionModel);
                                      if (!excluida) {
                                        final snackBar = SnackBar(
                                            content: const Text(
                                                "Não foi possivel excluir"));
                                        widget.scaffoldKey.currentState
                                            .showSnackBar(snackBar);
                                      }
                                      Navigator.of(innerContext).pop();
                                    },
                                    child: const Text("SIM"),
                                  )
                                ],
                              );
                            });
                      },
                      child: Text(
                        "EXCLUIR",
                        style: TextStyle(color: Colors.red[300]),
                      ),
                    ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "${widget.lectureQuestionModel.qtdLike}",
                          style: TextStyle(color: Colors.yellow[800]),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          widget.lectureQuestionModel.isLiked
                              ? FontAwesomeIcons.solidHandSpock 
                              : FontAwesomeIcons.thumbsUp,
                          color: Colors.yellow[800],
                          size: 25,
                        ),
                        onPressed: () async {
                          if (widget.lectureQuestionModel.isLiked) {
                            await bloc.dislike(widget.lectureQuestionModel);
                          } else {
                            await bloc.like(widget.lectureQuestionModel);
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
