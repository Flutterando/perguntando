import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perguntando/src/login/pages/sign_up/sign_up_bloc.dart';
import 'package:perguntando/src/shared/widgets/circular_image/circular_image_widget.dart';
import '../../login_bloc.dart';
import '../../login_module.dart';
import 'package:validators/validators.dart' as validators;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var loginBloc = LoginModule.to.bloc<LoginBloc>();
  var singUpBloc = LoginModule.to.bloc<SignUpBloc>();
  Size get size => MediaQuery.of(context).size;
  final _keyButton = GlobalKey();

  OutlineInputBorder outlineborder({Color erroColor = Colors.blue}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: erroColor, width: 2),
    );
  }

  Widget _buttonRegister(bool isLoading) {
    return AnimatedContainer(
      key: _keyButton,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(40),
      ),
      width: 150,
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: singUpBloc.onSingUp,
          child: !isLoading
              ? Container(
                  width: 150,
                  height: 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  child: Center(
                    child: Text(
                      "CADASTRAR",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(10),
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
//        color: Colors.greenAccent,
        alignment: Alignment.center,
        padding: EdgeInsets.all(25),
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<String>(
                stream: singUpBloc.outPhoto,
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Container(child: Text(snapshot.error.toString()));
                  else
                    return Center(
                      child: CircularImageWidget(
                        icon: Icons.add_a_photo,
                        imageUrl:
                            (snapshot.hasData && snapshot.data != 'loading')
                                ? snapshot.data
                                : null,
                        onPress: showUploadImageDialog,
                      ),
                    );
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "CADASTRO",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Form(
                autovalidate: true,
                key: singUpBloc.singUpformKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: size.width,
                      child: TextFormField(
                        onSaved: (v) {
                          singUpBloc.name = v;
                        },
                        validator: (v) {
                          if (v.length <= 5) {
                            return 'Nome muito curto';
                          }
                          if (v.isEmpty) {
                            return 'Nome invalido';
                          }
                        },
                        maxLines: 1,
                        style: TextStyle(color: Color(0xffA7A7A7)),
                        minLines: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          focusedBorder: outlineborder(),
                          border: outlineborder(),
                          enabledBorder: outlineborder(),
                          disabledBorder: outlineborder(),
                          errorBorder: outlineborder(erroColor: Colors.red),
                          hasFloatingPlaceholder: false,
                          hintText: "seu nome",
                          hintStyle: TextStyle(color: Color(0xffA7A7A7)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: size.width,
                      child: TextFormField(
                        onSaved: (v) {
                          singUpBloc.email = v;
                        },
                        validator: (v) {
                          if (!validators.isEmail(v)) {
                            return "Email Invalido";
                          }
                        },
                        maxLines: 1,
                        style: TextStyle(color: Color(0xffA7A7A7)),
                        minLines: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusedBorder: outlineborder(),
                          border: outlineborder(),
                          enabledBorder: outlineborder(),
                          disabledBorder: outlineborder(),
                          errorBorder: outlineborder(erroColor: Colors.red),
                          hasFloatingPlaceholder: false,
                          hintText: "seu email",
                          hintStyle: TextStyle(color: Color(0xffA7A7A7)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: size.width,
                      child: TextFormField(
                        onSaved: (v) {
                          singUpBloc.password = v;
                        },
                        validator: (v) {
                          singUpBloc.password = v;
                          if (v.length <= 6) {
                            return "Senha muito curta";
                          }
                          if (v.isEmpty) {
                            return "Senha invalida";
                          }
                        },
                        maxLines: 1,
                        style: TextStyle(color: Color(0xffA7A7A7)),
                        minLines: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusedBorder: outlineborder(),
                          border: outlineborder(),
                          enabledBorder: outlineborder(),
                          disabledBorder: outlineborder(),
                          errorBorder: outlineborder(erroColor: Colors.red),
                          hasFloatingPlaceholder: false,
                          hintText: "digita sua senha",
                          hintStyle: TextStyle(color: Color(0xffA7A7A7)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: size.width,
                      child: TextFormField(
                        validator: (v) {
                          if (v != singUpBloc.password) {
                            return "Senhas incompatíveis";
                          }
                        },
                        maxLines: 1,
                        style: TextStyle(color: Color(0xffA7A7A7)),
                        minLines: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusedBorder: outlineborder(),
                          border: outlineborder(),
                          enabledBorder: outlineborder(),
                          disabledBorder: outlineborder(),
                          errorBorder: outlineborder(erroColor: Colors.red),
                          hasFloatingPlaceholder: false,
                          hintText: "senha novamente",
                          hintStyle: TextStyle(
                            color: Color(0xffA7A7A7),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    StreamBuilder(
                      stream: singUpBloc.outError,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          Text(
                            snapshot.error.toString(),
                            style: TextStyle(color: Colors.red),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                    Container(
                      child: StreamBuilder<bool>(
                        stream: singUpBloc.outLoading,
                        initialData: false,
                        builder: (context, snapshot) {
                          return _buttonRegister(snapshot.data);
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () {
                          loginBloc.pageController.animateToPage(
                            0,
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.ease,
                          );
                        },
                        child: Text(
                          "voltar para o login",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xffA7A7A7),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showUploadImageDialog() async {
    FocusScope.of(context).requestFocus(FocusNode());
    await showDialog(
      context: context,
      builder: (context) => StreamBuilder<String>(
        stream: singUpBloc.outPhoto,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data == 'loading') {
            return AlertDialog(
              title: Text(
                'Aguarde...',
                style: TextStyle(color: Colors.blueGrey),
              ),
              content: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey),
                ),
                child: Container(
                    height: size.height * .1,
                    child: Center(child: CircularProgressIndicator())),
              ),
            );
          }
          return AlertDialog(
            title: Text(
              'Procure uma imagem',
              style: TextStyle(color: Colors.blueGrey),
            ),
            content: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.blue,
                    ),
                    iconSize: 60,
                    onPressed: () async {
                      final _isFile =
                          await singUpBloc.setImageRegister(ImageSource.camera);
                      if (_isFile) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.blue,
                    ),
                    iconSize: 60,
                    onPressed: () async {
                      final _isFile = await singUpBloc
                          .setImageRegister(ImageSource.gallery);
                      if (_isFile) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
