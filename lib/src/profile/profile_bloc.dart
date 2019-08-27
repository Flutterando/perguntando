import 'dart:developer';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:perguntando/src/profile/repository/profile_repository.dart';
import 'package:perguntando/src/shared/repositories/auth_repository.dart';
import 'package:perguntando/src/shared/utils/stream_validators.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc extends BlocBase with Validator {
  final _name = PublishSubject<String>();
  final _password = PublishSubject<String>();
  final _rePassword = PublishSubject<String>();
  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;

// colocar pra funcionar atualizando infos independentes

  ProfileBloc(this._profileRepository, this._authRepository) {
  validName = _name
          .transform(nameValidator)
          .asBroadcastStream();

  validPassword = _password
          .transform(passwordValidator)
          .asBroadcastStream();
  validRePassword = _rePassword
          .transform(passwordValidator)
          .asBroadcastStream();

  comparePassword = Observable
        .zip2<String, String, PasswordInfo>(
          validPassword, validRePassword,
          (password, rePassword) => PasswordInfo(password,rePassword))
          .transform(retypePasswordValidator)
          .map((e) => e.isNotEmpty ? _authRepository.generateMd5(e) as String : e)
          .asBroadcastStream();

  Observable
        .zip2<String,String,ProfileDto>
        (validName, comparePassword, (name,password) => ProfileDto(name, password))
        .asyncMap((e) => _profileRepository.updateUser(e))
        ..listen(null);

  }
 Observable<String> comparePassword;
  Observable<String> validName;
  Observable<String> validPassword;
  Observable<String> validRePassword;

  void nameEvent(String name) => _name.add(name);
  void passwordEvent(String password) => _password.add(password);
  void rePasswordEvent(String rePassword) => _rePassword.add(rePassword);

  @override
  void dispose() {
    _name.close();
    _password.close();
    _rePassword.close();
    super.dispose();
  }
}

