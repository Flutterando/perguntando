import 'package:mobx/mobx.dart';
import 'package:perguntando/src/login/models/login_dto.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:perguntando/src/shared/services/authentication_facade.dart';

part 'sign_in_bloc.g.dart';

class SignInBloc extends _SignInBloc with _$SignInBloc {
  SignInBloc(IAuthenticationFacade authenticationFacade)
      : super(authenticationFacade);
}

abstract class _SignInBloc with Store {
  final IAuthenticationFacade _authenticationFacade;

  @observable
  String email;

  @observable
  String password;

  @observable
  ObservableFuture<User> response = ObservableFuture.value(null);

  _SignInBloc(this._authenticationFacade);

  @action
  void submit() {
    response = ObservableFuture(
      _authenticationFacade.login(
        LoginDto(email, password),
      ),
    );
  }
}
