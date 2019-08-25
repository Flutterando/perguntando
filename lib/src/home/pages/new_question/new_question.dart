import 'package:flutter/material.dart';
import 'package:perguntando/src/home/pages/question/question_module.dart';

import 'new_question_bloc.dart';

class NewQuestionPage extends StatefulWidget {
  @override
  _NewQuestionPageState createState() => _NewQuestionPageState();
}

class _NewQuestionPageState extends State<NewQuestionPage> {
  var bloc = QuestionModule.to.bloc<NewQuestionBloc>();
  var formKey = GlobalKey<FormState>();
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).primaryColor),
        // iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Nova pergunta",
          style: TextStyle(color: Colors.grey, fontSize: 16.5),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  margin: const EdgeInsets.only(top: 15, left: 10),
                  child: TextFormField(
                    maxLength: 140,
                    focusNode: focusNode,
                    controller: bloc.perguntaTextController,
                    autofocus: true,
                    //  expands: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Digite a sua pergunta aqui...",
                      hintStyle: TextStyle(color: Colors.blue[800]),
                    ),
                    maxLines: null,
                    validator: (data) {
                      if (data.length < 15) {
                        showDialog(
                            context: context,
                            builder: (innerContext) {
                              return AlertDialog(
                                title: Text("Alerta"),
                                content: Text(
                                    "A mensagem deve possuir mais de 15 caracteres."),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(innerContext).pop();
                                      focusNode.requestFocus();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            });
                        return "A mensagem deve possuir mais de 15 caracteres.";
                      }

                      if (data.length > 140) {
                        showDialog(
                            context: context,
                            builder: (innerContext) {
                              return AlertDialog(
                                title: Text("Alerta"),
                                content: Text(
                                    "A mensagem não pode ter mais de 140 caracteres."),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(innerContext).pop();
                                      focusNode.requestFocus();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            });
                        return "A mensagem deve possuir mais de 140 caracteres.";
                      }

                      return null;
                    },
                  ),
                ),
              ),
            ),
          ),
          Hero(
            tag: "a",
            child: InkWell(
              onTap: () async {
                var valid = formKey.currentState.validate();
                if (valid) {
                  var inserted = await bloc.sendMessage();
                  if(inserted){
                     showDialog(
                            context: context,
                            builder: (innerContext) {
                              return AlertDialog(
                                title: Text("Sucesso"),
                                content: Text(
                                    "Pergunta enviada com sucesso!"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      bloc.perguntaTextController.clear();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            });                   
                  } else {
                   showDialog(
                            context: context,
                            builder: (innerContext) {
                              return AlertDialog(
                                title: Text("Alerta"),
                                content: Text(
                                    "Ocorreu um erro ao tentar enviar sua mensagem. Tente mais tarde."),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(innerContext).pop();
                                      focusNode.requestFocus();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            });
                  }
                }
              },
              child: Container(
                height: 60,
                alignment: Alignment.center,
                child: Icon(Icons.add, size: 40, color: Colors.white),
                color: Colors.blue[800],
              ),
            ),
          ),
        ],
      ),     
    );
  }
}
