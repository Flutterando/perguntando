import 'package:flutter_test/flutter_test.dart';
import 'package:perguntando/src/shared/repositories/auth_repository.dart';

main() {
  test('Login Test', () async {
    AuthRepository authRepository = AuthRepository();
    var token = await authRepository.getToken(
        'sr.vasconcelos01@gmail.com', '123456789',isTest: true);
    print(token);
  });
}
