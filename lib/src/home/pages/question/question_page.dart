import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perguntando/src/home/pages/question/components/question_card.dart';
import 'package:perguntando/src/home/pages/question/components/custom_appbar.dart';
import 'package:perguntando/src/home/pages/new_question/new_question.dart';
import 'package:perguntando/src/home/pages/question/question_bloc.dart';
import 'package:perguntando/src/home/pages/question/question_module.dart';
import 'package:perguntando/src/shared/models/enums.dart';
import 'package:perguntando/src/shared/models/lecture_question_model.dart';
import 'package:radial_button/widget/circle_floating_button.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key key}) : super(key: key);
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final questionBloc = QuestionModule.to.bloc<QuestionBloc>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final floatingButtonKey = GlobalKey<CircleFloatingButtonState>();
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      var max = _scrollController.position.maxScrollExtent;

      var offset = _scrollController.offset;
      if (offset > max - 20) {
        questionBloc.getMoreQuestions();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const CustomAppBar(size: 80),
      body: StreamBuilder<List<LectureQuestionModel>>(
        stream: questionBloc.filterOut,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Ocorreu um erro",
                style: TextStyle(color: Colors.redAccent),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data.length < 1) {
            return Center(
              child: Text(
                (questionBloc.filter == FilterQuestionOrdination.MY_QUESTIONS)
                    ? 'Você ainda não realizou nenhuma pergunta'
                    : "Ainda não tem perguntas aqui, seja o primeiro!",
                softWrap: true,
              ),
            );
          }
          return ListView.builder(
            controller: _scrollController,
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
                if (snapshot.data != FilterQuestionOrdination.MY_QUESTIONS) {
                  return FloatingActionButton(
                    heroTag: UniqueKey().toString(),
                    backgroundColor: Theme.of(context).primaryColor,
                    tooltip:
                        (snapshot.data == FilterQuestionOrdination.LIKE_MORE)
                            ? 'Por Data'
                            : 'Mais Curtidas',
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
                            ? FontAwesomeIcons.calendarAlt
                            : FontAwesomeIcons.handSpock),
                  );
                } else {
                  return Container();
                }
              }),
          StreamBuilder<FilterQuestionOrdination>(
              stream: questionBloc.typeFilterOut,
              builder: (context, snapshot) {
                return FloatingActionButton(
                    heroTag: UniqueKey().toString(),
                    tooltip:
                        (snapshot.data == FilterQuestionOrdination.MY_QUESTIONS)
                            ? 'Limpar'
                            : 'Minhas Perguntas',
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      questionBloc?.setFilter((snapshot.data ==
                              FilterQuestionOrdination.MY_QUESTIONS)
                          ? FilterQuestionOrdination.BY_DATE
                          : FilterQuestionOrdination.MY_QUESTIONS);
                      floatingButtonKey.currentState.close();
                    },
                    child: Icon(
                        (snapshot.data == FilterQuestionOrdination.MY_QUESTIONS)
                            ? Icons.clear
                            : FontAwesomeIcons.user));
              }),
          FloatingActionButton(
              heroTag: UniqueKey().toString(),
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (BuildContext context) => const NewQuestionPage(),
                  ),
                );
                floatingButtonKey.currentState.close();
              }),
        ],
        color: Theme.of(context).primaryColor,
        icon: Icons.menu,
        key: floatingButtonKey,
        duration: const Duration(milliseconds: 100),
        useOpacity: true,
        curveAnim: Curves.ease,
      ),
    );
  }

  Widget _iconFloatingButton(String text, {IconData icon}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 15,
        ),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 6),
        )
      ],
    );
  }
}
