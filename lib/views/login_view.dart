import 'package:mynotes/views/logout_view.dart';
import 'package:mynotes/views/register_view.dart';

import '../services/auth_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'E-mail',
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () async {
                try {
                  final emal = _email.text;
                  final password = _password.text;

                  final UserCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emal, password: password);
                 await Navigator.of(context)
                      .pushNamedAndRemoveUntil('/logout/', (route) => false);
                } catch (eror) {
                  print('Something bad happened');
                  print(eror.runtimeType);
                  print(eror);
                  print(eror.hashCode);
                }
              },
              child: const Text('Log In'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/register/', (route) => false);
              },
              child: const Text('Not Register yet? Register here!'),
            ),
            TextButton(
              onPressed: () async {
                await AuthService()
                    .signInWithGoogle(); //finally, I able to Autheticate my app with google sign-in
                final user = FirebaseAuth.instance.currentUser;

                if (user != null) {
                  if (user.emailVerified) {
                    const LogOutView();
                    print(user.emailVerified);
                    print(user);
                  } else {
                    const RegisterView();
                  }
                } else {
                  const LoginView();
                }
              },
              child: const Text('Or Sign-up with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
