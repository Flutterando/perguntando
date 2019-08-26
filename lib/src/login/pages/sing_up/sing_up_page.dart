import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perguntando/src/login/pages/sign_in/sign_in_bloc.dart';
import 'package:perguntando/src/shared/widgets/circular_image/circular_image_widget.dart';
import '../../login_bloc.dart';
import '../../login_module.dart';
import 'sing_up_bloc.dart';
import 'package:validators/validators.dart' as validators;

class SingUpPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  var loginBloc = LoginModule.to.bloc<LoginBloc>();
  var singUpBloc = LoginModule.to.bloc<SingUpBloc>();
  Size get size => MediaQuery.of(context).size;

  OutlineInputBorder outlineborder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.blue, width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
                    if (snapshot.hasError) {
                      return Container(child: Text(snapshot.error.toString()));
                    }
                    if (snapshot.hasData && snapshot.data != 'loading') {
                      return Center(
                        child: CircularImageWidget(
                          icon: Icons.cloud_upload,
                          imageUrl: snapshot.data,
                          onPress: () => showUploadImageDialog(),
                        ),
                      );
                    }
                    return CircularImageWidget(
                        icon: Icons.add_a_photo,
                        imageUrl: singUpBloc.imageUrl,
                        onPress: () => showUploadImageDialog());
                  }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: EdgeInsets.only(right: 10),
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "CADASTRO",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: EdgeInsets.only(right: 10),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                autovalidate: true,
                key: singUpBloc.singUpformKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
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
                        style: TextStyle(
                          color: Color(0xffA7A7A7),
                        ),
                        minLines: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusedBorder: outlineborder(),
                          border: outlineborder(),
                          enabledBorder: outlineborder(),
                          disabledBorder: outlineborder(),
                          hasFloatingPlaceholder: false,
                          labelText: "seu nome",
                          labelStyle: TextStyle(
                            color: Color(0xffA7A7A7),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
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
                        style: TextStyle(
                          color: Color(0xffA7A7A7),
                        ),
                        minLines: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusedBorder: outlineborder(),
                          border: outlineborder(),
                          enabledBorder: outlineborder(),
                          disabledBorder: outlineborder(),
                          hasFloatingPlaceholder: false,
                          labelText: "seu email",
                          labelStyle: TextStyle(
                            color: Color(0xffA7A7A7),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: size.width,
                      height: 50,
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
                        style: TextStyle(
                          color: Color(0xffA7A7A7),
                        ),
                        minLines: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusedBorder: outlineborder(),
                          border: outlineborder(),
                          enabledBorder: outlineborder(),
                          disabledBorder: outlineborder(),
                          hasFloatingPlaceholder: false,
                          labelText: "digita sua senha",
                          labelStyle: TextStyle(
                            color: Color(0xffA7A7A7),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: size.width,
                      height: 50,
                      child: TextFormField(
                        validator: (v) {
                          if (v != singUpBloc.password) {
                            return "Senhas incompatíveis";
                          }
                        },
                        maxLines: 1,
                        style: TextStyle(
                          color: Color(0xffA7A7A7),
                        ),
                        minLines: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          focusedBorder: outlineborder(),
                          border: outlineborder(),
                          enabledBorder: outlineborder(),
                          disabledBorder: outlineborder(),
                          hasFloatingPlaceholder: false,
                          labelText: "senha novamente",
                          labelStyle: TextStyle(
                            color: Color(0xffA7A7A7),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 50,
                    //   child: TextField(
                    //     onTap: () => showUploadImageDialog(),
                    //     maxLines: 1,
                    //     style: TextStyle(
                    //       color: Color(0xffA7A7A7),
                    //     ),
                    //     minLines: 1,
                    //     textAlign: TextAlign.center,
                    //     decoration: InputDecoration(
                    //       alignLabelWithHint: false,
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //         borderSide:
                    //             BorderSide(color: Colors.blue, width: 2),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //         borderSide:
                    //             BorderSide(color: Colors.blue, width: 2),
                    //       ),
                    //       hasFloatingPlaceholder: true,
                    //       hintText: 'Adicione uma imagem',
                    //       hintStyle: TextStyle(color: Color(0xffA7A7A7)),
                    //       suffixIcon: Icon(
                    //         Icons.cloud_upload,
                    //         color: Color(0xffA7A7A7),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 30),
                    Container(
                      height: 46,
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        color: Colors.blue,
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            "CADASTRAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () {
                          loginBloc.pageController.animateToPage(
                            0,
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.bounceOut,
                          );
                        },
                        child: Text(
                          "voltar para o login",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xffA7A7A7),
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
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

  void showUploadImageDialog() async {
    FocusScope.of(context).requestFocus(FocusNode());
    await showDialog(
      context: context,
      builder: (context) => StreamBuilder<String>(
          stream: singUpBloc.outPhoto,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == 'loading') {
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
                  child: CircularProgressIndicator(),
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
                      onPressed: () {
                        singUpBloc.setImageRegister(ImageSource.camera);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_photo_alternate,
                        color: Colors.blue,
                      ),
                      iconSize: 60,
                      onPressed: () {
                        singUpBloc.setImageRegister(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
