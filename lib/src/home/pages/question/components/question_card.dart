import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/app_module.dart';
import 'package:perguntando/src/home/pages/question/question_module.dart';
import 'package:perguntando/src/shared/blocs/auth_bloc.dart';
import 'package:perguntando/src/shared/models/lecture_question_model.dart';
import 'package:perguntando/src/shared/utils/date_utils.dart';

import '../question_bloc.dart';

class QuestionCard extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final LectureQuestionModel lectureQuestionModel;
  const QuestionCard({Key key,@required this.lectureQuestionModel,@required this.scaffoldKey}) : super(key: key);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  var authBloc = AppModule.to.bloc<AuthBloc>();
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
                        child: CircleAvatar(
                            maxRadius: 23,
                            backgroundImage: CachedNetworkImageProvider(
                              "${widget?.lectureQuestionModel?.user?.photo}",
                            )),
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
                          style: TextStyle(fontSize: 11),
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
                  if (authBloc.userControleValue.idUser ==
                      widget.lectureQuestionModel.user.idUser)
                    FlatButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (innerContext) {
                              return AlertDialog(
                                title: Text("Alerta"),
                                content: Text("Deseja excluir essa mensagem?"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(innerContext).pop();
                                    },
                                    child: Text("NÃO"),
                                  ),
                                  FlatButton(
                                    onPressed: () async {
                                      var excluida = await bloc.deleteLectureQuestion(widget.lectureQuestionModel);
                                      if (!excluida) {
                                        final snackBar = SnackBar(content: Text("Não foi possivel excluir"));
                                        widget.scaffoldKey.currentState.showSnackBar(snackBar);
                                      }
                                      Navigator.of(innerContext).pop();
                                    },
                                    child: Text("SIM"),
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
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          widget.lectureQuestionModel.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.redAccent,
                          size: 35,
                        ),
                        onPressed: () async {
                          if(widget.lectureQuestionModel.isLiked){
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
