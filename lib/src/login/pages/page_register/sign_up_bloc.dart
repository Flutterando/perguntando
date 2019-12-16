import 'package:mobx/mobx.dart';
import 'package:perguntando/src/login/models/sign_up_dto.dart';
import 'package:perguntando/src/shared/services/authentication_facade.dart';

part 'sign_up_bloc.g.dart';

class SignUpBloc extends _SignUpBloc with _$SignUpBloc {}

abstract class _SignUpBloc with Store {
  IAuthenticationFacade _authenticationFacade;

  @observable
  String name;

  @observable
  String email;

  @observable
  String password;

  @observable
  String repeatPassword;

  @observable
  ObservableFuture response = ObservableFuture.value(null);

  @action
  Future<void> submit() async {
    final signUpDto = SignUpDto(name, email, password);
    response = ObservableFuture(_authenticationFacade.signUp(signUpDto));
  }
}
