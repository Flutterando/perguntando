import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perguntando/src/login/login_module.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:perguntando/src/shared/utils/constants.dart';
import 'package:perguntando/src/shared/utils/convert_Md5.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../login_bloc.dart';

class SignUpBloc extends BlocBase {
  final singUpformKey = GlobalKey<FormState>();
  final userRegister = UserModel();
  final loginBloc = LoginModule.to.bloc<LoginBloc>();
  final imageUrl = '$API_URL/auth/v1/uploads/upload-047798770.png';

  String email;
  String name;
  String password;

  final _photoController = BehaviorSubject<String>();
  Observable<String> get outPhoto => _photoController.stream;
  final _erroController = BehaviorSubject<String>();
  Observable<String> get outError => _erroController.stream;
  final _loadingController = BehaviorSubject<bool>();
  Observable<bool> get outLoading => _loadingController.stream;

  Future<void> onSingUp() async {
    _loadingController.add(true);
    if (singUpformKey.currentState.validate()) {
      singUpformKey.currentState.save();
      userRegister.email = email;
      userRegister.name = name;
      userRegister.photo = _photoController.value;
      userRegister.password = password;
      //TODO mover para a pagina do CheckLogin;
      userRegister.password = convertMd5(userRegister.password);
      userRegister.code = generatorPinCode;
      print(userRegister.code);
      try {
        final _dio = Dio();
        final response = await _dio.post(
          '$API_URL/auth/v1/checkMail',
          data: userRegister.toJson(),
        );
        loginBloc.pageController.animateToPage(2,
            duration: Duration(milliseconds: 1000), curve: Curves.ease);
      } on DioError catch (e) {
        _erroController.addError(e.message);
      }
    }
    _loadingController.add(false);
  }

  int get generatorPinCode {
    final stringCode =
        DateTime.now().microsecondsSinceEpoch.toString().substring(0, 4);
    return int.parse(stringCode);
  }

  Future<void> setImageRegister(ImageSource imageSource) async {
    _photoController.add('loading');
    final _imageFile = await getImageFile(imageSource);
    if (_imageFile != null) {
      final _imageUrl = await uploadImageFile(_imageFile);
      final imageUrl = '$API_URL/auth/v1/$_imageUrl';
      _photoController.add(imageUrl);
    }
  }

  Future<File> getImageFile(ImageSource imageSource) async {
    final _imageFile = await ImagePicker.pickImage(source: imageSource);
    if (_imageFile.isAbsolute) {
      final _result = await FlutterImageCompress.compressAndGetFile(
        _imageFile.absolute.path,
        _imageFile.absolute.path,
        format: CompressFormat.jpeg,
        quality: 60,
      );
      return _result;
    }
  }

  Future<String> uploadImageFile(File _imageFile) async {
    final _dio = Dio();
    final _nameFile = _imageFile.path.split('/').last;
    FormData _data = new FormData.from({
      'file': UploadFileInfo(_imageFile, _nameFile),
    });
    try {
      Response response = await _dio.post(
        '$API_URL/auth/v1/upload',
        data: _data,
      );
      return response.data['file'];
    } on DioError catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _loadingController.close();
    _erroController.close();
    _photoController.close();
    super.dispose();
  }
}
