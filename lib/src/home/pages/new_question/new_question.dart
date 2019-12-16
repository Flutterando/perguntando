import 'package:flutter/material.dart';
import 'package:perguntando/src/home/pages/question/question_module.dart';
import 'new_question_bloc.dart';

class NewQuestionPage extends StatefulWidget {
  const NewQuestionPage({Key key}) : super(key: key);
  @override
  _NewQuestionPageState createState() => _NewQuestionPageState();
}

class _NewQuestionPageState extends State<NewQuestionPage> {
  var bloc = QuestionModule.to.bloc<NewQuestionBloc>();
  var formKey = GlobalKey<FormState>();
  FocusNode _focusNode;
  final maxLenght = 140;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).primaryColor),
        // iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedBuilder(
                animation: bloc.perguntaTextController,
                builder: (context, _) {
                  final count = bloc.perguntaTextController.text.length;
                  return Text(
                    "$count/$maxLenght",
                    style: const TextStyle(color: Colors.black),
                  );
                },
              ),
            ),
          )
        ],
        title: const Text(
          "Nova pergunta",
          style: TextStyle(color: Colors.grey, fontSize: 16.5),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Form(
              key: formKey,
              child: Container(
                margin: const EdgeInsets.only(top: 15, left: 10),
                child: TextFormField(
                  maxLength: maxLenght,
                  focusNode: _focusNode,
                  controller: bloc.perguntaTextController,
                  autofocus: true,
                  expands: true,
                  decoration: InputDecoration(
                    counter: Container(height: 0),
                    border: InputBorder.none,
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
                              title: const Text("Alerta"),
                              content: const Text(
                                  "A mensagem deve possuir mais de 15 caracteres."),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(innerContext).pop();
                                    _focusNode.requestFocus();
                                  },
                                  child: const Text("OK"),
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
                              title: const Text("Alerta"),
                              content: const Text(
                                  "A mensagem não pode ter mais de 140 caracteres."),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(innerContext).pop();
                                    _focusNode.requestFocus();
                                  },
                                  child: const Text("OK"),
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
          StreamBuilder<bool>(
            initialData: false,
            stream: bloc.isLoading,
            builder: (_, snapshot) {
              return _buttonEnter(snapshot?.data ?? false);
            },
          )
        ],
      ),
    );
  }

  Widget _buttonEnter(bool isLoading) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(40)),
      // width: isLoading ? 60 : MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Hero(
        tag: "a",
        child: Material(
          child: InkWell(
            onTap: isLoading
                ? null
                : () async {
                    var valid = formKey.currentState.validate();
                    if (valid) {
                      var inserted = await bloc.sendMessage();
                      if (inserted) {
                        showDialog(
                          context: context,
                          builder: (innerContext) {
                            return AlertDialog(
                              title: const Text("Sucesso"),
                              content:
                                  const Text("Pergunta enviada com sucesso!"),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    bloc.perguntaTextController.clear();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (innerContext) {
                            return AlertDialog(
                              title: const Text("Alerta"),
                              content: const Text(
                                  "Ocorreu um erro ao tentar enviar sua mensagem. Tente mais tarde."),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(innerContext).pop();
                                    _focusNode.requestFocus();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }

                      bloc.isLoading.add(false);
                    }
                  },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[800],
              ),
              height: 60,
              alignment: Alignment.center,
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Icon(Icons.add, size: 40, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
