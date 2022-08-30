import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/views/logout_view.dart';
import 'package:mynotes/views/register_view.dart';

import '../services/auth_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import '../utilities/show_error_dialog.dart';

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
                final emal = _email.text;
                final password = _password.text;
                final user = FirebaseAuth.instance.currentUser;
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emal,
                    password: password,
                  );
                  //created
                  if (user == user?.emailVerified) {
                    await Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute,
                      (route) => false,
                    );
                  } else {
                    await Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyemailRoute,
                      (route) => false,
                    );
                  }

                  devtools.log(user.toString());
                } on FirebaseAuthException catch (eror) {
                  if (eror.code == 'user-not-found') {
                    await showErrorDialog(
                      context,
                      'User not found. Registration Please.',
                    );
                  } else if (eror.code == 'wrong-password') {
                    await showErrorDialog(
                      context,
                      'Wrong Password',
                    );
                  } else {
                    await showErrorDialog(context, 'Error: ${eror.code}');
                  }
                } catch (e) {
                  await showErrorDialog(
                    context,
                    e.toString(),
                  );
                }
              },
              child: const Text('Log In'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
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
                    devtools.log(user.emailVerified.toString());
                    devtools.log(user.toString());
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

