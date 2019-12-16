// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_bloc.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthenticationBloc on _AuthenticationBloc, Store {
  final _$currentUserAtom = Atom(name: '_AuthenticationBloc.currentUser');

  @override
  User get currentUser {
    _$currentUserAtom.context.enforceReadPolicy(_$currentUserAtom);
    _$currentUserAtom.reportObserved();
    return super.currentUser;
  }

  @override
  set currentUser(User value) {
    _$currentUserAtom.context.conditionallyRunInAction(() {
      super.currentUser = value;
      _$currentUserAtom.reportChanged();
    }, _$currentUserAtom, name: '${_$currentUserAtom.name}_set');
  }

  final _$initialAuthenticatedAtom =
      Atom(name: '_AuthenticationBloc.initialAuthenticated');

  @override
  ObservableFuture<User> get initialAuthenticated {
    _$initialAuthenticatedAtom.context
        .enforceReadPolicy(_$initialAuthenticatedAtom);
    _$initialAuthenticatedAtom.reportObserved();
    return super.initialAuthenticated;
  }

  @override
  set initialAuthenticated(ObservableFuture<User> value) {
    _$initialAuthenticatedAtom.context.conditionallyRunInAction(() {
      super.initialAuthenticated = value;
      _$initialAuthenticatedAtom.reportChanged();
    }, _$initialAuthenticatedAtom,
        name: '${_$initialAuthenticatedAtom.name}_set');
  }

  final _$signOutAsyncAction = AsyncAction('signOut');

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }
}
