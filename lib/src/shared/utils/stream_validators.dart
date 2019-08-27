import 'dart:async';

class Validator {
  final nameValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    String validated = value.trim();
    if (validated.split('').length >= 1) {
      sink.add(validated);
    } else {
      sink.addError("Insira um nome válido");
    }
  });
  final passwordValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
        String validated = value.trim();
    if (validated.isEmpty) {
      sink.add(value);
    } else {
      if (validated.length >= 6) {
        sink.add(validated);
      } else {
        sink.addError("Insira uma senha de no mínimo 6 caracteres");
      }
    }
  });

  final retypePasswordValidator =
      StreamTransformer<PasswordInfo, String>.fromHandlers(
          handleData: (value, sink) {
           
    if (value.password.isEmpty && value.retype.isEmpty) {
      sink.add(value.password);
    } else if (value.password.length >= 6 &&
        value.retype.length >= 6 &&
        value.password.compareTo(value.retype) == 0) {
      sink.add(value.password);
    } else {
      sink.addError("As senhas devem ser iguais");
    }
  });
}

class PasswordInfo {
  final String password;
  final String retype;

  PasswordInfo(this.password, this.retype);
}
