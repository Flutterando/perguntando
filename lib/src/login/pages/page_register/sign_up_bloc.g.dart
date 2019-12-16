// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_bloc.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpBloc on _SignUpBloc, Store {
  final _$nameAtom = Atom(name: '_SignUpBloc.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$emailAtom = Atom(name: '_SignUpBloc.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_SignUpBloc.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$repeatPasswordAtom = Atom(name: '_SignUpBloc.repeatPassword');

  @override
  String get repeatPassword {
    _$repeatPasswordAtom.context.enforceReadPolicy(_$repeatPasswordAtom);
    _$repeatPasswordAtom.reportObserved();
    return super.repeatPassword;
  }

  @override
  set repeatPassword(String value) {
    _$repeatPasswordAtom.context.conditionallyRunInAction(() {
      super.repeatPassword = value;
      _$repeatPasswordAtom.reportChanged();
    }, _$repeatPasswordAtom, name: '${_$repeatPasswordAtom.name}_set');
  }

  final _$responseAtom = Atom(name: '_SignUpBloc.response');

  @override
  ObservableFuture get response {
    _$responseAtom.context.enforceReadPolicy(_$responseAtom);
    _$responseAtom.reportObserved();
    return super.response;
  }

  @override
  set response(ObservableFuture value) {
    _$responseAtom.context.conditionallyRunInAction(() {
      super.response = value;
      _$responseAtom.reportChanged();
    }, _$responseAtom, name: '${_$responseAtom.name}_set');
  }

  final _$submitAsyncAction = AsyncAction('submit');

  @override
  Future<void> submit() {
    return _$submitAsyncAction.run(() => super.submit());
  }
}
