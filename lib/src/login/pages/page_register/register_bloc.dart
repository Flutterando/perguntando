import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';

class RegisterBloc extends BlocBase {
  var nameController = TextEditingController();
  var mailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  
  @override
  void dispose() {
    super.dispose();
  }
}
