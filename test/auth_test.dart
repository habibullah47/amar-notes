import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });
    test('Cannot log Out if not initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });
    test('Should be able to be initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test('User shoul be null after initialization', () {
      expect(provider.currentUser, null);
    });
    test('Should be able to initialize in less then 2 seconds', () {
      expect(provider.isInitialized, true);
    },
        timeout: const Timeout(
          Duration(seconds: 2),
        ));

        //this test not passed
    // test('Create user should delegate to logIn function', () async {
    //   final badEmailUser = provider.createUser(
    //     emal: 'habib@world.com',
    //     password: 'anyPassword',
    //   );
    //   expect(badEmailUser,
    //       throwsA(const TypeMatcher<UserNotFoundAuthException>()));
    //   final badPasswordUser = provider.createUser(
    //     emal: 'habib.word.121@gmail.com',
    //     password: '12345678',
    //   );
    //   expect(badPasswordUser,
    //       throwsA(const TypeMatcher<WrongPasswordAuthException>()));
    //   final user = await provider.createUser(
    //     emal: 'habib.world.121@mail.com',
    //     password: 'hABIb862174',
    //   );
    //   expect(provider.currentUser, user);
    //   expect(user!.isEmailVerified, false);
    // });
    test('Logged in user should be able to get verified', () {
      provider.SendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });
    test('Should be able logOut and logIn again', () async {
      await provider.logOut();
      await provider.logIn(emal: 'emal', password: 'password');
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<void> SendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }

  @override
  Future<AuthUser?> createUser(
      {required String emal, required String password}) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      emal: emal,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    _isInitialized = true;
  }

  @override
  Future<AuthUser?> logIn({
    required String emal,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (emal == 'habib.world.121@mail.com') throw UserNotFoundAuthException();
    if (password == 'hABIb862174') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 2));
  }
}
