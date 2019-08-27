import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:perguntando/src/home/pages/question/components/question_card.dart';
import 'package:perguntando/src/home/pages/question/components/custom_appbar.dart';
import 'package:perguntando/src/home/pages/new_question/new_question.dart';
import 'package:perguntando/src/home/pages/question/question_bloc.dart';
import 'package:perguntando/src/home/pages/question/question_module.dart';
import 'package:perguntando/src/shared/models/enums.dart';
import 'package:perguntando/src/shared/models/lecture_question_model.dart';
import 'package:radial_button/widget/circle_floating_button.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final questionBloc = QuestionModule.to.bloc<QuestionBloc>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<CircleFloatingButtonState> floatingButtonKey =
      GlobalKey<CircleFloatingButtonState>();
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
        stream: questionBloc.filterOut,
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
      floatingActionButton: CircleFloatingButton.floatingActionButton(
        items: <Widget>[
          StreamBuilder<FilterQuestionOrdination>(
              stream: questionBloc.typeFilterOut,
              builder: (context, snapshot) {
                return FloatingActionButton(
                  heroTag: UniqueKey().toString(),
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    questionBloc?.setFilter(
                      (snapshot.data == FilterQuestionOrdination.LIKE_MORE)
                          ? FilterQuestionOrdination.BY_DATE
                          : FilterQuestionOrdination.LIKE_MORE,
                    );
                    floatingButtonKey.currentState.close();
                  },
                  child: Icon(
                    (snapshot.data == FilterQuestionOrdination.LIKE_MORE)
                        ? FontAwesomeIcons.calendar
                        : FontAwesomeIcons.thumbsUp,
                  ),
                );
              }),
          StreamBuilder<FilterQuestionOrdination>(
              stream: questionBloc.typeFilterOut,
              builder: (context, snapshot) {
                return FloatingActionButton(
                  heroTag: UniqueKey().toString(),
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    // ANCHOR  pegar a ultima snapshot para voltar para ela
                    questionBloc?.setFilter(
                        (snapshot.data == FilterQuestionOrdination.MY_QUESTIONS)
                            ? FilterQuestionOrdination.BY_DATE
                            : FilterQuestionOrdination.MY_QUESTIONS);
                    floatingButtonKey.currentState.close();
                  },
                  child: Icon(
                      (snapshot.data == FilterQuestionOrdination.MY_QUESTIONS)
                          ? Icons.clear
                          : FontAwesomeIcons.comment),
                );
              }),
          FloatingActionButton(
              heroTag: UniqueKey().toString(),
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (BuildContext context) => NewQuestionPage(),
                  ),
                );
                floatingButtonKey.currentState.close();
              }),
        ],
        color: Theme.of(context).primaryColor,
        icon: Icons.menu,
        key: floatingButtonKey,
        duration: Duration(milliseconds: 100),
        useOpacity: true,
        curveAnim: Curves.ease,
      ),
    );
  }
}
