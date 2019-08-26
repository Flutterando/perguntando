import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:perguntando/src/home/pages/question/components/question_card.dart';
import 'package:perguntando/src/home/pages/question/components/custom_appbar.dart';
import 'package:perguntando/src/home/pages/new_question/new_question.dart';
import 'package:perguntando/src/home/pages/question/question_bloc.dart';
import 'package:perguntando/src/home/pages/question/question_module.dart';
import 'package:perguntando/src/shared/models/lecture_question_model.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final questionBloc = QuestionModule.to.bloc<QuestionBloc>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      var max = scrollController.position.maxScrollExtent;

      var offset = scrollController.offset;
      if (offset > max - 20) {
        questionBloc.getMoreQuestions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(size: 80),
      body: StreamBuilder<List<LectureQuestionModel>>(
        stream: questionBloc.questions,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Ocorreu um erro",
                style: TextStyle(color: Colors.redAccent),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data.length < 1) {
            return Center(
              child: Text(
                "Ainda não tem perguntas aqui, seja o primeiro!",
                softWrap: true,
              ),
            );
          }

          return ListView.builder(
            controller: scrollController,
            itemCount: snapshot.data.length,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.3),
            itemBuilder: (_, index) {
              return QuestionCard(
                lectureQuestionModel: snapshot.data[index],
                scaffoldKey: scaffoldKey,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "a",
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          size: 28,
        ),
        onPressed: () {
          // Navigator.push(
          //   context,
          //   PageRouteBuilder(
          //     transitionDuration: Duration(milliseconds: 500),
          //     pageBuilder: (context, go, back) => NewQuestionPage(),
          //     transitionsBuilder: (context, go, back, widget) => FadeTransition(
          //       opacity: go,
          //       child: widget,
          //     ),
          //   ),
          // );
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => NewQuestionPage(),
            ),
          );
        },
      ),
    );
  }
}
