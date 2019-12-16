import 'package:mobx/mobx.dart';
import 'package:perguntando/src/shared/services/authentication_facade.dart';
import '../models/user_model.dart';
part 'authentication_bloc.g.dart';

class AuthenticationBloc extends _AuthenticationBloc with _$AuthenticationBloc {
  AuthenticationBloc(IAuthenticationFacade authenticationFacade)
      : super(authenticationFacade);
}

abstract class _AuthenticationBloc with Store {
  final IAuthenticationFacade _authenticationFacade;

  @observable
  User currentUser;

  @observable
  ObservableFuture<User> initialAuthenticated;

  _AuthenticationBloc(this._authenticationFacade) {
    initialAuthenticated =
        ObservableFuture(_authenticationFacade.initialAuthentication())
            .whenComplete(() {
      currentUser = initialAuthenticated.value;
    });
  }

  @action
  Future<void> signOut() async {
    currentUser = null;
    await _authenticationFacade.clearAuthentication();
  }
}
