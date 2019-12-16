import 'package:mobx/mobx.dart';
import 'package:perguntando/src/profile/models/profile_dto.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:perguntando/src/shared/services/authentication_facade.dart';
part 'profile_bloc.g.dart';

class ProfileBloc extends _ProfileBloc with _$ProfileBloc {
  ProfileBloc(IAuthenticationFacade authenticationFacade)
      : super(authenticationFacade);
}

abstract class _ProfileBloc with Store {
  final IAuthenticationFacade _authenticationFacade;

  String name;

  String password;

  @observable
  String repeatPassword;

  @observable
  ObservableFuture response = ObservableFuture.value(null);

  _ProfileBloc(this._authenticationFacade);

  @action
  Future<void> submit(User user) async {
    final profileDto =
        UpdateUserDto(name.trim(), password.trim(), user.email, user.id);
    response = ObservableFuture(_authenticationFacade.update(profileDto));
  }
}

String validateName(String value) {
  String validated = value.trim();
  if (validated.split('').length >= 1) {
    return null;
  } else {
    return "Insira um nome válido";
  }
}

String validatePassword(String value) {
  String validated = value.trim();
  if (validated.isEmpty) {
    return null;
  } else {
    if (validated.length >= 6) {
      return null;
    } else {
      return "Insira uma senha de no mínimo 6 caracteres";
    }
  }
}

String validateRepeatPassowrd(String value, String repeat) {
  final password = value.trim();
  final repeatPassword = repeat.trim();
  if (password.compareTo(repeatPassword) == 0) {
    return null;
  } else {
    return "As senhas devem ser iguais";
  }
}
