// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_bloc.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileBloc on _ProfileBloc, Store {
  final _$repeatPasswordAtom = Atom(name: '_ProfileBloc.repeatPassword');

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

  final _$responseAtom = Atom(name: '_ProfileBloc.response');

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
  Future<void> submit(User user) {
    return _$submitAsyncAction.run(() => super.submit(user));
  }
}
