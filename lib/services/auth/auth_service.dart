import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  AuthService(this.provider);
  @override
  Future<void> SendEmailVerification() => provider.SendEmailVerification();

  @override
  Future<AuthUser?> createUser(
          {required String emal, required String password}) =>
      provider.createUser(
        emal: emal,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser?> logIn({required String emal, required String password}) =>
      provider.logIn(
        emal: emal,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();
}
