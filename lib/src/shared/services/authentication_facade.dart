import 'package:perguntando/src/login/models/login_dto.dart';
import 'package:perguntando/src/login/models/sign_up_dto.dart';
import 'package:perguntando/src/profile/models/profile_dto.dart';
import 'package:perguntando/src/profile/repository/profile_repository.dart';
import 'package:perguntando/src/shared/models/iauth_repository.dart';
import 'package:perguntando/src/shared/models/itoken_store.dart';
import 'package:perguntando/src/shared/models/notification_model.dart';
import 'package:perguntando/src/shared/models/storage_store.dart';
import 'package:perguntando/src/shared/models/user_model.dart';
import 'package:perguntando/src/shared/models/user_store.dart';
import 'package:perguntando/src/shared/notification/notification_app.dart';
import 'package:perguntando/src/shared/services/credential_converter.dart';


abstract class IAuthenticationFacade {
  Future<User> initialAuthentication();

  Future<void> clearAuthentication();

  Future<User> login(LoginDto loginDto);

  Future<User> signUp(SignUpDto signUpDto);

  Future<User> update(UpdateUserDto profileDto);
}


class AuthenticationFacade implements IAuthenticationFacade {
  final CredentialConverter _credentialConverter;
  final IAuthenticationRepository _authRepository;
  final IProfileRepository _profileRepository;
  final UserStore _userStorage;
  final StorageStore<String> _credentialsStorage;
  final TokenStore _tokenStorage;
  final StorageStore<List<NotificationModel>> _notificationStorage;
  final NotificationApp _notificationApp;

  AuthenticationFacade(
      this._authRepository,
      this._userStorage,
      this._credentialsStorage,
      this._tokenStorage,
      this._notificationApp,
      this._notificationStorage,
      this._credentialConverter,
      this._profileRepository);

  @override
  Future<User> initialAuthentication() async {
    try {
      final user = await _userStorage.read();
      print(user);
      if (user != null) {
        final credentials = await _credentialsStorage.read("credentials");
        await _persist(credentials);
        await _notificationApp.setEmail(email: user.email);
      }
      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User> login(LoginDto loginDto) async {
    try {
      final authToken = _credentialConverter.generateCredential(
          loginDto.email, loginDto.password);
      final user = await _persist('Basic $authToken');
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> signUp(SignUpDto signUpDto) async {
    try {
      final authToken = _credentialConverter.generateCredential(
          signUpDto.email, signUpDto.password);
      final user = await _persist('Basic $authToken');
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> update(UpdateUserDto profileDto) async {
    try {
      final passwordSalt = _credentialConverter.md5Salt(profileDto.password);

      await _profileRepository.update(profileDto);

      final authToken = _credentialConverter.generateCredential(
          profileDto.email, passwordSalt);

      final user = await _persist('Basic $authToken');

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> _persist(String credentials) async {
    try {
      final data = await _authRepository.refreshToken(credentials);
      await _tokenStorage.save(data.token);
      await _userStorage.save(data.user);
      return data.user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearAuthentication() async {
    try {
      await _userStorage.delete();
      await _credentialsStorage.delete("credentials");
      await _tokenStorage.delete();
      await _notificationStorage.delete("notifications");
    } catch (e) {
      rethrow;
    }
  }
}
